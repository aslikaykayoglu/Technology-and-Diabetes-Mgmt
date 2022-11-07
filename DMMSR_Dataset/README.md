# Data from DMMSR Simulator

## Patients:
10 Adults (> 18 years old)
10 Adolescents (14-18)
10 Children (< 14)
-The dataset has one additional subject representing the “average” response for the group.

-31 days of simulated data with 1 minutes interval (1 Day = 1440 min)

## Features
-minutesPastSimStart
-minutesPastMidnight
-name: Subject identifier (e.g., adolescent#004)
-type1: True
-CR: Carbohydrate ratio (g/unit of insulin), 
-CF: Correction factor (mg/dL/Unit of Insulin)
-Gb: Basal (fasting) blood glucose (mg/dL)
-BW: Body weight
-dailyBasalInsulin (units)
-cgm: Continuous Glucose Monitor
-amountMg: No needed - To be removed
-durationInMinutes: Duration of the Meal in minutes
-minutesUntilNextMeal: Minutes Until Next Meal
-bolusMultiplier: A bolus multiplier that would be applied to the calculated bolus for all subjects, whether the 
calculation uses the explicit carb ratio or the subject-specific ones from the subject database. Note that this 
multiplier is only useful when the subject-specific ratios are used. (No needed)
-mealCarbsMgPerMin: meal carbohydrates(pmol)
-fullMealCarbMgExpectedAtStart: total carbohydrates expected for the full meal.
-sqInsulinNormalBolus: Bolus insulin that the patients take before the meal.
-slowRelInsulinStandardLongActing: Basal insulin that the patients take on bed time to stabilize the glucose


Extreme reaction of blood glucose (Example):
- Subject number 7 was aged 47 with a body weight of only 46 kg and 
exhibited strikingly high fluctuations in blood glucose in 
comparison with the other subjects. (maybe will exclude)



