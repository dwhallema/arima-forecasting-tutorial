## ----warning=FALSE,message=FALSE-----------------------------------------
# Load packages
library(fpp2)

# Time plot of both variables
autoplot(advert, facets = TRUE)

# Fit ARIMA model
fit <- auto.arima(advert[, "sales"], xreg = advert[, "advert"], stationary = TRUE)

# Summarize the ARIMA model
summary(fit)
salesincrease <- coefficients(fit)[3]

# Check model residuals
checkresiduals(fit)

# Forecast fit as fc
fc <- forecast(fit, xreg = rep(10, 6))

# Plot fc 
autoplot(fc) + xlab("Month") + ylab("Sales") + ggtitle("Dynamic regression forecasts of sales for 10 advertising units/month")

## ------------------------------------------------------------------------
elec <- elecdemand

# Time plots
autoplot(elec[, c("Demand", "Temperature")], facets = TRUE)

# Matrix of regressors
xreg <- cbind(MaxTemp = elec[, "Temperature"], 
              MaxTempSq = elec[, "Temperature"]^2, 
              Workday = elec[, "WorkDay"])

# Fit model
fit <- auto.arima(elec[, "Demand"], xreg = xreg)

# Forecast one day ahead
forecast(fit, xreg = cbind(20, 20^2, 1), h = 1)

# Plot
autoplot(fc) + xlab("Day") + ylab("Electricity demand") + ggtitle("Dynamic regression forecasts of electricity demand for Tmax = 20 degC")

## ------------------------------------------------------------------------
# Set up harmonic regressors of order 13
harmonics <- fourier(gasoline, K = 13)

# Fit regression model with ARIMA errors
fit <- auto.arima(gasoline, xreg = harmonics, seasonal = FALSE)

# Check residuals
checkresiduals(fit)

# Forecasts next 3 years
newharmonics <- fourier(gasoline, K = 13, h = 3*52)
fc <- forecast(fit, xreg = newharmonics)

# Plot forecasts fc
autoplot(fc) + xlab("Time") + ylab("Million barrels/day") + 
  ggtitle("Dynamic harmonic regression forecasts of US finished motor gasoline product")

## ------------------------------------------------------------------------
# Fit a harmonic regression using order 10 for each type of seasonality
fit <- tslm(taylor ~ fourier(taylor, K = c(10, 10)))

# Forecast 20 working days ahead
fc <- forecast(fit, newdata = data.frame(fourier(taylor, K = c(10, 10), h = 20 * 48)))

# Check the residuals
checkresiduals(fit)

# Plot forecasts
autoplot(fc)


## ------------------------------------------------------------------------
# Plot the calls data
autoplot(calls)

# Set up the xreg matrix
xreg <- fourier(calls, K = c(10, 0))

# Fit a dynamic regression model
fit <- auto.arima(calls, xreg = xreg, seasonal = FALSE, stationary = TRUE)

# Check the residuals
checkresiduals(fit)

# Plot forecasts for 10 working days ahead
# 169 5-minute periods in a working day
fc <- forecast(fit, xreg = fourier(calls, c(10, 0), h = 10 * 169))
autoplot(fc)

## ------------------------------------------------------------------------
# Plot the gas data
autoplot(gas)

# Fit a TBATS model to the gas data
fit <- tbats(gas)

# Forecast the series for the next 5 years
fc <- forecast(fit, h = 5 * 12)

# Plot the forecasts
autoplot(fc)


