module MarketData

using Dates, TimeSeries, Reexport
@reexport using Dates, TimeSeries

export AAPL, 
       BA, 
       CAT, 
       sdata, cl, op, ohlc, ohlcv # datasets for testing

  # US Equities from A to C (so far) 
  const AAPL = readtimearray(Pkg.dir("MarketData/data/AAPL.csv"))
  const BA   = readtimearray(Pkg.dir("MarketData/data/BA.csv"))
  const CAT  = readtimearray(Pkg.dir("MarketData/data/CAT.csv"))

  # smaller datasets used for testing time-related packages
  const sdata = readtimearray(Pkg.dir("MarketData/data/sdata.csv"))["Close"]
  const cl    = AAPL["Close"][Date(2000,1,1):Date(2001,12,31)]
  const op    = AAPL["Open"][Date(2000,1,1):Date(2001,12,31)]
  const ohlc  = AAPL["Open", "High", "Low", "Close"][Date(2000,1,1):Date(2001,12,31)] 
  const ohlcv = AAPL["Open", "High", "Low", "Close", "Volume"][Date(2000,1,1):Date(2001,12,31)] 

end
