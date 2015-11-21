# CS8735Final
Final project

Unsupervised Learning -- Final Project Proposal
Project title:
 Activity Recognition From Single Chest-Mounted Accelerometer
Investigators:
Ming Du
Siman Huang
Introduction:
The project we are going to do is  recognizing everyday life activities by data by their movement accelerometer data
.The input data is obtained by the sensor, which the  frequency of sampling of the accelerometer is 52 Hz, then by 15 participants, collect 7 of the activities, each activity has x, y and z axis acceleration. The features from the data set are extracted from wearable equipment system, five basic every-day life activities like walking, climbing stairs, staying standing, talking with people and working at computer are considered in order to show its performance, the features proposed can be computed in real-time and provide physical meaning to the quantities involved in classification. 
Dataset and Source:
Uncalibrated Accelerometer Data are collected from 15 participants performing 7 activities. The dataset provides challenges for identification and authentication of people using motion patterns.
Data are separated by participant. Each file contains sequential label number, x acceleration, y acceleration, z acceleration. Labels are codified by numbers 1: Working at Computer  2: Standing Up, Walking and Going up down stairs 3: Standing  4: Walking  5: Going Up Down Stairs  6: Walking and Talking with Someone  7: Talking while standing. 
Approach:
1.	Feature selection: 
a.	Use filter to separate low frequency and high frequency components.
b.	Use an overlap window to extract features.
c.	Maybe consider using features in frequency domain.
2.	 Doing statistics analysis on the dataset, and run BSAS to get basic distribution of the data.
3.	Run K-means to get a baseline performance.
4.	Try to use other methods to improve the performance base on the result of step 2 and 3. Possible methods are PCA and ICA. Compare the performance of each method.
Procedure and Timeline:
Nov 5 - Nov 12    Reading papers
Nov 13 - Nov 20		Complete preprocessing data and feature selection
Nov 21 - Nov 25		Statistics analysis, BSAS and K-means
Nov 26 - Dec 2		PCA, ICA
Dec 2 - Dec 10		Result analysis and improvement

