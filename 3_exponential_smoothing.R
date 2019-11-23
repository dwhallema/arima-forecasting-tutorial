## ----warning=FALSE,message=FALSE-----------------------------------------
# Load packages
library(fpp2)

# Simple exponential smoothing forecast of next 10 years of Boston marathon winning times
fc <- ses(marathon, h = 10)

# Model parameters
summary(fc)

# Plot the forecasts with the training data
autoplot(fc) + autolayer(fitted(fc))

## ------------------------------------------------------------------------

# Create a training set
train <- subset(marathon, end = length(marathon) - 20)

# Compute SES and naive forecasts, save to fcses and fcnaive
fcses <- ses(train, h = 20)
fcnaive <- naive(train, h = 20)

# Plot the forecasts with the training data
autoplot(fcses) + autolayer(fitted(fcses))
autoplot(fcnaive) + autolayer(fitted(fcnaive))

# Calculate forecast accuracy measures
accuracy(fcses, marathon)["Test set", "RMSE"]
accuracy(fcnaive, marathon)["Test set", "RMSE"]


## ------------------------------------------------------------------------
# Produce 10 year forecasts of austa using holt()
fcholt <- holt(austa, h = 10)

# Summary of fitted model
summary(fcholt)

# Plot the forecasts
autoplot(fcholt) + autolayer(fitted(fcholt))

# Check the residuals
checkresiduals(fcholt)

## ------------------------------------------------------------------------
# Plot the data
autoplot(a10)

# Produce 3 year forecasts
fc <- hw(a10, seasonal = "multiplicative", h = 36)

# Check if residuals look like white noise
checkresiduals(fc)

# Plot forecasts
autoplot(fc) + autolayer(fitted(fc))

## ------------------------------------------------------------------------
# Create training data
train <- subset(hyndsight, end = length(hyndsight) - 28)

# Holt-Winters additive forecasts
fchw <- hw(train, seasonal = "additive", h = 28)

# Seasonal naive forecasts
fcsn <- snaive(train, h = 28)

# Identify best forecasts
accuracy(fchw, hyndsight)
accuracy(fcsn, hyndsight)

## ----warning=FALSE,message=FALSE-----------------------------------------
# Plot both forecasts
autoplot(fchw) + autolayer(fitted(fchw))
autoplot(fcsn) + autolayer(fitted(fcsn))

## ------------------------------------------------------------------------
# Fit ETS model to austa
fitaus <- ets(austa)
checkresiduals(fitaus)
autoplot(forecast(fitaus))

## ------------------------------------------------------------------------
# Repeat for hyndsight data
fiths <- ets(hyndsight)
checkresiduals(fiths)
autoplot(forecast(fiths))

## ------------------------------------------------------------------------
# Subset Portland cement dataset
cement <- subset(qcement, start = 96)

# Function to return ETS forecasts
fets <- function(y, h) {
  forecast(ets(y), h = h)
}

# Apply tsCV() for both methods
e1 <- tsCV(cement, fets, h = 4)
e2 <- tsCV(cement, snaive, h = 4)

# Compute MSE of resulting errors (watch out for missing values)
mean(e1^2, na.rm = T)
mean(e2^2, na.rm = T)


## ------------------------------------------------------------------------
# Plot the lynx series
autoplot(lynx)

# Use ets() to model the lynx series
fit <- ets(lynx)

# Check residuals
checkresiduals(fit)

# Use summary() to look at model and parameters
summary(fit)

# Plot 20-year forecasts of the lynx series
fit %>% forecast(h = 20) %>% autoplot()


