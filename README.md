
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bcadata

<!-- badges: start -->

[![R-CMD-check](https://github.com/vfci/vfci/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/vfci/vfci/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of bcadata is to replicate and update the data used by
Angeletos, Collard, and Dellas in their paper “Business Cycle Anatomy”
(2020) in the American Economic Review.

The package pulls most of the data from
[FRED](https://fred.stlouisfed.org) and TFP data from the [San Francisco
Fed](https://www.frbsf.org/economic-research/indicators-data/total-factor-productivity-tfp/).

The data series constructed are:

- output, Real GDP per capita
- investment, Real investment per capita
- consumption, Real consumption per capita
- hours_worked, Hours Worked
- unemployment, Unemployment Rate (as percent)
- labor_share, Labor share of output
- interest, Fed Funds interest rate (quarterly rate, not annual)
- inflation, Inflation rate, from GDP price deflator
- productivity, Productivity (NFB)
- TFP, Total Factor Productivity cummulative

## Installation

You can install the development version of bcadata from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("VFCI/bcadata")
```

## FRED API Key

This package requires a FRED API key to pull data from the St. Louis
Fed.

You can get an API key
[here](https://fred.stlouisfed.org/docs/api/api_key.html).

## Usage

There are two functions exported from the package:

``` r
## Construct the updated data series
df <- pull_bcadata(fred_api_key = "XXXXXXXXXXXX")

## Chart comparing the updated series to the original data
compare_bcadata(df)
```

Finally, the package includes the original dataset from the [author’s
replication
files](https://www.openicpsr.org/openicpsr/project/118082/version/V1/view).

``` r
original_bcadata
```
