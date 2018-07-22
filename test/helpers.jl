using MarketData
using Base.Test

@testset "helper method" begin
    @testset "single-letter methods work" begin
        @test o(AAPL).colnames == ["Open"]
        @test h(AAPL).colnames == ["High"]
        @test l(AAPL).colnames == ["Low"]
        @test c(AAPL).colnames == ["Close"]
        @test v(AAPL).colnames == ["Volume"]
    end
end
