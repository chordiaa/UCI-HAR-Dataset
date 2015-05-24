# UCI-HAR-Dataset
Project data for course Getting and Cleaning data from Coursera

Unzip the source data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive.

Save the code in file run_analysis.R with the same filename into the folder where you stored the unzipped data from the previous step.

In R or RStudio set the working directory to the folder of the R script and source data using the setwd command. Next enter the following command:
 source("run_analysis.R")

A file uci_char_tidy_dat_set.txt will be added to the folder which will contain the tidy data set.

The R script performs the following steps on the source data to generate the tidy data set:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each    variable for each activity and each subject.