# Scats.jl

[![][github-img]][github-url] [![][license-img]][license-url]

[github-img]: https://img.shields.io/badge/GitHub-paveloom--j%2FScats.jl-5DA399.svg
[github-url]: https://github.com/paveloom-j/Scats.jl/

[license-img]: https://img.shields.io/badge/license-MIT-5DA399.svg
[license-url]: https://github.com/paveloom-j/Scats.jl/blob/master/LICENSE.md

_Realization of the SCATS library in Julia._

A package for completing spectral correlation analysis of time series.

!!! note

    This package was developed primarily for learning purposes and is not advised to be
    used in production.

## Features

- generation of the uniform time series with custom number of harmonics;
- eliminating a linear trend from time series;
- periodogram and correlogram computations using FFT;
- weighted correlogram computation using Tukey weighting function;
- smoothed periodogram computation using FFT.

## Project management

[ZenHub](https://www.zenhub.com) is being used for agile project management.
Download the extension to see the board on the repository's landing page.

## Library

```@contents
Pages = ["lib/public.md"]
```
