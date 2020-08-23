# Base image
FROM paveloom/binder-julia-plots:0.1.0

# Install the package
RUN julia -e 'using Pkg; Pkg.add("Scats"); using Scats' >/dev/null 2>&1

# Checkout the `gh-pages` branch and remove redundant files
RUN git clone --depth 1 https://github.com/paveloom-j/Scats.jl.git --branch gh-pages --single-branch >/dev/null 2>&1 && \
     find -type l -path './Scats.jl*' -delete && \
     rm -rf ./Scats.jl/index.html ./Scats.jl/versions.js ./Scats.jl/binder

# Change the working directory
WORKDIR Scats.jl