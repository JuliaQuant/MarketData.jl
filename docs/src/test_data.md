# Test data

Test data `const` objects are smaller datasets designed to be used in
tests for other packages. They include both `Date` and `DateTime`
objects. All but one of the objects has an empty TimeArray `meta` field.

| `const`   | Description                        | First timestamp     |   Number of rows
|-----------|------------------------------------|---------------------|-----------------
| op        | single column Date data            | 2000-01-03          |   500
| cl        | single column Date data            | 2000-01-03          |   500
| ohlc      | four-column Date data              | 2000-01-03          |   500
| ohlcv     | five-column Date data              | 2000-01-03          |   500
| mdata     | 1-column Date data with meta field | 2000-01-03          |   500
| datetime1 | 1-column DateTime data             | 2013-12-31T00:00:00 |   5
| datetime2 | 1-column DateTime data             | 1961-12-31 00:00:00 |   5
