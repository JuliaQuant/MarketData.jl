using MarketData
using Test

@testset "utils" begin
  @testset "cleanup_colname!" begin  # issue #57
    for (old, new) ∈ [Symbol("Adj. Close")  => :AdjClose,
                      Symbol("Ex-Dividend") => :ExDividend,
                      Symbol("Split Ratio") => :SplitRatio,
                      Symbol("Adj. Open")   => :AdjOpen,
                      Symbol("Adj. High")   => :AdjHigh,
                      Symbol("Adj. Low")    => :AdjLow,
                      Symbol("Adj. Close")  => :AdjClose,
                      Symbol("Adj. Volume") => :AdjVolume]
      ta = TimeArray(cl, colnames = [old])
      MarketData.cleanup_colname!(ta)
      @test colnames(ta) == [new]
    end
  end # @testset "cleanup_colname!"
end # @testset "utils"
