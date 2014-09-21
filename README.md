#CourseProject README
=============
This repo contains the R script to process the Human Activity Recognition Smartphones Data Set.
Original source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project was found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##File Contents
* README.md
* run_analysis.R- script that processes the data
* tidyData.txt- Output file from run_analysis.R
* CodeBook.md- Explains final structure of the tidy data

##Required R packages
* plyr
* reshape2

##Steps taken in script
* Load all raw data
* Merge data
* Identify, keep, subset, and label "mean" and "standard deviation" columns
* Melt data subset
* Write tidy data set
