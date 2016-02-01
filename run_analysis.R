#######################################################################################################################
## Coursera Getting and Cleaning Data Course Project
## Michael Kerr
## 28-JAN-2016

# run_analysis.R File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## This script assumes your working directory contains the UCI HAR Dataset within a folder named 'UCI HAR DATASET' ##
## This script also assumes you have all necessary libraries installed.

#######################################################################################################################

library(plyr)

# Step 1: Merge the training and test sets to create one data set

# Read all training data
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read all testing data
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' data set by combining the training and testing data
xData <- rbind(xTrain, xTest)

# create 'y' data set by combining the training and testing data
yData <- rbind(yTrain, yTest)

# create 'subject' data set by combining the training and testing data
subjectData <- rbind(subjectTrain, subjectTest)



# Step 2: Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
meanAndStdFeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
xData <- xData[, meanAndStdFeatures]

# correct the column names
names(xData) <- features[meanAndStdFeatures, 2]



# Step 3: Use descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
yData[, 1] <- activities[yData[, 1], 2]

# correct column name
names(yData) <- "activity"



# Step 4: Appropriately label the data set with descriptive variable names

# correct column name
names(subjectData) <- "subject"

# bind all the data in a single data set
allData <- cbind(xData, yData, subjectData)



# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

# 66 <- 68 columns but last two (activity & subject)
averagesData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averagesData, "tidy_data_set.txt", row.name=FALSE)