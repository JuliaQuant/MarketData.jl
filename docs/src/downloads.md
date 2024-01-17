# Downloading from remote data source

Three eponymous methods are provided for downloading free data, from
Yahoo Finance (yahoo) the Federal Reserve St. Louis (fred), the
United Kingdom's Office for National Statistics (ons) and the
Bank of England's database (boe).

These methods take a string argument that represents the name of the
desired data set to be downloaded.

These methods have default arguments.
These defaults only apply when no argument is passed, otherwise the user is
left with determining the correct name for the data of interest.

## Yahoo

For the `yahoo()` method, the default
data is the S&P 500 end-of-day daily prices. That symbol is named `^GSPC`.

```@docs
yahoo
YahooOpt
```

## FRED

The default data for the `fred()` method is `CPIAUCNS`, which
represents the Consumer Price Index for All Urban Consumers data.

## ONS

For the `ons()` method, the default
data is the `L522` timeseries from the `MM23` dataset, which
represents the Consumer Price Index including housing costs, in the UK.
This is the ONS' headline monthly price inflation statistic.

```@docs
ons
```
## BOE

For the `boe()` method, the default
seriescode is the `IUDSOIA`, which
represents the daily Sterling Overnight Index Average
which is one of the 10 most popular BoE timeseries.

```@docs
boe
```