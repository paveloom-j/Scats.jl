# # Example
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__/generated/example.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__/generated/example.ipynb)
#md #
# This example shows part of the basic functionality of the module.
#
#nb # If you prefer JupyterLab's interface over Jupyter Notebook's, replace `notebooks`
#nb # with `lab/tree` in the URL.
#nb #-
# First off, let's import the package:
using Scats
#md #+
# Let's set up an instance of the interface of the package to obtain access to its
# capabilities.
s = Scats.API();
#md #+
# We don't have a time series yet, but we can use the built-in generator to get one. To do
# this, we should specify time series generator parameters using a text file, but we do not
# have one either. Fortunately, the package provides a template for each built-in structure,
# so we'll use one of them.
## Create a temporary file for generator parameters
file, _ = mktemp()

## Fill this file with the generator settings template
s.Gen.example(file)

## Finally, read these parameters into the appropriate structure
s.Gen(file)
#md #+
# Let's generate a time series:
## Call the generation
s.gen!()
#md #+
# Done. The time series is now contained in the instance of [Input](@ref Input)' structure.
#
# Let's render it for validation. But first, we need a package for that.
using Pkg
Pkg.add("PyPlot")
#md #+
# And now let's import it:
using PyPlot
#md #+
# It's optional, but it's never harmful to make graphs prettier:
## Get access to rcParams
rcP = PyPlot.PyDict(PyPlot.matplotlib."rcParams")

## Set DPI
rcP["savefig.dpi"] = 300
rcP["figure.dpi"] = 300

## Activate TeX support
rcP["text.usetex"] = true

## Activate languages support
rcP["text.latex.preamble"] = raw"\usepackage[main=english]{babel}"

## Switch to Computer Modern font set
rcP["mathtext.fontset"] = "cm"

## Set font sizes
rcP["font.size"] = 18
rcP["legend.fontsize"] = 12;
#md #+
# Now let's get a plot:
## Create a plot
plot(s.Input.t, s.Input.x, color = "#425378")

## Add a title
title(raw"\textrm{Time series}")

## Add labels
xlabel(raw"\textrm{Time}")
ylabel(raw"\textrm{Value}")

## Create a directory for figures
!isdir("figures") && mkdir("figures")

## Save the figure
savefig("figures/input.pdf", bbox_inches = "tight")
gcf()

#-
## Close the figure
close()
