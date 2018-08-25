# Helper methods

Single-letter methods are provided to make it easier to extract specific
financial time series columns. The five column names that are supported
include `o()` for Open, `h()` for High, `l()` for Low, `c()` for Close
and `v()` for Volume.:

```@setup helper
using MarketData
```

```@repl helper
o(AAPL)
```
