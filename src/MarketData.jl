using Datetime, TimeArrays

module MarketData

using Datetime, TimeArrays

export op, hi, lo, cl, vm, aj,  
       Op, Hi, Lo, Cl, Vm, Aj,  
       opm, him, lom, clm, vmm, ajm,  
       firstday, secondday, tenthday, lastday, 
       firstmonth, secondmonth, lastmonth

  # objects to test values
  const op  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const hi  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const lo  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const cl  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const vm  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const aj  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"))
  const Op  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Hi  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Lo  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Cl  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Vm  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const Aj  = readtimearray(Pkg.dir("MarketData/data/daily_spx_from_1950_to_2013.csv"))
  const opm = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const him = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const lom = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const clm = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const vmm = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  const ajm = readtimearray(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"))
  
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
