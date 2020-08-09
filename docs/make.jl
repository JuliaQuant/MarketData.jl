using Documenter
using MarketData


makedocs(
  format = Documenter.HTML(),
  sitename = "MarketData.jl",
  pages = [
    "index.md",
    "getting_started.md",
    "test_data.md",
    "company_financial_series.md",
    "downloads.md",
  ],
  modules = [MarketData],
)

deploydocs(
  repo      = "github.com/JuliaQuant/MarketData.jl.git",
  devbranch = "master",
  target    = "build",
  deps      = nothing,  # we use the `format = :html`, without `mkdocs`
  make      = nothing,  # we use the `format = :html`, without `mkdocs`
)
