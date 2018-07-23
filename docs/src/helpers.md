# Helper methods

Single-letter methods are provided to make it easier to extract specific
financial time series columns. The five column names that are supported
include `o()` for Open, `h()` for High, `l()` for Low, `c()` for Close
and `v()` for Volume.:

    julia> o(AAPL)
    8336x1 TimeSeries.TimeArray{Float64,1,Date,Array{Float64,1}} 1980-12-12 to 2013-12-31

    Open
    1980-12-12 | 28.75
    1980-12-15 | 27.38
    1980-12-16 | 25.38
    1980-12-17 | 25.88
    ⋮
    2013-12-26 | 568.1
    2013-12-27 | 563.82
    2013-12-30 | 557.46
    2013-12-31 | 554.17  
