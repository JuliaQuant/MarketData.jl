MarketData includes historical financial time series datasets. The package provides the data in a TimeArray, which is the TimeSeries data structure.

````julia
julia> Pkg.add("MarketData")

julia> using MarketData
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
