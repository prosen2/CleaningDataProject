Read Me file for Activity Data Cleaning Project
===================

The files in this Repo are for the Getting and Cleaning Data Project.

Repo Contents
=============
Run_Analysis.R - R programing script to create a tidy data set

CodeBook.md - Markdown file that describes the original data set, and the process used to transform the data into a tidy data set

MeanActivityData.txt - The resulting tidy data set that was produced by Run_Analysis.R

Development of the Tidy Data Set
================================

Using the above data, a tidy data set was produced using the following steps with the R Programing language (version 3.0.3) on Mac OS 10.10

1. The data was downloaded from the original file location at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. The data was unzipped and all files were placed in the working directory

3. The following tables were read into R: subject_test, subject_train, X_test, y_test, X_train, y_train, features

4. The following tables were combined x_train and x_test, y_train and y_test, subject_test and subject_train

5. The feature names were used a column headers for the combined x tables.

6. Only those variable that were a name or standard deviation measure were extracted from this X table

7. A column of descriptive names was added to the Y table to describe the activity according to the activity_labels descriptions (i.e.: walking for 1, etc)

8. The Heading “Subject_ID” was added to the Subject table and “Activity” was used for the Y table

9. All three tables were merged into one dataset, called fullData in the script

10. Using the reshape2 package in R, the fullData table was melted and then recast (using dcast) to create an independent, tidy dataset with the average of each variable for each activity and each subject.

11. write.table was used to export this dataset to a text file called MeanActivityData.txt which is available in this Repo