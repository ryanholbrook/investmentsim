### Models

## Model
## { initial_portfolio :: Portfolio
## , allocation_trajectory :: Allocations
## , transaction_trajectory :: Transactions
## , dates :: Dates
## }

make_model <- function (portfolio, allocations, transactions, dates) {
    model <- list(portfolio, allocations, transactions, dates)
    names(model) <- c("portfolio", "allocations", "transactions", "dates")
    model
}

## Make an empty retirement model for use in the Monte Carlo
## simulation
make_retirement_model <- function(portfolio, allocations) {
    make_model(portfolio, allocations, NA, NA)
}
