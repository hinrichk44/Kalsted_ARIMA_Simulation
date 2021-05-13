#Simulating Time Series with ARIMA
#The set.seed() function sets the starting number used to generate a sequence of
#random numbers - it ensures that you get the same result if you start with 
#that same seed each time you run the same process.

set.seed(123)

#Now we are setting up the simulation using arima.sim()
#We are adding +10 at the end to use as a constant
random_simulation <- arima.sim(model = list(order = c(1,0,1),
                                     ar = c(0.4),
                                     ma = c(0.3)),
                                     n = 1000) + 10

#Now we are plotting our time series to double check randomness
plot(random_simulation)
#It does indeed look like a random time series
#We can smooth this time series using a moving average
#We can use rollmean from the zoo package
library(zoo)
#Here we are plotting the simulation using an MA of 50 and 25
plot(rollmean(random_simulation, 50))
plot(rollmean(random_simulation, 25))
#Both plots look much smoother
#Here we are using an adf test to test for stationarity
library(tseries)
adf.test(random_simulation)
#The results do indicate stationarity
#Now we are going to test for autocorrelation
library(forecast)
tsdisplay(random_simulation)
#There is some ac on the first two lags, but that happens often
#Finally, we are going to test our simulation against auto.arima()
auto.arima(random_simulation, trace = T,
           stepwise = F,
           approximation = F)
#The output does confrim the (1,0,1) start
#The ar coefficient we chose was .4 and the result is .35, so close
#The ma coefficient we chose was .3 and the result is .32, so also close