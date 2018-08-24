
  const DATADIR = joinpath(dirname(pathof(@__MODULE__)), "..", "data")

  # US Equities from A to E (so far)
  const AAPL = readtimearray(joinpath(DATADIR, "AAPL.csv"), meta = "AAPL")
  const BA   = readtimearray(joinpath(DATADIR, "BA.csv"),   meta = "BA")
  const CAT  = readtimearray(joinpath(DATADIR, "CAT.csv"),  meta = "CAT")
  const DELL = readtimearray(joinpath(DATADIR, "DELL.csv"), meta = "DELL")
  const EBAY = readtimearray(joinpath(DATADIR, "EBAY.csv"), meta = "EBAY")
  const F    = readtimearray(joinpath(DATADIR, "F.csv"),    meta = "F")
  const GE   = readtimearray(joinpath(DATADIR, "GE.csv"),   meta = "GE")
  const TX   = readtimearray(joinpath(DATADIR, "TX.csv"),   meta = "TX")

  # smaller datasets used for testing time-related packages
  const cl        = AAPL["Close"][Date(2000,1,1):Date(2001,12,31)]
  const op        = AAPL["Open"][Date(2000,1,1):Date(2001,12,31)]
  const ohlc      = AAPL["Open", "High", "Low", "Close"][Date(2000,1,1):Date(2001,12,31)]
  const ohlcv     = AAPL["Open", "High", "Low", "Close", "Volume"][Date(2000,1,1):Date(2001,12,31)]
  const datetime1 = readtimearray(joinpath(DATADIR, "datetime1.csv"))
  const datetime2 = readtimearray(joinpath(DATADIR, "datetime2.csv"), format="yyyy-mm-dd HH:MM:SS")
  const mdata     = TimeArray(cl.timestamp, cl.values, cl.colnames, "Apple") # data with meta field occupied
