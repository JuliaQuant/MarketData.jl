abstract type AbstractQueryOpt <: AbstractDict{Symbol,Any} end

Base.length(::T) where {T<:AbstractQueryOpt} = fieldcount(T)
Base.length(::Type{T}) where {T<:AbstractQueryOpt} = fieldcount(T)

function Base.iterate(aqo::T, state = 1) where {T<:AbstractQueryOpt}
  (state > length(T)) && return nothing
  (fieldname(T, state) => getfield(aqo, state), state + 1)
end

struct APIError <: Exception
  errmsg::String
  res::HTTP.Messages.Response
end
Base.showerror(io::IO, e::APIError) = print(io, "Error message from API: ", e.errmsg, "\nfrom query: $(HTTP.unescapeuri(HTTP.uri(e.res.request)))")
struct InvalidAPIReturn <: Exception
  expected::String
  res::HTTP.Messages.Response
end
Base.showerror(io::IO, e::InvalidAPIReturn) = print(io, "Expected type: $(e.expected), API returned: $(Dict(e.res.headers)["Content-Type"])\nfrom query: $(HTTP.unescapeuri(HTTP.uri(e.res.request)))")

"""
    struct YahooOpt <: AbstractQueryOpt
      period1  # the start time
      period2  # the end time
      interval # "1d", "1wk" or "1mo"
      events   # currently only `:history` supported
    end

The Yahoo Finance HTTP API query object.

# Examples

```jl-repl
julia> t = Dates.now()
2020-08-09T01:38:04.735

julia> YahooOpt(period1 = t - Year(2), period2 = t)
YahooOpt{DateTime} with 4 entries:
  :period1  => 1533778685
  :period2  => 1596937085
  :interval => "1d"
  :events   => :history
```
"""
struct YahooOpt <: AbstractQueryOpt
  period1::DateTime
  period2::DateTime
  interval::String
  events::Symbol

  YahooOpt(; period1::DateTime = DateTime(1971, 2, 8),
          period2::DateTime = Dates.now(),
          interval::String  = "1d",
          events::Symbol    = :history) =
    new(period1, period2, interval, events)
end

function Base.iterate(opt::YahooOpt, state = 1)
  (state > length(YahooOpt)) && return nothing
  k = fieldname(YahooOpt, state)
  v = getfield(opt, state)
  v′ = (k ∈ (:period1, :period2)) ? round(Int, datetime2unix(v)) : v
  (k => v′, state + 1)
end

"""
    yahoo(symbol::AbstractString, opt::YahooOpt = YahooOpt())::TimeArray
    yahoo(symbol::Symbol, opt::YahooOpt = YahooOpt())::TimeArray

This is a wrapper for downloading historical stock prices from Yahoo Finance.

The yahoo method takes a stock name in the form of a string and returns a
`TimeSeries.TimeArray` corresponding to the Yahoo Finance ticker.
With no argument, the default historical time series is the S&P 500.

# Examples

```julia
AAPL = yahoo(:AAPL)
SPX = yahoo("^GSPC")
NQ = yahoo("^IXIC")
```

```jl-repl
julia> start = DateTime(2018, 1, 1)
2018-01-01T00:00:00

julia> yahoo(:AAPL, YahooOpt(period1 = start))
655×6 TimeArray{Float64,2,Date,Array{Float64,2}} 2018-01-02 to 2020-08-07
...
```

# References

  https://finance.yahoo.com

# See Also

- fred()  which accesses the St. Louis Federal Reserve financial and economic data sets.
- ons()   which is a wrapper to download financial and economic time series data from the Office for National Statistics (ONS).
"""
function yahoo(sym::AbstractString = "^GSPC", opt::YahooOpt = YahooOpt())
    host = rand(["query1", "query2"])
    url  = "https://$host.finance.yahoo.com/v7/finance/download/$sym"
    res  = HTTP.get(url, query = opt)
    @assert res.status == 200
    csv = CSV.File(res.body, missingstring = "null")
    sch = TimeSeries.Tables.schema(csv)
    TimeArray(csv, timestamp = first(sch.names)) |> cleanup_colname!
end

yahoo(s::Symbol, opt::YahooOpt = YahooOpt()) = yahoo(string(s), opt)

