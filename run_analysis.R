#Prior to running this script, you will need to download the data
#Download files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#unzip the contents into your working directory in a folder called "UCI HAR Dataset"
#Set the working Directory in R to the UCI HAR Dataset Folder

setwd("~/Desktop/UCI HAR Dataset") #Here the file is stored on the Desktop, adjust path as needed

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
mergedYData <- rbind(yTrain, yTest)
mergedSubData <- rbind(subTest, subTrain)

#Step 2: Extract only measures of mean() and std() for each measurement

names(mergedXData) <- features$V2 # Assigns variable names on top of each column of merged dataset, will be used to extract only means and std's

exData<- mergedXData[,grep("mean()|std()", names(mergedXData))] 

#Step 3: Use descriptive names to name each activity in the data set

names(mergedYData) <-"Activity"

mergedYData$ActivityDesc <-factor(mergedYData$Activity, levels = c(1,2,3,4,5,6), labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")) 

#Step 4: Appropriately label the data set with descriptive variable names

names(mergedSubData) <- "Subject_ID" #Other descriptive names already added above when needed


#Complete merger into a single data set
fullData<-cbind(mergedSubData, mergedYData, exData)


#Step 5: Create a second, independently tidy data set with the averages of each variable for each activity and each subject 

#Install reshape2 package (install.packages("reshape2") if not already installed
#load reshape2 package in order to reshape data

library(reshape2)

titleList <-names(exData) # creates the variable list for melt

dataMelt <- melt(fullData, id.var=c("Subject_ID", "ActivityDesc"), measure.vars=titleList)

dataMeans <- dcast(dataMelt, Subject_ID + ActivityDesc ~ variable, mean)

write.table(dataMeans, "MeanActivityData.txt", row.name=FALSE, sep = "\t")
