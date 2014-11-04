[![Build Status](https://travis-ci.org/JuliaQuant/MarketData.jl.png)](https://travis-ci.org/JuliaQuant/MarketData.jl)
[![MarketData](http://pkg.julialang.org/badges/MarketData_release.svg)](http://pkg.julialang.org/?pkg=MarketData&ver=release)
[![Coverage Status](https://coveralls.io/repos/JuliaQuant/MarketData.jl/badge.png?branch=master)](https://coveralls.io/r/JuliaQuant/MarketData.jl?branch=master)

MarketData includes historical financial time series datasets from the Quandl Open Data source. The package provides the data in a TimeArray, which is the TimeSeries data structure.

````julia
julia> Pkg.add("MarketData")

julia> using MarketData
````
Current datasets are enumerated alphabetically, with the first dataset representing `AAPL`. 

````julia
julia> AAPL
8336x12 TimeArray{Float64,2} 1980-12-12 to 2013-12-31

             Open    High    Low     Close   Volume        Ex-Dividend  Split Ratio  Adj. Open  Adj. High  Adj. Low  Adj. Close  Adj. Volume
1980-12-12 | 28.75   28.88   28.75   28.75   2.0939e6      0.0          1.0          3.38       3.39       3.38      3.38        1.67512e7
1980-12-15 | 27.38   27.38   27.25   27.25   785200.0      0.0          1.0          3.22       3.22       3.2       3.2         6.2816e6
1980-12-16 | 25.38   25.38   25.25   25.25   472000.0      0.0          1.0          2.98       2.98       2.97      2.97        3.776e6
1980-12-17 | 25.88   26.0    25.88   25.88   385900.0      0.0          1.0          3.04       3.05       3.04      3.04        3.0872e6
⋮
2013-12-26 | 568.1   569.5   563.38  563.9   7.286e6       0.0          1.0          564.74     566.13     560.05    560.56      7.286e6
2013-12-27 | 563.82  564.41  559.5   560.09  8.0673e6      0.0          1.0          560.48     561.07     556.19    556.78      8.0673e6
2013-12-30 | 557.46  560.09  552.32  554.52  9.0582e6      0.0          1.0          554.16     556.78     549.05    551.24      9.0582e6
2013-12-31 | 554.17  561.28  554.0   561.02  7.9673e6      0.0          1.0          550.89     557.96     550.72    557.7       7.9673e6
````

Data can easily be converted into other data structures. For example, converting the `AAPL` TimeArray into a DataFrame is as simple as this:

````julia
julia> Apple = DataFrame(Date = AAPL.timestamp, Close = AAPL["Close"].values);

julia> head(Apple)
6x2 DataFrame
|-------|------------|-------|
| Row # | Date       | Close |
| 1     | 1980-12-12 | 28.75 |
| 2     | 1980-12-15 | 27.25 |
| 3     | 1980-12-16 | 25.25 |
| 4     | 1980-12-17 | 25.88 |
| 5     | 1980-12-18 | 26.62 |
| 6     | 1980-12-19 | 28.25 |
````

