rm(list = ls(all.names = TRUE))

library(forecast)

# Read data
ado_data<-read.csv("DMMSR_Dataset/adolecents/adolescent#001.csv",header=TRUE,sep=",") 
cgm_data <- ado_data$cgm

x_cgm <- ts(cgm_data, frequency = 1440)

# Method 1 - ARIMA
fit_arima_1 <- forecast(x_cgm, method=c("arima"), h = 240)
autoplot(fit_arima_1, include = 2500)

fit_arima_2 <- forecast(x_cgm, method=c("arima"), h = 1440)
autoplot(fit_arima_2, include = 2500)

# Method 2 - ETS
fit_ets_1 <- forecast(x_cgm, method=c("ets"), h = 240)
autoplot(fit_ets_1, include = 2500)

fit_ets_3 <- forecast(x_cgm, method=c("ets"), h = 1440)
autoplot(fit_ets_2, include = 2500)


# Method 3 - Random Walk / Naive
fit_naive_1 <- forecast(x_cgm, method=c("naive"), h = 240)
autoplot(fit_naive_1, include = 2500)

fit_naive_2 <- forecast(x_cgm, method=c("naive"), h = 1440)
autoplot(fit_naive_2, include = 2500)


# Method 4 - Random Walk with drift
fit_rwdrift_1 <- stlf(x_cgm, method=c("rwdrift"), h = 240)
autoplot(fit_rwdrift_1, include = 2500)

fit_rwdrift_2 <- stlf(x_cgm, method=c("rwdrift"), h = 1440)
autoplot(fit_rwdrift_2, include = 2500)


