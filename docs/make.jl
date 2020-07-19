using Documenter # A package to manage documentation
using Scats      # A package to create the documentation for

# Create documentation
makedocs(

    # Specify modules being used
    modules = [Scats],

    # Specify a name for the site
    sitename ="Scats.jl",

    # Specify the author
    authors = "Pavel Sobolev.",

    # Specify the pages on the left side
    pages = [

        # Home page
        "Home" => "index.md",

        # Library page
        "Library" => Any[

            # Public
            "lib/public.md",

            # Internals
            "Internals" => map(
                s -> "lib/internals/$(s)",
                [
                    "module.md",
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

    # Check links
    linkcheck = true,

    # Fail if any error occurred
    strict = true
)

# Deploy documentation
deploydocs(

    # Specify a repository
    repo = "github.com/paveloom-j/Scats.jl.git",

    # Create documentation previews for pull requests
    push_preview=true,

    # Specify a development branch
    devbranch = "develop",

)
