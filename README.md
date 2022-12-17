# Handling Missing Data Project
Technology-and-Diabetes-Mgmt
![With_Gaps](https://user-images.githubusercontent.com/75546415/207821095-ccd0377d-ebe5-4817-8f73-edea6624a450.jpeg)

## Aim:

Real-time continuous glucose monitoring may include continuous sequences of missing values. These missing values can be generated using various techniques to avoid loss of sample data. Our project implements, evaluates and predicts the missing data. To this end, the generated artificial missing data to compare with our ground truth and evaluate how well we generated a random sample of patients. By comparing the accuracy of the algorithms, we can determine which of our approaches to missing data is best for our chosen dataset.

## Dataset:
The CGM of 30 individuals with type 1 diabetes was collected for 1 month. One-third of
patients were in each of the age groups: adolescents, adults, and children. The frequency of the data is one day (1440 data points) which starts at midnight on the first day and a new data point is collected every minute. 

## How to handle missing values?
1.  Generating Missing Values
The sequence contains between 3% and 10% missing values. On those sequences with artificial missing values, different techniques for data imputation was implemented.

+ Kalman Filter
+ Linear Interpolation
+ Spline Interpolation
+ LOCF
+ Mean


2. Evaluation of the Missing Values comparing to the Ground Truth
+ Root-Mean Square Error
+ Mean Absolute Error
+ Pearson's Correlation

3. Prediction of Missing Values
+ ARIMA
+ ETS 
+ Random Walk
+ Random Walk with Drift

## Conclusion
CGM has made impressive scientific progress in the world of diabetes and offers benefits to diabetics. The use of CGM is expected to increase due to the prognosis of diabetic patients. Advances in device accuracy will be critical for CGM to gain wider use for insulin dosing adjustment in clinical practice. 



