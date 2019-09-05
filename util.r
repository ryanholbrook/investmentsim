### Dates
## The position of the first date in the list before the given date
find_begin_position <- function (dates, d, right=FALSE) {
    Position(function(x) d > x, dates, right)
}

## The first date in the list before the given date
find_begin <- function (dates, d, right=FALSE) {
    dates[[find_begin_position(dates, d, right)]]
}

## The position of the first date in the list after the given date
find_end_position <- function (dates, d, right=FALSE) {
    Position(function(x) d < x, dates, right)
}

## The first date in the list after the given date
find_end <- function (dates, d, right=FALSE) {
    dates[[find_end_position(dates, d, right)]]
}

# The proportion of time elapsed to current in the interval (start, end)
proportion_elapsed <- function(start, current, end) {
    as.duration(interval(start, current)) / as.duration(interval(start, end))
}


### Diagnostics
## Prints something if bool is true
print_if <- function(bool, ...) {
    if (bool) {
        cat(..., '\n')
    }
}


### Time Series
## Stationary bootstrap with geometric block size
## ts is time series, R is number of samples, block_size is mean block
## size
## source: https://eranraviv.com/bootstrapping-time-series-r-code/
make_geom_block_sample <- function(ts, block_size, R) {
    p <- 1/(block_size+1) # probability of new block
    n <- length(ts)
    ts_star <- matrix(nrow=n, ncol=R)
    for (r in 1:R) {
        idx = round(runif(n=1, min=1, max=n)) # choose starting index
        for (i in 1:n){
            p1 = runif(1, 0, 1)
            ## In probability p, we take next observation, otherwise
            ## start a new block
            if (p1>p) {idx <- idx+1} else {idx <- round(runif(1, 1, n))}
            if (idx>n) idx <- idx-n # wrap the series
            ts_star[i, r] = ts[idx]
        }
    }
    ts_star
}


### Returns

## Convert between relative (log) and absolute (ordinary) returns
relative_to_absolute <- function(r_log, n) n*exp(r_log/n) - n
absolute_to_relative <- function(r_n, n) n*log(1+r/n)


### Numerics

## If a number in a vector is negative, set it to 0
trunc_neg <- function (xs) map(xs, function(x) max(x, 0))
