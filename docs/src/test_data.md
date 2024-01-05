# Test data

Test data `const` objects are smaller datasets designed to be used in
tests for other packages. They include both `Date` and `DateTime`
objects. All but one of the objects has an empty TimeArray `meta` field.

| `const`     | Description                          | First timestamp     |   Number of rows
|-------------|--------------------------------------|---------------------|-----------------
| `op`        | single column `Date` data            | 2000-01-03          |   500
| `cl`        | single column `Date` data            | 2000-01-03          |   500
| `ohlc`      | four-column `Date` data              | 2000-01-03          |   500
| `ohlcv`     | five-column `Date` data              | 2000-01-03          |   500
| `mdata`     | 1-column `Date` data with meta field | 2000-01-03          |   500
| `datetime1` | 1-column `DateTime` data             | 2013-12-31T00:00:00 |   5
| `datetime2` | 1-column `DateTim`e data             | 1961-12-31 00:00:00 |   5

## Random

| `Function`     | Description                                      | First timestamp(*)  |   Number of rows(*)
|----------------|--------------------------------------------------|---------------------|-----------------
| `random_cl`    | random close price                               | 2020-01-01          |   500
| `random_vol`   | random volume                                    | 2020-01-01          |   500
| `random_ohlc`  | random `Open`/`High`/`Low`/`Close` price data    | 2020-01-01          |   500
| `random_ohlcv` | random `Open`/`High`/`Low`/`Close`/`Volume` data | 2020-01-01          |   500

(*) these values are default values but can be changed passing a keyword argument such as `start=Dates.DateTime(2024, 1, 1)` and `length=1000`.
