module MarketData

using CSV
using Dates
using Dates: datetime2unix
using HTTP
using Random
using Reexport
using TimeSeries
using JSON3

@reexport using TimeSeries

export AAPL, BA, CAT, DELL, EBAY, F, GE, TX,
        APIError, InvalidAPIReturn,
       cl, op, ohlc, ohlcv, datetime1, datetime2, mdata,
       o, h, l, c, v
export random_cl, random_vol, random_ohlc, random_ohlcv
# downloads.jl
export AbstractQueryOpt,
       YahooOpt,
       BoeOpt,
       yahoo, fred, ons, boe

###### include ##################

include("utils.jl")
include("const.jl")
include("random.jl")
include("helpers.jl")
include("downloads.jl")

end
