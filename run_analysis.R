# This script prepares a tidy dataset that can be used for later data analysis.
# The source of the original data is 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Load R packages that are used
library(plyr)
library(reshape2)

# Set wd
setwd("~/GettingAndCleaningData/CourseProject")

# Load all raw data
# Test Data 3 sets- X, Y, and subject
testX <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/test/subject_test.txt")

# Train Data 3 sets- X, Y, and subject
trainX <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/train/subject_train.txt")

# Features data set
features <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/features.txt")
names(features) <- c('rowId','label')

# Activity Labels data set
activities <- read.table("~/GettingAndCleaningData/data/UCI HAR Dataset/activity_labels.txt")
names(activities) <- c('activityId','activityName')

# Merge data
# Merge test and train data
testMerged <- cbind(testX,testY,testSubject)
trainMerged <- cbind(trainX,trainY,trainSubject)

# Remove tables
rm(testX,testY,testSubject,trainX,trainY,trainSubject)

# Merge to form one data set
allMerged <- rbind(testMerged,trainMerged)

# Remove tables
rm(testMerged,trainMerged)

# Isolate Columns to keep for tidy data
# Get the column labels
columnLabels <- as.character(features$label)

# Get the column numbers for the mean and standard deviation
colNumsWithMeanAndStdDev <- grep("mean\\(|std\\(", columnLabels)
colNamesWithMeanAndStdDev <- columnLabels[grep("mean\\(|std\\(", columnLabels)]

# The second to last and last columns have the activity and the subject that we want to keep
colNumsToKeep <- c(colNumsWithMeanAndStdDev, ncol(allMerged) - 1, ncol(allMerged))
colNamesToKeep <- c(colNamesWithMeanAndStdDev, "activityId","subjectId")

# Subset and label data
data <- allMerged[,colNumsToKeep]
names(data) <- colNamesToKeep

# Use the activity names
data <- merge(data,activities, by.x = "activityId", by.y = "activityId")

# Melt and summarize the data
# Melt data to meet tidy data principles
dataMelt <- melt(data,id=c('subjectId','activityId','activityName'))

# Tidy Data
tidyDataNarrow <- ddply(dataMelt, c('subjectId','activityId','activityName','variable'), summarise, mean = mean(value))
names(tidyDataNarrow) <- c('subjectId', 'activityId','activityName','measurement', 'mean')

# Write tidy data set
write.table(tidyDataNarrow, 'tidyData.txt', sep="\t", row.name=FALSE)

