Test data
=========

Test data ``const`` objects are smaller datasets designed to be used in tests for other packages. They include
500 rows of data and include both ``Date`` objects and ``DateTime`` objects. All but one of the objects has an 
empty TimeArray ``meta`` field.

+-----------+-----------------------------------------+----------------+ 
| Name      | Description                             | Number of rows | 
+===========+=========================================+================+ 
| op        | single column Date data                 | 500            |
+-----------+-----------------------------------------+----------------+ 
| cl        | single column Date data                 | 500            |
+-----------+-----------------------------------------+----------------+ 
| ohlc      | four-column Date data                   | 500            |
+-----------+-----------------------------------------+----------------+ 
| ohlcv     | four-column Date data                   | 500            |
+-----------+-----------------------------------------+----------------+ 
| sdata     | single column DateTime data             | 21             |
+-----------+-----------------------------------------+----------------+ 
| mdata     | single column Date data with meta field | 500            |
+-----------+-----------------------------------------+----------------+ 
