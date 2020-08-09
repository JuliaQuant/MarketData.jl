
const DATADIR = joinpath(dirname(pathof(@__MODULE__)), "..", "data")

# US Equities from A to E (so far)

for i ∈ [:AAPL, :BA, :CAT, :DELL, :EBAY, :F, :GE, :TX]
  ex = :(
    const $i = readtimearray(joinpath(DATADIR, $("$i.csv")), meta = $("$i")) |> cleanup_colname!)
  eval(ex)
end

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
