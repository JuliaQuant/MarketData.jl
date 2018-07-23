# Getting Started

MarketData is a registered package. To add it to your Julia packages,
simply do the following in REPL:

```julia
Pkg.add("MarketData")
```

The TimeSeries package is a dependency. Support is planned to convert
these objects into either DataFrame or AxisArray objects, with those
packages only being called if the constructors are called.
