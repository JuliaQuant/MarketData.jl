using MarketData
using Test

@testset "remote" begin
    @testset "FRED" begin
        ta = fred()
        @test ta |> timestamp |> length > 100
        ta = fred("DGS10")
        @test ta |> timestamp |> length > 100
    end

    @testset "Yahoo" begin
        t = Dates.now() - Year(2)
        opt = YahooOpt(period1 = t)
        ta = yahoo(:AAPL, opt)
        @test ta |> timestamp |> length > 100
    end

    @testset "ONS" begin
        ta = ons()
        @test ta |> timestamp |> length > 100
    end

    @testset "BOE" begin
        t = Dates.today() - Year(2)
        opt = BoeOpt(Datefrom = t)
        ta = boe("XUDLGBD",opt)
        @test ta |> timestamp |> length > 100
        @test timestamp(ta)[1] >= t
    end
end
