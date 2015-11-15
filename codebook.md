# Codebook for Coursera: Getting and Cleaning Data - Course Project

##Project Background
One of the most exciting areas in all of data science right now is wearable computing.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms
to attract new users. The data linked to from the course website represent data collected from
the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the
site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Project Purpose and Goals
The purpose of this project is to demonstrate ones ability to collect, work with, and clean
a data set. The goal is to prepare tidy data that can be used for later analysis. 

##run_analysis.R script

The project task was to create a script "run_analysis.R" that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.

For a detailed description of the funtionality of the script, see the README file:
https://github.com/j6a/gacd-proj/blob/master/README.md


##Variables created in the run_analysis.R script

  Variable:		fileUrl
  Class:			"character"
  Dimensions:		NULL
  Comments:		Character string used to hold the URL for the download of the raw data.
				"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Variable:		X_train
Class:			"data.frame"
Dimensions:		7352 obs. of 561 variables
Comments:		Dataframe created from "X_train.txt" from the supplied dataset.
				Contains the feature measurements
				
Variable:		y_train
Class:			"data.frame"
Dimensions:		7352 obs. of 1 variables
Comments:		Dataframe created from "y_train.txt" from the supplied dataset.
				Contains the activity ID 1-6 for each measurement

Variable:		subject_train
Class:			"data.frame"
Dimensions:		7352 obs. of 1 variables
Comments:		Dataframe created from "subject_train.txt" from the supplied dataset.
				Contains the subject number 1-30 for each measurement

Variable:		training_data
Class:			"data.frame"
Dimensions:		7352 obs. of 563 variables
Comments:		Dataframe created by merging the columns of X_train, y_train, subject_train

Variable:		X_test
Class:			"data.frame"
Dimensions:		7352 obs. of 561 variables
Comments:		Dataframe created from "X_test.txt" from the supplied dataset.
				Contains the feature measurements
				
Variable:		y_test
Class:			"data.frame"
Dimensions:		7352 obs. of 1 variables
Comments:		Dataframe created from "y_test.txt" from the supplied dataset.
				Contains the activity ID 1-6 for each measurement
				
Variable:		subject_test
Class:			"data.frame"
Dimensions:		7352 obs. of 1 variables
Comments:		Dataframe created from "subject_test.txt" from the supplied dataset.
				Contains the subject number 1-30 for each measurement
				
Variable:		test_data
Class:			"data.frame"
Dimensions:		7352 obs. of 563 variables
Comments:		Dataframe created by merging the columns of X_test, y_test, subject_test

Variable:		data1
Class:			"data.frame"
Dimensions:		10299 obs. of 563 variables
Comments:		Dataframe created by merging the rows of training_data and test_data.

Variable:		data2
Class:			"data.frame"
Dimensions:		10299 obs. of 68 variables
Comments:		Dataframe created by selecting only the columns that contain mean() and
				standard deviation from data1.
				
Variable:		activity_labels
Class:			"data.frame"
Dimensions:		6 obs. of 2 variables
Comments:		Dataframe created from "activity_labels.txt" from the supplied dataset.
				Contains the description of each of the 6 activities in the experiment
				1 = WALKING, 2 = WALKING_UPSTAIRS, 3 = WALKING DOWNSTAIRS, 
				4 = SITTING, 5 = STANDING, 6 = LAYING
				
Variable:		features
Class:			"data.frame"
Dimensions:		561 obs. of 2 variables / 66 obs. of 2 variables
Comments:		Dataframe created from "features.txt" form the supplied dataset.
				Initially this variable contains the feature names for all 561
				measured features.
				Line 106 of the script then subsets this variable down to the
				66 measurements that contain the mean() and std() of each
				measurement.

Variable:		data3
Class:			"data.frame"
Dimensions:		180 obs. of 68 variables
Comments:		Dataframe created by first grouping data 2 by subject and activity, then 
				calculating the mean for each combination.
				There are 30 subjects, that each perform all 6 of the activities, 
				so this data frame has 180 observations.
				The forst 2 columns are the subject and activity, and the remaining
				66 columns are the mean() and std() feature measurements from the 
				supplied dataset.
				standard deviation from data1.
				
				