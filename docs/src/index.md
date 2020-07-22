# Scats.jl

_Spectral correlation analysis of time series._

```@raw html

<table style="width: fit-content; border-collapse: collapse;">
  <tbody>
    <tr>
      <th style="text-align: center; border: 1px solid lightgray; padding: 6px 12px;">
        Code Coverage
      </th>

      <th style="text-align: center; border: 1px solid lightgray; padding: 6px 12px;">
        Repository & License
      </th>
    </tr>
    <tr>
      <td style="text-align: center; border: 1px solid lightgray; padding: 6px 12px;">
        <a href="https://coveralls.io/github/paveloom-j/Scats.jl" style="position: relative; bottom: -2px;">
          <img src="https://coveralls.io/repos/github/paveloom-j/Scats.jl/badge.svg?branch=develop">
        </a>
      </td>
      <td style="text-align: center; border: 1px solid lightgray; padding: 6px 12px;">
        <a href="https://github.com/paveloom-j/Scats.jl" style="position: relative; bottom: -2px;">
          <img src="https://img.shields.io/badge/GitHub-paveloom--j%2FScats.jl-5DA399.svg">
        </a>
        <a href="https://github.com/paveloom-j/Scats.jl/blob/master/LICENSE.md" style="position: relative; bottom: -2px;">
          <img src="https://img.shields.io/badge/license-MIT-5DA399.svg">
        </a>
      </td>
    </tr>
  </tbody>
</table>

```

This package allows you to construct correlograms and periodograms for a uniform time
series. If necessary, a time series can be generated, a correlogram can be weighted, and
a periodogram can be smoothed.

!!! note

    The package is designed exclusively for learning purposes and is not recommended for
    use in production.

## Features
- generation of the uniform time series with custom number of harmonics;
- eliminating a linear trend from time series;
- periodogram and correlogram computations using FFT;
- weighted correlogram computation using Tukey weighting function;
- smoothed periodogram computation using FFT.

## Project management

[ZenHub](https://www.zenhub.com) is being used for agile project management,
there is a board on the repository's landing page.

## That's a fork!

This package is an attempt to rewrite the [original project](https://github.com/Paveloom/C3)
in the Julia programming language.
