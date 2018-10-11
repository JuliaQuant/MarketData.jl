#### 0.10.0

* Deprecate the following helper functions,
  since we are moving toward the Symbol indexing in TimeSeries.jl.
    * `o`
    * `h`
    * `l`
    * `c`

  Using `ta[:Close]` or `ta.Close` is recommended.

### 0.9.0

* Julia 0.7/1.0 supports.

#### 0.8.0

* Reexport TimeSeries.jl stuffs

#### 0.7.0

* Drop 0.5 support

#### 0.6.0

* added fred() and yahoo() methods

#### 0.5.1

* add single letter methods

#### 0.5.0

* limit support to julia 0.5.0 and above

#### 0.4.1

* helper methods with documentation and tests partially resolving issue #29

#### 0.4.0

* bottom Julia version is 0.4 with no upper bound

#### 0.3.8

* revert to older version of TimeSeries because of bounds restrictions

#### 0.3.7

* add F, GE (fixes issue #22)

#### 0.3.6

* fixes missing header for Dell and EBay @GordStephen

#### 0.3.5

* Added Dell, Inc @Dawny33

#### 0.3.4

* Replaced mdata object and associated tests

#### 0.3.3

* Replaced using Base.Dates, TimeSeries outside of module definition

#### 0.3.2

* TimeArray objects now contain strings describing the dataset source stored in the meta field
* test output now displays in compact form
* removed mdata object as tests now covered with datasets

#### 0.3.1

* precompilation code fixed

#### 0.3.0

* first version with support for Julia 0.4 only
* includes support for pre-compilation

#### 0.2.9

* fixes typo in .travis.yml

#### 0.2.8

* last planned version to support Julia 0.3
* fixes .travis.yml badge to only test Julia version 0.3

#### 0.2.7

* removes vdata from tests (ohlcv contains volume data) 

#### 0.2.6

* fixes Julia requirements in REQUIRE

#### 0.2.5

* merged @GordStephen fixes

#### 0.2.4

* changed seconds_data.csv to datetime1.csv
* removed all but the first column of data, and shortened the length to 5 rows
* added datetime2.csv

#### 0.2.3

* Changing sdata to seconds_data. Base has defined a method by the same name. 

#### pre 0.2.3

* Not currently documented.
