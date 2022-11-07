# This is a sample Python script.

# Press Umschalt+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
# See PyCharm help at https://www.jetbrains.com/help/pycharm/

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

plt.close('all')
data = pd.read_csv("DMMSR_Dataset/adolecents/adolescent#001.csv", delimiter=',', header=0)
# data = pd.read_csv("DMMSR_Dataset/adults/adult#001.csv", delimiter=',', header=0)
# data = pd.read_csv("DMMSR_Dataset/children/child#001.csv", delimiter=',', header=0)


# Read out data in arrays
time = data['minutesPastSimStart']      # Time points [min]
BW = data['BW']                         # Body weight data
CGM = data['cgm']                       # CGM data

# Visualization of the data
fig1 = plt.figure()
plt.subplot(211)
fig1.suptitle('Visualization of the data', fontsize=16)
plt.plot(time, BW, label = 'Body weight')
plt.legend()
plt.xlabel('time [s]')
plt.ylabel('Body weight [kg]')
plt.grid()
plt.subplot(212)
plt.plot(time, CGM, label = 'CGM')
plt.legend()
plt.xlabel('time [min]')
plt.ylabel('Glucose level')
plt.grid()
plt.show()


fig2 = plt.figure()
for i in range(1, 10):
    data = pd.read_csv("DMMSR_Dataset/adolecents/adolescent#00" + str(i) + ".csv", delimiter=',', header=0)

    # Read out data in arrays
    time = data['minutesPastSimStart']  # Time points [min]
    BW = data['BW']  # Body weight data
    CGM = data['cgm']  # CGM data

    # Visualization of the data
    plt.subplot(10, 1, i)
    # fig2.suptitle('Visualization of the data')
    plt.plot(time, CGM, label='CGM')

plt.show()