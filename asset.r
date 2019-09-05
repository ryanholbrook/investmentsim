## Assets
## ------
## Time -> Time -> Return
## 
## An asset is identified with an accumulator. It takes an increment and
## returns the asset's percent change over that increment.
##
## An asset should in addition have as an attribute 'dates' the vector
## of dates over which it is defined. If left as 'NULL' it is assumed
## to be valid for any date.

## make_historical - for historical data
##
## TODO
##
## time series models - GARCH, GBM
##
## randomized historical assets - assets generated from random samples
## of historical assets

library(tidyverse)
library(lubridate)
library(xts)


### Functions for computing returns from other data

## From prices of a security
make_returns <- function(x) diff(x) / x[-length(x)]
make_relative_returns <- function(x) diff(log(x))

## From the interest rates on a 10-year Treasury note
## Computes the change in price of the note due to the change in
## interest rate, based on the present-value valuation.
note_return <- function(r1, r2) {
    coupon <- r1
    numpd <- 10
    yield <- r2/100
    cf <- c(rep(coupon, numpd - 1), 100 + coupon)
    pv <- sum(cf * (1 + yield)^(-(1:numpd)))
    coupon + (pv - 100)
}

## TODO - vectorized note_return
make_note_returns <- function(x) stop("TODO")


### Assets
get_start <- function(asset) first(index(asset))


### Historical Assets

## Make an asset from a time series of absolute (ordinary) returns
make_historical <- function (ts) {
    f <- function(s, e) {
        returns <- ts[paste0(s, '::', e)] %>% tail(-1)
        prod(1 + returns)
    }
    attributes(f)$dates <- index(ts)
    f
}

## Make an asset from a time series of relative (log) returns
make_relative_historical <- function (ts) {
  f <- function(s, e) exp(sum(ts[paste0(s, '::', e)]))
}

make_bootstrap_historical <- function(ts, block_size=5) {
    bts <- make_geom_block_sample(ts, block_size, 1)
    bts <- xts(bts, order.by=index(ts))
    make_historical(bts)
}

