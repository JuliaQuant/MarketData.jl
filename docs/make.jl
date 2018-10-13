using Documenter
using MarketData


makedocs(
    format = :html,
    sitename = "MarketData.jl",
    pages = [
        "index.md",
        "getting_started.md",
        "test_data.md",
        "company_financial_series.md",
        "downloads.md",
    ]
)

deploydocs(
    repo = "github.com/JuliaQuant/MarketData.jl.git",
    julia  = "1.0",
    latest = "master",
    target = "build",
    deps = nothing,  # we use the `format = :html`, without `mkdocs`
    make = nothing,  # we use the `format = :html`, without `mkdocs`
)
