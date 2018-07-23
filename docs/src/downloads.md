# Downloading from remote data source

Two epynomous methods are provided for downloading free data, from both
Yahoo Finance (yahoo) and the Federal Reserve St. Louis (fred).

These methods take a string argument that represents the name of the
desired data set to be downloaded.

These methods have default arguments.
These defaults only apply when no argument is passed, otherwise the user is
left with determining the correct name for the data of interest.

## Yahoo

For the `yahoo()` method, the default
data is the S&P 500 end-of-day daily prices. That symbol is named `^GSPC`.

!!! warning

    Yahoo! Finance has been immediately deprecated. Yahoo! substantially altered their API in late 2017 and this csv endpoint was retired.

## FRED

The default data for the `fred()` method is `CPIAUCNS`, which
represents the Consumer Price Index for All Urban Consumers data.
