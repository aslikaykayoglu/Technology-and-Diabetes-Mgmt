rm(list = ls(all.names = TRUE))

library(imputeTS)

n <- 50
Error_kalman <- Error_L <- Error_S <- Error_locf <- Error_mean <- c()
rmse_error_kalman <- rmse_error_L <- rmse_error_S <- rmse_error_locf <- rmse_error_mean <- c()
corr_kalman <- corr_L <- corr_S <- corr_locf <- corr_mean <- c()

for (t in 1:n){
  # Pick a random patient of one age group
  patient_numbers <- c('01','02','03','04','05','06','07','08','09','10')
  r.patient <- sample(patient_numbers,1)
  patient <- paste("DMMSR_Dataset/adolecents/adolescent#0", r.patient, ".csv",sep = "")
  ado_data<-read.csv(patient,header=TRUE,sep=",") 
  cgm_data <- ado_data$cgm
  
  #Used length of the data
  data_len <- round(length(cgm_data))
  
  #time series
  x_cgm <- cgm_data[1:data_len]
  x_cgm <- ts(x_cgm)
  
  # Therefore, you will implement an algorithm to select random start-points where 
  # the artificial missing sequences will start. Also the length of each missing 
  # sequence should be determined randomly between the following lengths: 
  # 5, 30, 60, 120, 240 representing 5 minutes, 30 minutes, 1 hour, 2 hours, and 4 hours 
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

  # Step 2: Visualize the imputed values in the time series
  
  ## Different Methods:
  # Kalman Filter
  imp_kalman <- na_kalman(x_cgm)
  
  # Interpolation Linear
  imp_interpol_L <- na_interpolation(x_cgm, option = "linear")
  
  # Interpolation Spline
  imp_interpol_S <- na_interpolation(x_cgm, option = "spline")
  
  # Missing Value Imputation by Last Observation Carried Forward
  imp_locf <- na_locf(x_cgm, option = "locf")
  
  # Mean 
  imp_mean <- na_mean(x_cgm, option = "mean")
  
  # Evaluation: Mean absolute error
  Error_kalman[t] = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_kalman))
  Error_L[t] = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_interpol_L))
  Error_S[t] = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_interpol_S))
  Error_locf[t] = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_locf))
  Error_mean[t] = (1/data_len) * sum(abs(cgm_data[1:data_len]-imp_mean))
  
  # RMSE
  rmse_error_kalman[t] = sqrt(mean(cgm_data[1:data_len]-imp_kalman)^2)
  rmse_error_L[t] = sqrt(mean(cgm_data[1:data_len]-imp_interpol_L)^2)
  rmse_error_S[t] = sqrt(mean(cgm_data[1:data_len]-imp_interpol_S)^2)
  rmse_error_locf[t] = sqrt(mean(cgm_data[1:data_len]-imp_locf)^2)
  rmse_error_mean[t] = sqrt(mean(cgm_data[1:data_len]-imp_mean)^2)
  
  # Pearson Correlation
  corr_kalman[t] <- cor(cgm_data[1:data_len], imp_kalman, method = 'pearson')
  corr_L[t] <- cor(cgm_data[1:data_len], imp_interpol_L, method = 'pearson')
  corr_S[t] <- cor(cgm_data[1:data_len], imp_interpol_S, method = 'pearson')
  corr_locf[t] <- cor(cgm_data[1:data_len], imp_locf, method = 'pearson')
  corr_mean[t] <- cor(cgm_data[1:data_len], imp_mean, method = 'pearson')
}

# Calculate the mean Error and the standard deviation 
Mean_error_kalman = mean(Error_kalman)
Mean_error_L = mean(Error_L)
Mean_error_S = mean(Error_S)
Mean_error_locf = mean(Error_locf)
Mean_error_mean = mean(Error_mean)

Std_error_kalman = sd(Error_kalman)
Std_error_L = sd(Error_L)
Std_error_S = sd(Error_S)
Std_error_locf = sd(Error_locf)
Std_error_mean = sd(Error_mean)

Mean_rmse_error_kalman = mean(rmse_error_kalman)
Mean_rmse_error_L = mean(rmse_error_L)
Mean_rmse_error_S = mean(rmse_error_S)
Mean_rmse_error_locf = mean(rmse_error_locf)
Mean_rmse_error_mean = mean(rmse_error_mean)

Std_rmse_error_kalman = sd(rmse_error_kalman)
Std_rmse_error_L = sd(rmse_error_L)
Std_rmse_error_S = sd(rmse_error_S)
Std_rmse_error_locf = sd(rmse_error_locf)
Std_rmse_error_mean = sd(rmse_error_mean)

Mean_corr_kalman = mean(corr_kalman)
Mean_corr_L = mean(corr_L)
Mean_corr_S = mean(corr_S)
Mean_corr_locf = mean(corr_locf)
Mean_corr_mean = mean(corr_mean)

Std_corr_kalman = sd(corr_kalman)
Std_corr_L = sd(corr_L)
Std_corr_S = sd(corr_S)
Std_corr_locf = sd(corr_locf)
Std_corr_mean = sd(corr_mean)

# Show Metrics in a table
tab <- matrix(c(Mean_error_kalman, Mean_error_L, Mean_error_S, Mean_error_locf, Mean_error_mean, 
                Std_error_kalman, Std_error_L, Std_error_S, Std_error_locf, Std_error_mean,
                Mean_rmse_error_kalman, Mean_rmse_error_L, Mean_rmse_error_S, Mean_rmse_error_locf, Mean_rmse_error_mean,
                Std_rmse_error_kalman, Std_rmse_error_L, Std_rmse_error_S, Std_rmse_error_locf, Std_rmse_error_mean,
                Mean_corr_kalman, Mean_corr_L, Mean_corr_S, Mean_corr_locf, Mean_corr_mean,
                Std_corr_kalman, Std_corr_L, Std_corr_S, Std_corr_locf, Std_corr_mean), ncol=5, byrow=TRUE)
colnames(tab) <- c('Kalman Filter','Linear Interpol.','Spline Interpol.', 
                   'LOCF', 'Mean')
rownames(tab) <- c('Mean absolute error','Std Mean absolute error','Mean RMSE', 
                   'Std RMSE', 'Pearson correlation', 'Std Pearson correlation')
tab <- as.table(tab)
tab



