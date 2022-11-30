library(imputeTS)
library(fpp2)
library(smooth)

# Pick a random patient of one age group
patient_numbers <- c('01','02','03','04','05','06','07','08','09','10')
r.patient <- sample(patient_numbers,1)
patient <- paste("DMMSR_Dataset/adolecents/adolescent#0", r.patient, ".csv")
ado_data<-read.csv("DMMSR_Dataset/adolecents/adolescent#001.csv",header=TRUE,sep=",") 
cgm_data <- ado_data$cgm

x_cgm <- ts(cgm_data, frequency = 1500)
#x_cgm <- ts(cgm_data[300:(length(cgm_data)/2)], frequency = 1500)

autoplot(x_cgm)

dX <- diff(x_cgm)

# autoplot(dX)

#ggseasonplot(dX)
#ggsubseriesplot(dX)

# Method 1
fit_naive <- snaive(dX)
#print(summary(fit_naive))
#checkresiduals(fit_naive)
fcast <- forecast(fit_naive, h = 2000)
autoplot(fcast, include = 2500)

# Method 2
fit_ets <- stlf(x_cgm)
#print(summary(fit_ets))
#checkresiduals(fit_ets)
fcast <- forecast(fit_ets, h = 200)
autoplot(fcast, include = 4000)


fit <- auto.arima(x_cgm[1:4000])
#fit <- arima(x_cgm, order=c(0,1,3))
#print(summary(fit))
#checkresiduals(fit)
fcast <- forecast(fit, h = 100)
autoplot(fcast, include = 1000)


