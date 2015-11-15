# Coursera - Getting & Cleaning Data (Nov 2015) - Course Project
# Author: j6a
# Date:   14/11/2015
# File:   run_analysis.R is a script that processes the data for the course
#         project.
# 
# The dataset for the project is to be obtained from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# The project requirements are listed below:
#
# You should create one R script called run_analysis.R that does the following. 
# 1.  Merges the training and the test sets to create one data set.
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.  Uses descriptive activity names to name the activities in the data set
# 4.  Appropriately labels the data set with descriptive variable names. 
# 5.  From the data set in step 4, creates a second, independent tidy data set with the 
#     average of each variable for each activity and each subject.


# Library files
suppressPackageStartupMessages(library(dplyr))

# For completeness, and reproducability, I have added the code to download the dataset to the
# working directory.
# If the unzipped dataset is already in the working directory, this step is skipped.

if(!file.exists("./UCI HAR Dataset")){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"./UCI HAR Dataset.zip")
unzip("./UCI HAR Dataset.zip")
}

# --------------------------------------------------------------------------------------------------------------
# Part 1 - Merges the training and the test sets to create one data set.
# --------------------------------------------------------------------------------------------------------------

# Read the X_train.txt file into R and store in a data frame object X_train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", nrows=7352, colClasses = rep("numeric",times=561))

# Read the y_train.txt file into R and store in a data frame object y_train
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", nrows=7352, colClasses = "numeric")

# Read the subject_train.txt file into R and store in a data frame object subject_train
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", nrows=7352, colClasses = "numeric")

# Combine the training data into one data frame training_data as follows:

# Column 1: Subject who performed the activity for each window sample. Range is from 1 to 30.
# Column 2: Training labels, which represent the activity name being undertaken for each window sample
# Columns 3 to 563: Training data listing the value for each feature.
training_data <- cbind(subject_train, y_train, X_train)

# Read the X_test.txt file into R and store in a data frame object X_test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", nrows=2947, colClasses = rep("numeric",times=561))

# Read the y_test.txt file into R and store in a data frame object y_test
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", nrows=2947, colClasses = "numeric")

# Read the subject_test.txt file into R and store in a data frame object subject_test
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", nrows=2947, colClasses = "numeric")

# Combine the test data into one data frame test_data as follows:
# Column 1: Subject who performed the activity for each window sample. Range is from 1 to 30.
# Column 2: Test labels, which represent the activity name being undertaken for each window sample
# Columns 3 to 563: Test data listing the value for each feature.
test_data <- cbind(subject_test, y_test, X_test)

# Merge the training data and test data into one data set "data"
data1 <- rbind(training_data, test_data)

# Give unique column labels to the last 2 columns
colnames(data1)[1] <- "subject"
colnames(data1)[2] <- "activity"


# --------------------------------------------------------------------------------------------------------------
# Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
# --------------------------------------------------------------------------------------------------------------

# This section subsets the data set to contain only the required features:
data2 <- select(data1, subject, activity, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215,
                V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, V516:V517, 
                V529:V530, V542:V543) 

# --------------------------------------------------------------------------------------------------------------
# Part 3 - Uses descriptive activity names to name the activities in the data set
# --------------------------------------------------------------------------------------------------------------

# The names in the supplied features.txt file are going to be used "as is" for this project.
# Read in the activity_labels text file
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", nrows=6, colClasses = c("numeric","character"))

# Convert the activity number into a factor variable with labels as per the activity_labels file.
data2$activity <- factor(data2$activity, levels = activity_labels[,1], labels = activity_labels[,2])


# --------------------------------------------------------------------------------------------------------------
# Part 4 - Appropriately labels the data set with descriptive variable names. 
# --------------------------------------------------------------------------------------------------------------

# Read in the features.text file
features <- read.table("./UCI HAR Dataset/features.txt", nrows=561, colClasses = c("numeric","character"))

# Get the column names for the mean ans standard deviation meansurements.
features <- slice(features, c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 
              253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543))

# Rename the columns in the dataset to match the corresponding names in the features.txt file.
colnames(data2)[3:68] <- features[,2]


# --------------------------------------------------------------------------------------------------------------
# Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
# --------------------------------------------------------------------------------------------------------------

# Group by both subject and activity, then calculate the mean of each of the other columns by group.
data3 <- data2 %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# Write dataset to a text file
write.table(data3,"./tidydata.txt",row.names = FALSE)

