
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
  const dates = Date(2000,1,1):Day(1):Date(2001,12,31)
  const cl        = AAPL[:Close][dates]
  const op        = AAPL[:Open][dates]
  const ohlc      = AAPL[:Open, :High, :Low, :Close][dates]
  const ohlcv     = AAPL[:Open, :High, :Low, :Close, :Volume][dates]
  const datetime1 = readtimearray(joinpath(DATADIR, "datetime1.csv"))
  const datetime2 = readtimearray(joinpath(DATADIR, "datetime2.csv"),
                                  format="yyyy-mm-dd HH:MM:SS")
  const mdata     = TimeArray(timestamp(cl), values(cl), colnames(cl), "Apple") # data with meta field occupied
