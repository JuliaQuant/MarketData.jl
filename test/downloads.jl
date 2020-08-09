using MarketData
using Test

@testset "remote" begin
    @testset "FRED" begin
        ta = fred()
        @test ta |> timestamp |> length > 100
    end

    @testset "Yahoo" begin
        t = Dates.now() - Year(2)
        opt = YahooOpt(period1 = t)
        ta = yahoo(:AAPL, opt)
        @test ta |> timestamp |> length > 100
    end
end
