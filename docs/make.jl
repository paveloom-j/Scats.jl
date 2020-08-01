using Documenter # A package to manage documentation
using Literate   # A package for literate programming
using Scats      # A package to create the documentation for

# Example: input path
EXAMPLE = joinpath(@__DIR__, "..", "examples", "example.jl")

# Example: output path
OUTPUT = joinpath(@__DIR__, "src", "generated")

# Delete previously generated content if present
isdir(OUTPUT) && rm(OUTPUT, recursive = true)

# Example: generate a Markdown file and a notebook
Literate.markdown(EXAMPLE, OUTPUT)
Literate.notebook(EXAMPLE, OUTPUT)

# Create documentation
makedocs(
    # Specify modules being used
    modules = [Scats],

    # Specify a name for the site
    sitename = "Scats.jl",

    # Specify the author
    authors = "Pavel Sobolev.",

    # Specify the pages on the left side
    pages = [
        # Home page
        "Home" => "index.md",

        # Example page
        "Example" => "generated/example.md",

        # Library page
        "Library" => Any[
            # Public
            "lib/Public.md",

            # Internals
            "Internals" => map(
                s -> "lib/Internals/$(s)",
                [
                    "Module.md",
                    "Prec.md",
                    "Input.md",
                    "Result.md",
                    "Gen.md",
                    "Extras.md"
                ]
            ),
        ],
    ],

    # Specify a format
    format = Documenter.HTML(
            # A fallback for creating docs locally
            prettyurls = get(ENV, "CI", nothing) == "true"
        ),

    # Fail if any error occurred
    strict = true,
)

# Determine the path to generated example
EXAMPLE_PATH = joinpath(@__DIR__, "build", "generated", "example.html")
if !ispath(EXAMPLE_PATH)
    EXAMPLE_PATH = joinpath(@__DIR__, "build", "generated", "example", "index.html")
end

# Postprocessing: remove gcf() in HTML version
content = read(EXAMPLE_PATH, String)
content = replace(content, "gcf()" => "")

open(EXAMPLE_PATH, "w") do io
    print(io, content)
end

# Deploy documentation
deploydocs(
    # Specify a repository
    repo = "github.com/paveloom-j/Scats.jl.git",

    # Create documentation previews for pull requests
    push_preview = true,

    # Specify a development branch
    devbranch = "develop",
)
