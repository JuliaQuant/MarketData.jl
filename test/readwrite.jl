facts("TimeSeries readwrite parses csv file correctly") do

    context("1d values array works") do
        @fact typeof(cl.values) => Array{Float64,1}
    end
  
    context("2d values array works") do
        @fact typeof(ohlc.values) => Array{Float64,2}
    end
  
    context("timestamp parses to correct type") do
        @fact typeof(cl.timestamp)    => Vector{Date}
        @fact typeof(sdata.timestamp) => Vector{DateTime}
    end
end

facts("const objects have expected length") do

    context("test objects") do
        @fact length(sdata) => 21
        @fact length(op)    => 500
        @fact length(cl)    => 500
        @fact length(ohlc)  => 500
        @fact length(ohlcv) => 500
    end

    context("historical data sets") do
        @fact length(AAPL) => 8336
        @fact length(BA)   => 13090
        @fact length(CAT)  => 13090
    end
end
