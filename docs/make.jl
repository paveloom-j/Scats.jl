using Documenter, Scats

makedocs(
    modules = [Scats],
    sitename ="Scats.jl",
    authors = "Pavel Sobolev.",
    pages = [
        "Home" => "index.md",
        "Library" => Any[
            "lib/public.md",
            "Internals" => map(
                s -> "lib/internals/$(s)",
                [
                    "module.md",
                    "prec.md",
                    "input.md",
                    "gen.md",
                    "result.md",
                    "extras.md"
                ]
            ),
        ],
    ],
    format = Documenter.HTML(
            prettyurls = get(ENV, "CI", nothing) == "true"
        ),
    linkcheck = true,
    strict = true
)

deploydocs(
    repo = "github.com/paveloom-j/Scats.jl.git",
    push_preview=true,
)