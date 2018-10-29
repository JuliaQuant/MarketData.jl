using MarketData
using Test


@testset "TimeSeries readwrite parses csv file correctly" begin

    @testset "1d values array works" begin
        @test cl |> values isa Array{Float64,1}
    end

    @testset "2d values array works" begin
        @test ohlc |> values isa Array{Float64,2}
    end

    @testset "timestamp parses to correct type" begin
        @test cl |> timestamp        isa Vector{Date}
        @test datetime1 |> timestamp isa Vector{DateTime}
    end

    @testset "meta field is correctly constructed" begin
        @test AAPL |> meta  == "AAPL"
        @test BA |> meta    == "BA"
        @test CAT |> meta   == "CAT"
        @test DELL |> meta  == "DELL"
        @test EBAY |> meta  == "EBAY"
        @test F |> meta     == "F"
        @test GE |> meta    == "GE"
        @test mdata |> meta == "Apple"
    end
end

@testset "const objects have expected length" begin

    @testset "test objects" begin
        @test length(datetime1) == 5
        @test length(op)        == 500
        @test length(cl)        == 500
        @test length(ohlc)      == 500
        @test length(ohlcv)     == 500
        @test length(mdata)     == 500
    end

    @testset "historical data sets" begin
        @test length(AAPL) == 8336
        @test length(BA)   == 13090
        @test length(CAT)  == 13090
        @test length(DELL) == 6353
        @test length(EBAY) == 3842
        @test length(F)    == 10491
        @test length(GE)   == 13090
    end
end
