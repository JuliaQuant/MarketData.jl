VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

using Base.Dates, TimeSeries

module MarketData

using Base.Dates, TimeSeries

export AAPL,
       BA,
       CAT,
       cl, op, ohlc, ohlcv,
       datetime1, datetime2

  # US Equities from A to C (so far) 
  const AAPL = readtimearray(Pkg.dir("MarketData/data/AAPL.csv"), meta="AAPL")
  const BA   = readtimearray(Pkg.dir("MarketData/data/BA.csv"), meta="BA")
  const CAT  = readtimearray(Pkg.dir("MarketData/data/CAT.csv"), meta="CAT")

  # smaller datasets used for testing time-related packages
  const cl        = AAPL["Close"][Date(2000,1,1):Date(2001,12,31)]
  const op        = AAPL["Open"][Date(2000,1,1):Date(2001,12,31)]
  const ohlc      = AAPL["Open", "High", "Low", "Close"][Date(2000,1,1):Date(2001,12,31)] 
  const ohlcv     = AAPL["Open", "High", "Low", "Close", "Volume"][Date(2000,1,1):Date(2001,12,31)] 
  const datetime1 = readtimearray(Pkg.dir("MarketData/data/datetime1.csv"))
  const datetime2 = readtimearray(Pkg.dir("MarketData/data/datetime2.csv"), format="yyyy-mm-dd HH:MM:SS")

end
