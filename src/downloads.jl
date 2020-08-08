import TimeSeries.TimeArray


struct APIResponse
    data::String
    http_resp::HTTP.Messages.Response
end

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

  fred() which accesses the St. Louis Federal Reserve financial and economic data sets.
"""
function yahoo(sym::AbstractString = "^GSPC", opt::YahooOpt = YahooOpt())
    host = rand(["query1", "query2"])
    url  = "https://$host.finance.yahoo.com/v7/finance/download/$sym"
    res  = HTTP.get(url, query = opt)
    @assert res.status == 200
    csv = CSV.File(res.body, missingstrings = ["null"])
    sch = TimeSeries.Tables.schema(csv)
    TimeArray(csv, timestamp = first(sch.names))
end

yahoo(s::Symbol, opt::YahooOpt = YahooOpt()) = yahoo(string(s), opt)

"""
Description

    The fred() method is a wrapper to download financial and economic time series data from the St. Louis Federal Reserve (FRED).

Usage

    DGS = fred("DGS10")
    CPI = fred()

Method Signature(s)

    fred(data::String="CPIAUCNS")

Details

    The fred() method takes a string argument that corresponds to a series code from the St. Louis Federal
    Reserve (FRED) database. It returns the data in the TimeSeries.TimeArray data structure.  When no argument
    is provided, the default data set is the Consumer Price Index for All Urban Consumers: All Items (CPIAUCNS).

References

    https://research.stlouisfed.org/fred2

See Also

    yahoo() which is a wrapper from downloading financial time series for stocks from Yahoo Finance.
"""
function fred(data::String="CPIAUCNS")
    url = "http://research.stlouisfed.org/fred2/series/$data/downloaddata/$data.csv"
    res = HTTP.get(url)
    @assert res.status == 200
    csv = CSV.File(res.body)
    sch = TimeSeries.Tables.schema(csv)
    TimeArray(csv, timestamp = first(sch.names))
end

