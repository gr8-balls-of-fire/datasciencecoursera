##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Parimal Mohile
## 18-Aug-2016

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

## Load packages
library("dplyr")
library("data.table")

## Clear the workspce
rm(list=ls())

## 1. Merge the training and the test sets to create one data set.

## Set the woking directory
setwd("/home/gr8-balls-of-fire/datasciencecoursera/dataCleaning/PeerExercise")

# Read in the data from files
features <- read.table('./ExerciseData/features.txt',header=FALSE)                   #  read features.txt into features table
activityType <- read.table('./ExerciseData/activity_labels.txt',header=FALSE)        #  read activity_labels.txt into activityType table

# Read training data
subjectTrain <- read.table('./ExerciseData/train/subject_train.txt',header=FALSE)    #  read subject_train.txt into subjectTrain table
xTrain <- read.table('./ExerciseData/train/X_train.txt',header=FALSE)                #  read X_train.txt into xTrain table
yTrain <- read.table('./ExerciseData/train/y_train.txt',header=FALSE)                #  read y_train.txt into yTrain table

# Read test data
subjectTest <- read.table('./ExerciseData/test/subject_test.txt',header=FALSE)       #  read subject_test.txt into subjectTest table
xTest <- read.table('./ExerciseData/test/X_test.txt',header=FALSE)                   #  read X_test.txt into xTest table
yTest <- read.table('./ExerciseData/test/y_test.txt',header=FALSE)                   #  read y_test.txt into yTest table

## Assign column names
## Common column names
colnames(activityType) <- c("activityID", "activityType")
## column names for training set
colnames(subjectTrain) <- "subjectID"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityID"
## column names for test set
colnames(subjectTest) <- "subjectID"
colnames(xTest) <- features[,2] 
colnames(yTest) <- "activityID"

## Create clubbed data sets combining y data x data and subject data
trainingData <- cbind(yTrain,subjectTrain,xTrain)                        # create training data set
testData <- cbind(yTest,subjectTest,xTest)                               # create test data set


## Combine training and test data to create the merged data set
mergedData = rbind(trainingData,testData)

## Create a vector for selecting required columns
## extract all column names
selectionVector <- names(mergedData)
## logical vector creation for the required subset for 'activityID', 'subjectID', all means and all std
logicalVector <- (grepl("activity..",selectionVector) | grepl("subject..",selectionVector) | grepl("-mean..",selectionVector) & !grepl("-meanFreq..",selectionVector) & !grepl("mean..-",selectionVector) | grepl("-std..",selectionVector) & !grepl("-std()..-",selectionVector))
## subset the merged data to get the required data set of means and std deviations
finalData <- mergedData[logicalVector==TRUE]

## organize final data by activityName
finalData <- merge(finalData,activityType,by='activityID',all.x=TRUE)

## revising column names after merger in selection Vector
selectionVector <- names(finalData)

## Renaming the column names to give descriptive names
for (i in 1:length(selectionVector) ) {
  selectionVector[i] <- gsub('\\(|\\)', "", selectionVector[i])
  selectionVector[i] <- gsub('\\-std', '-Standard_Deviation', selectionVector[i])
  selectionVector[i] <- gsub('\\-mean', '-Mean', selectionVector[i])
  selectionVector[i] <- gsub('^t','Time-', selectionVector[i])
  selectionVector[i] <- gsub('^f','Frequency-', selectionVector[i])
  selectionVector[i] <- gsub("Gravity","Gravity_", selectionVector[i])
  selectionVector[i] <- gsub("(BodyBody|Body)","Body_", selectionVector[i])
  selectionVector[i] <- gsub("Gyro","Gyrometer_", selectionVector[i])
  selectionVector[i] <- gsub("Acc","Acceleration_", selectionVector[i])
  selectionVector[i] <- gsub("Jerk","Jerk_", selectionVector[i])
  selectionVector[i] <- gsub("Mag","Magnitude", selectionVector[i])
}
## changing column names to descriptive names
colnames(finalData) = selectionVector

# Create another table, activityTypeLessfinalData without the activityType column
activityTypeLessfinalData <- finalData[,names(finalData) != 'activityType']

# Summarize the activityTypeLessfinalData table to include only mean of each variable for each activity and each subject
tidyData <- aggregate(activityTypeLessfinalData[,names(activityTypeLessfinalData) != c('activityID','subjectID')],by=list(activityID=activityTypeLessfinalData$activityID,subjectID=activityTypeLessfinalData$subjectID),mean)

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData <- merge(tidyData,activityType,by='activityID',all.x=TRUE)

# Export the tidyData set 
write.table(tidyData, './tidyData.csv',row.names=TRUE,sep=',')