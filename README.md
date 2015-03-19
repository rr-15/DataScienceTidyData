# Getting and Cleaning Data - Course Project

## Introduction
The goal of this project is to demonstrate our ability to collect, work with, and clean a data set.

### Data Set
Human Activity Recognition Using Smartphones Dataset Version 1.0. 
The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, data has been captured for 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### Tidy Data
To clean the raw data and create the tidy data a R script called r_analysis.R is created.  The structure and use of this script is given below.
The result of the script is stored in a file called HAM_TidyData.txt and stored in the working directory.

### Environment
R script was created and executed in R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet"
The raw data files are assumed to be in the "UCI HAR Dataset" folder. This folder along with all the sub directories should be in the Working Directory.
This script depends on the "reshape2" package, so it has to be installed first.  

#### Script - r_analysis.R
This file contains a single function run_analysis. The script structure and use is as follows:
1.  The libraries that are needed to execute this function are loaded first. 
2.  Both training and test data sets are read. Each training and test data set contains X, Y and subject files.
X_train.txt & X_test.txt - Contains the measured values
Y_train.txt & Y_test.txt - Training and test activities and it ranges from 1 to 6. 
subject_train.txt & subject_test.txt - Subject who performed the activity and it ranges from 1 to 30
features.txt - Provides the feature names
acitivty_labels.txt - Provides the different activity names
Files in folder "Inertial Signals" is not used in the tidying process.
3.  Concatenate both the training and test data sets. X_trin.txt + X_test.txt, Y_train.txt + Y_test.txt, subject_train.txt + subject_test.txt
4.  Change the data set column names to features. e.g. V1, V2 etc are changed to tBodyAcc-mean()-X, tBodyAcc-mean()-Y etc.
5.  Retrieve only the mean and std columns. For this all the columns that contain mean() and std() are retrieved. 
Mean Columns - 33
Std Columns - 33
There are other columns that contain word "mean" but they are for "MeanFrequency" so these are not taken into consideration.
6.  Change the activity id to names.
7.  Combine activity(Y), subject and X data together into single data set.
8.  Modify column names to more descriptive. In this case the names are modified to follow the syntax rather than modifying the whole name created by experts.
9.  Assign activity and subject as id variables and other columns as measure vars.
10.  For each subject and per acitvity mean of each variable is calculated. 
11.  Final dimension of the tidy data is (180,68). 
Columns -  Subject(1), Activity(1) and variables(66) - Total number of columns = 68
Rows - Subject(30) * Activity(6) = 180 
