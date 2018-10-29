using MarketData
using Test

@testset "remote" begin
    @testset "FRED" begin
        ta = fred()
        @test ta |> timestamp |> length > 100
    end

    @testset "Yahoo" begin
        # ta = yahoo()
        # @test length(ta.timestamp) > 100
        @test_broken 1==2
    end

end