"""
  fred(data::String="CPIAUCNS")::TimeArray

The fred() method is a wrapper to download financial and economic time series data from the St. Louis Federal Reserve (FRED).

The fred() method takes a string argument that corresponds to a series code from the St. Louis Federal
Reserve (FRED) database. It returns the data in the TimeSeries.TimeArray data structure.  When no argument
is provided, the default data set is the Consumer Price Index for All Urban Consumers: All Items (CPIAUCNS).

# Examples

```julia
DGS = fred("DGS10")
CPI = fred()
```

# References

https://research.stlouisfed.org/fred2

# See Also

- yahoo() which is a wrapper to download financial time series for stocks from Yahoo Finance.
- ons()   which is a wrapper to download financial and economic time series data from the Office for National Statistics (ONS).
"""
function fred(data::AbstractString="CPIAUCNS")
    url = "http://research.stlouisfed.org/fred2/series/$data/downloaddata/$data.csv"
    res = HTTP.get(url)
    @assert res.status == 200
    csv = CSV.File(res.body)
    sch = TimeSeries.Tables.schema(csv)
    TimeArray(csv, timestamp = first(sch.names)) |> cleanup_colname!
end

"""
    ons(timeseries::String="L522", dataset::String="MM23")::TimeArray

The ons() method is a wrapper to download financial and economic time series data from the Office for National Statistics (ONS).

The ons() method takes two string arguments corresponding to a dataset and timeseries code from 
the ONS database, to explore the database, you can use https://www.ons.gov.uk/timeseriestool.
It returns the data in the TimeSeries.TimeArray data structure with additional information in the meta field.
The data might include monthly values, quarterly averages and yearly averages, with column names
monthly, quarterly and yearly.
The timestamps are the first day of the period.  When no argument is provided, the default dataset 
is the Consumer Price Index including housing costs (CPIH) which is the ONS’s headline measure of inflation.

# Examples

```julia
UK_RPI = ("CHAW","MM23")
UK_CPI = ("D7BT","MM23")
UK_CPIH = ("L522","MM23")
```

# References

https://www.ons.gov.uk/timeseriestool

# See Also

- fred() which accesses the St. Louis Federal Reserve financial and economic data sets.
- yahoo() which is a wrapper from downloading financial time series for stocks from Yahoo Finance.
"""
function ons(timeseries::AbstractString = "L522", dataset::AbstractString = "MM23")
    url = "https://api.ons.gov.uk/dataset/$dataset/timeseries/$timeseries/data"
    res = HTTP.get(url)
    @assert res.status == 200
    json = JSON3.read(HTTP.payload(res))
    ta = nothing
    if "months" in keys(json)
        data = json["months"]
        dates = [Date(x["year"]*" "*x["month"], dateformat"Y U") for x in data]
        values = [parse(Float64, x["value"]) for x in data]
        ta = TimeArray((timestamp = dates, monthly = values),timestamp=:timestamp)
    end
    if "quarters" in keys(json)
        data = json["quarters"]
        dates = [Date(x["year"]*" "*string(parse(Int, x["quarter"][2])*3-2),dateformat"Y m") for x in data]
        values = [parse(Float64,x["value"]) for x in data]
        tb = TimeArray((timestamp = dates, quarterly = values), timestamp = :timestamp)
        ta === nothing ? ta = tb : ta = merge(ta, tb; method = :outer)
    end
    if "years" in keys(json)
        data = json["years"]
        dates = [Date(x["year"]) for x in data]
        values = [parse(Float64, x["value"]) for x in data]
        tb = TimeArray((timestamp = dates, yearly = values), timestamp = :timestamp)
        ta === nothing ? ta = tb : ta = merge(ta, tb; method = :outer)
    end
    TimeArray(ta, meta = json["description"])
end

