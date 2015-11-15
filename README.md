# README.md

Author: j6a

This README.md describes the functionality of the run_analysis.R script that has been
developed for the Coursera  - Getting & Cleaning Data (Nov 2015) - Course Project.

The dataset for the project is to be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Refer to the README in the supplied dataset for a description of all of the files
supplied.

The output of the run_analysis.R script is a text file called "tidydata.txt"

If you would like to read the tidydata.txt file back into R, you can use the following:

```R
tidydata <- read.table("./tidydata.txt", header = TRUE, nrows=180, 
				colClasses = c("numeric","factor", rep("numeric",times=66)))
View(tidydata)
```



# Line-by-line description of the script
 
**Line 22:** 	Loads the dplyr package which is required for the script to function.
				The "dplyr" package needs to be installed first using:  
						`install.packages("dplyr")`
						
						
**Line 28-32:**	This section will download the dataset ZIP file form the given URL and
				save it to the working directory (if it doesnt exist already)

## Part 1 -	Merges the training and the test sets to create one data set.
		
**Line 39-45:**	The three TXT files X_train.txt , y_train.txt, subject_train.txt are
				read into R ans stored as 3 data frames.
			
*Note:	The X_train dataset is large - read.table() was used in favour
		of read.fwf(), which resulted in much faster code execution.
		By setting the value of the nrows, and ColClasses arguments
		of the read.table() function, execution is sped up
		dramatically.*
			
**Line 52:**	The three data frames corresponding to the three TXT files are
				combined using cbind(). The resulting data frame "training_data"
				contains the subject and activity as the first 2 columns, with the
				remaining 561 colums containing the corresponding feature data for
				each measurement.

**Line 55-67:**	This section repeats exactly what was dont with the training data, 
				but using the text data instead. The resulting data frame is called
				"test_data"
			
**Line 70:**	The training and test data sets are merged using rbind() to form 
				a new data frame "data1"

**Line 73-74:**	Meaningful column names are given to the forst two columns, 
				i.e. Subject, and Activity.
			
## Part 2 -	Extracts only the measurements on the mean and standard deviation for
##			each measurement.
			
**Line 83:**	A new data frame "data2" is created by selecting only the measurements
				on the mean and standard deviation from the large dataset "data1".
			
				Looking in the features.txt file supplied in the dataset, the values that
				were selected were those that contained PREFIX-mean()-SUFFIX, or
				PREFIX-std()-SUFFIX.
			
				*Note that the PREFIX-freqmean()-SUFFIX values were not selected.*

				Using this selection criteria, 66 of the 561 features were kept in the
				new dataset. The dataset has 68 columns, as it has Subject and Activity
				as the first 2 columns, plus the 66 selected feature measurements.

## Part 3 -	Uses descriptive activity names to name the activities in the data set

**Line 92:** 	The supplied TXT file activity_labels.txt was read into R using the
				read.table() function.
				This file contained text labels for the 6 activities that were part
				of the data collection process:
				1 WALKING
				2 WALKING_UPSTAIRS
				3 WALKING_DOWNSTAIRS
				4 SITTING
				5 STANDING
				6 LAYING
			
**Line 95:**	Using the factor() function, the activity column (which contained the
				numbers 1-6 corresponding to the activity) were replaced with a factor
				variable, with levels 1-6, and labels as per activity_labels.txt
			
			
## Part 4 - Appropriately labels the data set with descriptive variable names. 

*NOTE:		This question left it quote open as to how to label the columns of the data.
			The definition of "descriptive" is very subjective!
		
			To keep things simple, I have used the descriptions of the features given
			as a part of the supplied dataset in the file features.txt
		
			*Please keep in mind when you mark this assignment that your definition
			of descriptive could well be different to mine :-)*
		
			I worked off the assumption that if the feature descriptions were good 
			enough to be supplied with the dataset, then they are good enough to be
			used in my analysis.
		
			More importantly, by using these descriptive names, I do not have to supply
			additional documentation descibing my new naming convention.*
		

**Line 103:** 	Read the features.txt file into a data frame "features" using the
				read.table() function.

**Line 106:**	Using the dplyr slice function, the "features" data frame was modified to
				contain only the rows with feature descriptions for the mean() and std()
				measurements (selected as described above)
			
**Line 110:**	The data frame "data2" was given new column names based on the values in
				the "features" data frame
		


## Part 5 - From the data set in step 4, creates a second, independent tidy data set
##			with the average of each variable for each activity and each subject. 

**Line 119:**	Making use of the dplyr group_by(), summarise_each(), and the chain
				operator %>%, the following line of code was used to create a data 
				frame "data3" that contained the summary mean() statistic for each
				measurement, grouped by 2 variables, namely subject and activity.
			
				```R
				data3 <- data2 %>% group_by(subject,activity) %>% summarise_each(funs(mean))
				```
			
**Line 122:**	Write the resultant data set to a TXT file "tidydata.txt". This creates
				the text file that is required to be submitted on the Coursera website.
			
			
