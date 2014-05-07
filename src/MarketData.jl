using Datetime, TimeSeries

module MarketData

using Datetime, TimeSeries

export AAPL, 
       BA, 
       CAT, 
       cl, op, ohlc # datasets for testing

  # US Equities from A to C (so far) 
  const AAPL = readtimearray(Pkg.dir("MarketData/data/AAPL.csv"))
  const BA   = readtimearray(Pkg.dir("MarketData/data/BA.csv"))
  const CAT  = readtimearray(Pkg.dir("MarketData/data/CAT.csv"))

  # smaller datasets used for testing time-related packages
  const cl   = AAPL["Close"][date(2000,1,1):date(2001,12,31)]
  const op   = AAPL["Open"][date(2000,1,1):date(2001,12,31)]
  const ohlc = AAPL["Open", "High", "Low", "Close"][date(2000,1,1):date(2001,12,31)] 


end