"""
    struct BoeOpt <: AbstractQueryOpt
      datefrom    # the start time
      dateto      # the end time
      usingcodes  # indicate using series codes
      csvf        # "TT" (Tabular with titles), "TN" (Tabular no titles), "CT" (Columnar with- titles) or "CN" (Columnar no titles)
      vpd         # provisional data is required
    end

The Bank of England Database API query object.

# Examples

```jl-repl
julia> t = Dates.today()
2022-04-06

julia> BoeOpt(datefrom = t - Year(2), dateto = t)
BoeOpt with 5 entries:
  :datefrom   => "06/Apr/2020"
  :dateto     => "06/Apr/2022"
  :usingvodes => "Y"
  :csvf       => "TN"
  :vpd        => "Y"
```
"""
struct BoeOpt <: AbstractQueryOpt
  datefrom::Date
  dateto::Date
  usingcodes::Bool
  csvf::String
  vpd::Bool

  BoeOpt(;  datefrom::Date = Date(1963, 1, 1),
            dateto::Date = Dates.today(),
            usingcodes::Bool = true,
            csvf::String = "TN",
            vpd::Bool = true
    ) =
    new(datefrom, dateto, usingcodes, csvf, vpd)
end

function Base.iterate(opt::BoeOpt, state = 1)
  (state > length(BoeOpt)) && return nothing
  k = fieldname(BoeOpt, state)
  v = getfield(opt, state)
  v′ = v isa Date ? Dates.format(v,dateformat"dd/u/yyyy") : v isa Bool ? v ? "Y" : "N" : v
  (k => v′, state + 1)
end

"""
  boe(seriescode::String="IUDSOIA")::TimeArray

The boe() method is a wrapper to download financial and economic time series data from the Bank of England (BoE) database.

The boe() method takes a string argument that corresponds to a series code from the BoE database.
It returns the data in the TimeSeries.TimeArray data structure.  When no argument is provided, the
default data set is the daily Sterling Overnight Index Average (SONIA) rate.

# Examples

```julia
GBPUSD = boe("XUDLGBD")
SONIA = boe()
```

```jl-repl
julia> start = Date(2018, 1, 1)
2018-01-01

julia> boe(:IUDSOIA, BoeOpt(datefrom = start))
1078×1 TimeArray{Float64, 1, Date, Vector{Float64}} 2018-01-02 to 2022-04-04
│            │ IUDSOIA │
├────────────┼─────────┤
│ 2018-01-02 │ 0.4622  │
│ 2018-01-03 │ 0.4642  │
...

julia> boe("XUDLGBD,XUDLERS", BoeOpt(datefrom = start))
1079×2 TimeArray{Float64, 2, Date, Matrix{Float64}} 2018-01-02 to 2022-04-05
│            │ XUDLGBD │ XUDLERS │
├────────────┼─────────┼─────────┤
│ 2018-01-02 │ 0.7364  │ 1.1274  │
│ 2018-01-03 │ 0.74    │ 1.124   │
...
```

# References

https://www.bankofengland.co.uk/boeapps/database/
https://www.bankofengland.co.uk/boeapps/database/Help.asp#CSV
https://www.bankofengland.co.uk/statistics/details

# See Also

- yahoo() which is a wrapper to download financial time series for stocks from Yahoo Finance.
- fred()  which accesses the St. Louis Federal Reserve financial and economic data sets.
- ons()   which is a wrapper to download financial and economic time series data from the Office for National Statistics (ONS).
"""
function boe(seriescodes::AbstractString = "IUDSOIA", opt::BoeOpt = BoeOpt())
    url = "http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp"
    parameters = Dict(
      "csv.x" => "yes",
      "SeriesCodes" => seriescodes
    )
    res  = HTTP.get(url, query = merge(parameters,Dict(opt)))
    @assert res.status == 200
    if Dict(res.headers)["Content-Type"] != "application/csv"
      if Dict(res.headers)["Content-Type"] == "text/html"
        mat = match(r"<p class=\"error\">\s+([\w\s]+)",String(res.body))
        !isnothing(mat) && throw(APIError(string(mat.captures[1]),res))
      end
      throw(InvalidAPIReturn("application/csv",res))
    end
    csv = CSV.File(res.body, dateformat=dateformat"dd u yyyy")
    sch = TimeSeries.Tables.schema(csv)
    TimeArray(csv, timestamp = first(sch.names)) |> cleanup_colname!
end
boe(s::Symbol, opt::BoeOpt = BoeOpt()) = boe(string(s), opt)
