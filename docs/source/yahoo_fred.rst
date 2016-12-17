Downloading data from Yahoo and FRED
====================================

Two epynomous methods are provided for downloading free data, from both Yahoo Finance (yahoo) and the Federal Reserve St. Louis (fred).

These methods take a string argument that represents the name of the desired data set to be downloaded. For the ``yahoo()`` method, 
the default data is the S&P 500 end-of-day daily prices. That symbol is named ``^GSPC``. The default data for the ``fred()`` method
is ``CPIAUCNS``, which represents the Consumer Price Index for All Urban Consumers data. These defaults only apply when no argument 
is passed, otherwise the user is left with determining the correct name for the data of interest.
