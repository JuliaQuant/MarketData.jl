using Datetime, TimeArrays

module MarketData

using Datetime, TimeArrays

export ohlc, op, hi, lo, cl, vm, aj,  
       OHLC, Op, Hi, Lo, Cl, Vm, Aj,  
       ohlcm, opm, him, lom, clm, vmm, ajm,  
       firstday, secondday, tenthday, lastday, 
       firstmonth, secondmonth, lastmonth

  # objects to test values
  const ohlc  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const op    = ohlc["Open"] 
  const hi    = ohlc["High"] 
  const lo    = ohlc["Low"] 
  const cl    = ohlc["Close"] 
  const vm    = ohlc["Volume"] 
  const aj    = ohlc["Adj Cl"] 
  const OHLC  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Op    = OHLC["Open"] 
  const Hi    = OHLC["High"] 
  const Lo    = OHLC["Low"] 
  const Cl    = OHLC["Close"] 
  const Vm    = OHLC["Volume"]
  const Aj    = OHLC["Adj Cl"]
  const ohlcm = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const opm   = ohlcm["Open"] 
  const him   = ohlcm["High"] 
  const lom   = ohlcm["Low"] 
  const clm   = ohlcm["Close"] 
  const vmm   = ohlcm["Volume"]
  const ajm   = ohlcm["Adj Cl"]
  
  # const to test dates
  const firstday    = date(1980,1,3)
  const secondday   = date(1980,1,4)
  const tenthday    = date(1980,1,16)
  const lastday     = date(1981,12,31)
  const firstmonth  = date(1980,1,3)
  const secondmonth = date(1980,2,1)
  const lastmonth   = date(1989,12,1)

  # const to test structure

end
