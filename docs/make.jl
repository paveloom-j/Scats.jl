using Documenter, Scats

makedocs(sitename="My Documentation")

deploydocs(
    repo = "github.com/Paveloom/Scats.jl.git",
    push_preview=true,
)