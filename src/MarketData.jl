VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

module MarketData

using TimeSeries

export AAPL, BA, CAT, DELL, EBAY, F, GE,
       cl, op, ohlc, ohlcv, datetime1, datetime2, mdata,
       o, h, l, c, v

###### include ##################

include("const.jl")
include("helpers.jl")

end
