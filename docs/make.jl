using Documenter, Scats

DocMeta.setdocmeta!(Scats, :DocTestSetup, :(using Scats); recursive=true)

makedocs(
    modules = [Scats],
    sitename="Scats.jl",
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
                    "types.md"
                ]
            ),
        ],
    ],
    format = Documenter.HTML(
            prettyurls = get(ENV, "CI", nothing) == "true"
        )
)

deploydocs(
    repo = "github.com/Paveloom/Scats.jl.git",
    push_preview=true,
)