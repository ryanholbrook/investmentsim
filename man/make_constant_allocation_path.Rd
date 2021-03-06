% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allocations.R
\name{make_constant_allocation_path}
\alias{make_constant_allocation_path}
\title{Create a constant allocation path}
\usage{
make_constant_allocation_path(asset_names, asset_percents)
}
\arguments{
\item{asset_names}{a vector of strings identifying each holding}

\item{asset_percents}{a vector of numbers between 0 and 1 identifying the
percentage desired of each holding}
}
\value{
an allocation path object
}
\description{
The same allocation, forever.
}
