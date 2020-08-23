# Base image
FROM paveloom/binder-julia-plots:0.1.0

# Install the package
RUN julia -e 'using Pkg; Pkg.add("Scats"); using Scats' >/dev/null 2>&1

# Checkout the `gh-pages` branch and remove redundant files
RUN ls -a && git clone --depth 1 git@github.com:paveloom-j/Scats.jl.git --branch gh-pages --single-branch . && \
    find -type l -delete && \
    rm -rf index.html versions.js binder