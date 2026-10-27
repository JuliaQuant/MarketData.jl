var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "MarketData Overview",
    "title": "MarketData Overview",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#MarketData-Overview-1",
    "page": "MarketData Overview",
    "title": "MarketData Overview",
    "category": "section",
    "text": "The MarketData package provides open-source financial data for research and testing.The data is from Quandl and is free end-of-day stock data. It is public domain without restrictions.The TimeSeries TimeArray data structure is used to store the data, but conversion to other data structures, including DataFrames and AxisArrays, is supported."
},

{
    "location": "index.html#Contents-1",
    "page": "MarketData Overview",
    "title": "Contents",
    "category": "section",
    "text": "Pages = [\n    \"getting_started.md\",\n    \"test_data.md\",\n    \"company_financial_series.md\",\n    \"downloads.md\",\n    \"helpers.md\",\n]"
},

{
    "location": "getting_started.html#",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "page",
    "text": ""
},

{
    "location": "getting_started.html#Getting-Started-1",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "section",
    "text": "MarketData is a registered package. To add it to your Julia packages, simply do the following in REPL:Pkg.add(\"MarketData\")The TimeSeries package is a dependency. Support is planned to convert these objects into either DataFrame or AxisArray objects, with those packages only being called if the constructors are called."
},

{
    "location": "test_data.html#",
    "page": "Test data",
    "title": "Test data",
    "category": "page",
    "text": ""
},

{
    "location": "test_data.html#Test-data-1",
    "page": "Test data",
    "title": "Test data",
    "category": "section",
    "text": "Test data const objects are smaller datasets designed to be used in tests for other packages. They include both Date and DateTime objects. All but one of the objects has an empty TimeArray meta field.const Description First timestamp Number of rows\nop single column Date data 2000-01-03 500\ncl single column Date data 2000-01-03 500\nohlc four-column Date data 2000-01-03 500\nohlcv five-column Date data 2000-01-03 500\nmdata 1-column Date data with meta field 2000-01-03 500\ndatetime1 1-column DateTime data 2013-12-31T00:00:00 5\ndatetime2 1-column DateTime data 1961-12-31 00:00:00 5"
},

{
    "location": "company_financial_series.html#",
    "page": "Large historical data sets",
    "title": "Large historical data sets",
    "category": "page",
    "text": ""
},

{
    "location": "company_financial_series.html#Large-historical-data-sets-1",
    "page": "Large historical data sets",
    "title": "Large historical data sets",
    "category": "section",
    "text": "Larger historical prices and volume EOD data is provided for the following companies:const Description Date range Number of rows\nAAPL Apple Inc. 1986 - 2012 8,336\nBA The Boeing Co. 1962 - 2012 13,090\nCAT Caterpillar Inc. 1962 - 2012 13,090\nDELL DELL Inc. 1988 - 2015 6,353\nEBAY eBay Inc. 1998 - 2016 3,842\nF Ford Motor Co. 1998 - 2016 10,491\nGM General Electric Co. 1962 - 2016 13,090"
},

{
    "location": "downloads.html#",
    "page": "Downloading from remote data source",
    "title": "Downloading from remote data source",
    "category": "page",
    "text": ""
},

{
    "location": "downloads.html#Downloading-from-remote-data-source-1",
    "page": "Downloading from remote data source",
    "title": "Downloading from remote data source",
    "category": "section",
    "text": "Two epynomous methods are provided for downloading free data, from both Yahoo Finance (yahoo) and the Federal Reserve St. Louis (fred).These methods take a string argument that represents the name of the desired data set to be downloaded.These methods have default arguments. These defaults only apply when no argument is passed, otherwise the user is left with determining the correct name for the data of interest."
},

{
    "location": "downloads.html#Yahoo-1",
    "page": "Downloading from remote data source",
    "title": "Yahoo",
    "category": "section",
    "text": "For the yahoo() method, the default data is the S&P 500 end-of-day daily prices. That symbol is named ^GSPC.warning: Warning\nYahoo! Finance has been immediately deprecated. Yahoo! substantially altered their API in late 2017 and this csv endpoint was retired."
},

{
    "location": "downloads.html#FRED-1",
    "page": "Downloading from remote data source",
    "title": "FRED",
    "category": "section",
    "text": "The default data for the fred() method is CPIAUCNS, which represents the Consumer Price Index for All Urban Consumers data."
},

{
    "location": "helpers.html#",
    "page": "Helper methods",
    "title": "Helper methods",
    "category": "page",
    "text": ""
},

{
    "location": "helpers.html#Helper-methods-1",
    "page": "Helper methods",
    "title": "Helper methods",
    "category": "section",
    "text": "Single-letter methods are provided to make it easier to extract specific financial time series columns. The five column names that are supported include o() for Open, h() for High, l() for Low, c() for Close and v() for Volume.:using MarketData\no(AAPL)"
},

]}
