abstract type AbstractQueryOpt <: AbstractDict{Symbol,Any} end

Base.length(::T) where {T<:AbstractQueryOpt} = fieldcount(T)
Base.length(::Type{T}) where {T<:AbstractQueryOpt} = fieldcount(T)

function Base.iterate(aqo::T, state = 1) where {T<:AbstractQueryOpt}
  (state > length(T)) && return nothing
  (fieldname(T, state) => getfield(aqo, state), state + 1)
end

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
    csv = CSV.File(res.body, missingstring = ".")
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
        ta = TimeArray((timestamp = dates, monthly = values), timestamp = :timestamp)
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
