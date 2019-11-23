## ----warning=FALSE,message=FALSE-----------------------------------------
# Load packages
library(fpp2)

# Forecast Google stock price
fcgoog <- naive(goog, h = 20)

# Plot and summarize the forecasts
autoplot(fcgoog)
summary(fcgoog)

## ------------------------------------------------------------------------
# Forecast quarterly beer production in Australia
fcbeer <- snaive(ausbeer, h = 20)

# Plot and summarize the forecasts
autoplot(fcbeer)
summary(fcbeer)


## ------------------------------------------------------------------------
# Check residuals 
goog %>% naive() %>% checkresiduals()

## ------------------------------------------------------------------------
# Check the residuals
ausbeer %>% snaive() %>% checkresiduals()

## ------------------------------------------------------------------------
# Create the training series
train <- subset(gold, end = 1000)

# Compute naive forecasts for validation series
naive_fc <- naive(train, h = 108)

# Compute mean forecasts
mean_fc <- meanf(train, h = 108)

# Compute RMSE statistics
accuracy(naive_fc, gold)
accuracy(mean_fc, gold)

## ------------------------------------------------------------------------
vn <- visnights

# Create three training series of different lengths
train1 <- window(vn[, "VICMetro"], end = c(2014, 4))
train2 <- window(vn[, "VICMetro"], end = c(2013, 4))
train3 <- window(vn[, "VICMetro"], end = c(2012, 4))

# Generate seasonally naive forecasts
fc1 <- snaive(train1, h = 4)
fc2 <- snaive(train2, h = 8)
fc3 <- snaive(train3, h = 12)

# Compute accuracy
accuracy(fc1, vn[, "VICMetro"])["Test set", "MAPE"]
accuracy(fc2, vn[, "VICMetro"])["Test set", "MAPE"]
accuracy(fc3, vn[, "VICMetro"])["Test set", "MAPE"]


## ------------------------------------------------------------------------
# Compute cross-validated errors for up to 8 steps ahead
e <- tsCV(goog, forecastfunction = naive, h = 8)

# Compute the MSE values
mse <- colMeans(e^2, na.rm = T)

# Plot the MSE values against forecast horizon
data.frame(h = 1:8, MSE = mse) %>%
  ggplot(aes(x = h, y = MSE)) + geom_point()

