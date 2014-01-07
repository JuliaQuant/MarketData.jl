using Datetime, Series

module MarketData

using Datetime, Series

export op, hi, lo, cl, vm, aj,  
       opm, him, lom, clm, vmm, ajm,  
       firstday, secondday, tenthday, lastday, 
       firstmonth, lastmonth, 
       SeriesPairDateFloat64, ArraySeriesPairDateFloat64

  # objects to test values
  const op  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=2)
  const hi  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=3)
  const lo  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=4)
  const cl  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=5)
  const vm  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=6)
  const aj  = readseries(Pkg.dir("MarketData/data/daily_spx_from_1980_to_1981.csv"), value=7)
  const opm = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=2)
  const him = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=3)
  const lom = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=4)
  const clm = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=5)
  const vmm = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=6)
  const ajm = readseries(Pkg.dir("MarketData/data/monthly_spx_from_1980_to_1989.csv"), value=7)
  
  # const to test dates
  const firstday   = date(1980,1,3)
  const secondday  = date(1980,1,4)
  const tenthday   = date(1980,1,16)
  const lastday    = date(1981,12,31)
  const firstmonth = date(1980,1,3)
  const lastmonth  = date(1989,12,1)

  # const to test structure
  const SeriesPairDateFloat64 = eval(:(SeriesPair{Date{ISOCalendar}, Float64}))
  const ArraySeriesPairDateFloat64 = eval(:(Array{SeriesPair{Date{ISOCalendar}, Float64}, 1}))

end
