
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hsluv

<!-- badges: start -->

<!-- badges: end -->

The goal of hsluv is to provide a human-friendly alternative to HSL and
HSV color spaces.

Human-friendly means that the same amount of numerical change in these
spaces corresponds to about the same amount of visually perceived
change. This is not the case for HSL and HSV, which are based on RGB.

## Installation

You can install the development version of hsluv like so:

``` r
remotes::install_github("andrie/hsluv")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(hsluv)

# Convert hex to HSLuv
hex_to_hsluv("#ff0000")
#> [1]  12.17705 100.00000  53.23712

# Convert HSLuv to hex
hsluv_to_hex(c(0, 100, 50))
#> [1] "#ea0064"
```

## Credit

This project includes the [C implementation of
HSluv](https://github.com/hsluv/hsluv-c), by Martin Mitáš, licensed
under the MIT license:

Copyright © 2015 Alexei Boronine (original idea, JavaScript
implementation)  
Copyright © 2015 Roger Tallada (Obj-C implementation)  
Copyright © 2017 Martin Mitáš (C implementation, based on Obj-C
implementation)
