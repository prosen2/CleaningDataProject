#Gather the data
#Download files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#unzip the contents into your working directory in a folder called "UCI HAR Dataset"
#Set the working Directory in R to the UCI HAR Dataset Folder

setwd("~/Desktop/UCI HAR Dataset") #Here the file is stored on the Desktop

# Step 1: Merges the training and the test sets to create one data set

#Load data into R
subTest <- read.table("test/subject_test.txt")
subTrain <- read.table("train/subject_train.txt")
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")
xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt")
features <- read.table("features.txt")


# Merge tables together

mergedXData <- rbind(xTrain, xTest)

names(mergedXData) <- features$V2

mergedYData <- rbind(yTrain, yTest)

mergedSubData <- rbind(subTest, subTrain)

#Extract only measures of mean() and std() for each measurement

exData<- mergedXData[,grep("mean()|std()", names(mergedXData))]

# Label merged data sets

names(mergedSubData) <- "Subject_ID"

names(mergedYData) <-"Activity"

mergedYData$ActivityDesc <-factor(mergedYData$Activity, levels = c(1,2,3,4, 5, 6), labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")) 

fullData<-cbind(mergedSubData, mergedYData, exData)

#Install reshape package (install.packages("reshape") if not already installed
#load reshape package in order to reshape data

library(reshape)

dataMelt <- melt(fullData, id=c("Subject_ID", "Activity"))



