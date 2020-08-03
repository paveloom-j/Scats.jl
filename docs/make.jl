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
            # Custom assets
            assets = ["assets/custom.css"],
            # A fallback for creating docs locally
            prettyurls = get(ENV, "CI", nothing) == "true",
        ),

    # Fail if any error occurred
    strict = true,
)

# Determine the path to the generated example (HTML)
EXAMPLE_PATH = joinpath(@__DIR__, "build", "generated", "example.html")
if !ispath(EXAMPLE_PATH)
    EXAMPLE_PATH = joinpath(@__DIR__, "build", "generated", "example", "index.html")
end

# Postprocessing: remove gcf() from HTML version
content = read(EXAMPLE_PATH, String)
content = replace(content, "\ngcf()" => "")

open(EXAMPLE_PATH, "w") do io
    print(io, content)
end

# Set the path to the generated example (notebook)
EXAMPLE_PATH = joinpath(@__DIR__, "build", "generated", "example.ipynb")

# Postprocessing: remove gcf() from notebook version
content = read(EXAMPLE_PATH, String)
content = replace(content, "\\n\",\n    \"gcf()\"" => "\"")
ss2 = findnext("Updating", content, 1)
ss1 = findprev("{", content, ss2.start)
ss3 = findnext("}", content, ss1.stop)
content = replace(content, content[ss1.start - 6:ss3.start + 6] => "[],")

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
