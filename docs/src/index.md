# Scats.jl

_Realization of the SCATS library in Julia._

A package for completing spectral correlation analysis of time series.

!!! note

    This package was developed primarily for learning purposes and is not advised to be used in production.

## Features

- generation of the uniform time series with custom number of harmonics;
- eliminating a linear trend from time series;
- periodogram and correlogram computations using FFT;
- weighted correlogram computation using Tukey weighting function;
- smoothed periodogram computation using FFT.

## Library

```@contents
Pages = ["lib/public.md"]
```