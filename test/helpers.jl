using MarketData
FactCheck.setstyle(:compact)
FactCheck.onlystats(true)

facts("helper method") do

    context("single-letter methods work") do
        @fact o(AAPL).colnames --> ["Open"]
        @fact h(AAPL).colnames --> ["High"]
        @fact l(AAPL).colnames --> ["Low"]
        @fact c(AAPL).colnames --> ["Close"]
        @fact v(AAPL).colnames --> ["Volume"]
    end
end
