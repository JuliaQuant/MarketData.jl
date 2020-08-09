[![Build Status](https://travis-ci.org/JuliaQuant/MarketData.jl.svg?branch=master)](https://travis-ci.org/JuliaQuant/MarketData.jl)
[![Coverage Status](https://img.shields.io/coveralls/JuliaQuant/MarketData.jl.svg)](https://coveralls.io/r/JuliaQuant/MarketData.jl)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaQuant.github.io/MarketData.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaQuant.github.io/MarketData.jl/latest)

Historical financial time series data for research and testing in Julia.

## Examples

### Testing data

There are some data builtin for testing or demo purpose.
The full list of testing data is [here](https://juliaquant.github.io/MarketData.jl/stable/test_data/).

```julia
julia> using MarketData

julia> cl
500×1 TimeArray{Float64,1,Date,Array{Float64,1}} 2000-01-03 to 2001-12-31
│            │ Close  │
├────────────┼────────┤
│ 2000-01-03 │ 111.94 │
│ 2000-01-04 │ 102.5  │
│ 2000-01-05 │ 104.0  │
│ 2000-01-06 │ 95.0   │
│ 2000-01-07 │ 99.5   │
│ 2000-01-10 │ 97.75  │
│ 2000-01-11 │ 92.75  │
...
```

### Remote data source

This package supports Yahoo Finance API for retrieving data.

```julia
julia> yahoo(:INTC)
10187×6 TimeArray{Float64,2,Date,Array{Float64,2}} 1980-03-17 to 2020-08-07
│            │ Open   │ High   │ Low    │ Close  │ Adj Close │ Volume     │
├────────────┼────────┼────────┼────────┼────────┼───────────┼────────────┤
│ 1980-03-17 │ 0.3255 │ 0.3307 │ 0.3255 │ 0.3255 │ 0.2022    │ 1.09248e7  │
│ 1980-03-18 │ 0.3255 │ 0.3281 │ 0.3229 │ 0.3229 │ 0.2006    │ 1.70688e7  │
│ 1980-03-19 │ 0.3307 │ 0.3359 │ 0.3307 │ 0.3307 │ 0.2055    │ 1.85088e7  │
│ 1980-03-20 │ 0.3307 │ 0.3346 │ 0.3294 │ 0.3294 │ 0.2047    │ 1.11744e7  │
│ 1980-03-21 │ 0.3229 │ 0.3229 │ 0.3177 │ 0.3177 │ 0.1974    │ 1.21728e7  │
│ 1980-03-24 │ 0.3164 │ 0.3164 │ 0.3112 │ 0.3112 │ 0.1933    │ 8.9664e6   │
│ 1980-03-25 │ 0.3125 │ 0.3177 │ 0.3125 │ 0.3125 │ 0.1941    │ 1.13472e7  │
│ 1980-03-26 │ 0.3125 │ 0.3151 │ 0.3099 │ 0.3099 │ 0.1925    │ 1.62624e7  │
│ 1980-03-27 │ 0.3047 │ 0.3047 │ 0.2995 │ 0.2995 │ 0.186     │ 2.69184e7  │
│ 1980-03-28 │ 0.3112 │ 0.3164 │ 0.3112 │ 0.3112 │ 0.1933    │ 2.01024e7  │
│ 1980-03-31 │ 0.3216 │ 0.3268 │ 0.3216 │ 0.3216 │ 0.1998    │ 9.0048e6   │
│ 1980-04-01 │ 0.3229 │ 0.3281 │ 0.3229 │ 0.3229 │ 0.2006    │ 8.1792e6   │
│ 1980-04-02 │ 0.3255 │ 0.3307 │ 0.3255 │ 0.3255 │ 0.2022    │ 1.25568e7  │
   ⋮
```

The full API reference is
[here](https://juliaquant.github.io/MarketData.jl/stable/downloads/).
