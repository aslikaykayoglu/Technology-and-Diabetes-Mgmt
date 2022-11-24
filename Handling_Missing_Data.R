library(imputeTS)

ado_data<-read.csv("DMMSR_Dataset/adolecents/adolescent#001.csv",header=TRUE,sep=",") 
cgm_data=ado_data$cgm

#Used length of the data
data_len <- length(cgm_data)/32

#time series
x_cgm <- cgm_data[1:data_len]

# Therefore, you will implement an algorithm to select random start-points where 
# the artificial missing sequences will start. Also the length of each missing 
# sequence should be determined randomly between the following lengths: 
# 1, 6, 12, 24, 48 representing 5 minutes, 30 minutes, 1 hour, 2 hours, and 4 hours 
# of missing data. Make sure that your sequence contains between 3% and 10% missing values.

seq_max <- round(0.1*data_len)
seq_min <- round(0.03*data_len)
seq = c(seq_min:seq_max)
n <- sample(seq, 1)

len <- c(1,6,12,24,48)
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


imp <- na_kalman(x_cgm)
ggplot_na_imputations(x_cgm, imp, cgm_data[1:data_len])
#ggplot_na_distribution(x_cgm)

ggplot_na_distribution2(x_cgm)
ggplot_na_gapsize(x_cgm)

x_cgm.imp <- na_mean(x_cgm)
# Step 2: Visualize the imputed values in the time series
ggplot_na_imputations(x_cgm, x_cgm.imp)

## Different Methods:
# Interpolation Linear
imp_interpol_L <- na_interpolation(x_cgm, option = "linear")
ggplot_na_imputations(x_cgm, imp_interpol_L, cgm_data[1:data_len])

# Interpolation Spline
imp_interpol_S <- na_interpolation(x_cgm, option = "spline")
ggplot_na_imputations(x_cgm, imp_interpol_S, cgm_data[1:data_len])

# Missing Value Imputation by Last Observation Carried Forward
imp_locf <- na_locf(x_cgm, option = "locf")
ggplot_na_imputations(x_cgm, imp_locf, cgm_data[1:data_len])


# Evaluation: Mean absolute error
ma_error_kalman = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp))
ma_error_inp_L = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_interpol_L))
ma_error_inp_S = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_interpol_S))
ma_error_inp_locf = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_locf))

# Evaluation: RMSE
rmse_error_kalman = sqrt(mean(cgm_data[1:data_len]-imp)^2)
rmse_error_inp_L = sqrt(mean(cgm_data[1:data_len]-imp_interpol_L)^2)
rmse_error_inp_S = sqrt(mean(cgm_data[1:data_len]-imp_interpol_S)^2)
rmse_error_inp_locf = sqrt(mean(cgm_data[1:data_len]-imp_locf)^2)





