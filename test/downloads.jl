using MarketData
using Base.Test

@testset "remote" begin
    @testset "FRED" begin
        ta = fred()
        @test length(ta.timestamp) > 100
    end

    @testset "Yahoo" begin
        # ta = yahoo()
        # @test length(ta.timestamp) > 100
        @test_broken 1==2
    end
    
end
