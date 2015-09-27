# Getting And Cleaning Data Course Project

There is 3 files in the repo to finish this project.

## run_analysis.R

R script use to do the following things.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## data.txt

The tidy data set created in step 5 of the r script. Created with function *write.table()* in r using *row.name=FALSE* as parameter.

## CodeBook.md

The code book that describes the variables, the data, and any transformations or work that the script performed to clean up the data.