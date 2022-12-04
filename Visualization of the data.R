library(ggplot2)
library(dplyr)

ado_data<-read.csv("DMMSR_Dataset/adolecents/adolescent#010.csv",header=TRUE,sep=",")
#ado_data<-read.csv("DMMSR_Dataset/children/child#010.csv",header=TRUE,sep=",")

ado_data %>%
  ggplot(aes(x = minutesPastSimStart, y = cgm)) + 
  geom_line() + 
  labs(x = "Time [min]",
       y = "Glucose level [CGM]")

one_day <- ado_data[c(1:1440), c(1, 10)]

one_day %>%
  ggplot(aes(x = minutesPastSimStart, y = cgm)) + 
  geom_line() + 
  labs(x = "Time [min]",
       y = "Glucose level [CGM]")

# Visualization of the missing values
cgm_data <- ado_data$cgm

#Used length of the data
data_len <- length(cgm_data)

#time series
x_cgm <- cgm_data[1:data_len]
x0_cgm <- ts(x_cgm)
x_cgm <- ts(x_cgm)

# Therefore, you will implement an algorithm to select random start-points where 
# the artificial missing sequences will start. Also the length of each missing 
# sequence should be determined randomly between the following lengths: 
# 1, 6, 12, 24, 48 representing 5 minutes, 30 minutes, 1 hour, 2 hours, and 4 hours 
# of missing data. Make sure that your sequence contains between 3% and 10% missing values.

seq_max <- round(0.1*data_len)
seq_min <- round(0.03*data_len)
seq = c(seq_min:seq_max)
n <- sample(seq, 1)

len <- c(5,30,60,120,240)
i <- 0
x <- c(1:data_len) 

while (i<=n){
  len_seq <- sample(len, 1)
  start_pos <- sample(x, 1)
  if(identical(which(is.na(x_cgm[start_pos:(start_pos+len_seq)])), integer(0))){
    x_cgm[c(start_pos:(start_pos+len_seq))] <- NA 
    i <- i + len_seq
  }
}

idx = which(is.na(x_cgm))
x0_cgm[-idx] <- NA

ado_data %>%
  ggplot() + 
  geom_line(aes(x = minutesPastSimStart, y = x_cgm)) +
  geom_point(aes(x = minutesPastSimStart, y = x0_cgm), color = "red") +
  labs(x = "Time [min]",
       y = "Glucose level [CGM]")
