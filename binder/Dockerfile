# Take the Binder image from `master`
FROM paveloom/scats.jl-binder:dbd628515531

# Remove everything in current directory
RUN rm -rf * && find . -name . -o -prune -exec rm -rf -- {} +

# Clone the `gh-pages` branch
RUN git clone -b gh-pages --single-branch https://github.com/paveloom-j/Scats.jl.git .