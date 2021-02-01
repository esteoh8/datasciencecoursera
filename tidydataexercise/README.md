# REAME.md


The data for this exercise is from experiments performed by
----------
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws

----------
Data for the project:     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##  The above UCI HAR Dataset" unpacked into following structure:

		- 	activity_labels.txt -- defines the numeric code for each of the 6 activities
		- 	features_info.txt  -- describes the features
		- 	features.txt          -- complete list of all 561 features
		- 	README.txt        
		- 	test                       - directory for test data
		- 	train                      - directory for training data	 


##  run_analysis.R  (located in the same directory as files above)

The **run_analysis.R** script produces a tidy dataset. It does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Note: run_analysis.R uses the following:  **library(dplyr)** and **library(reshape2)**

###  This is best read whilst referring to the run_analysis.R script

###  The datasets were read using the format:

dataset <-read.table("filename.txt",header=FALSE, stringsAsFactors=FALSE)


###  STEP 1: MERGING THE TRAINING AND TEST SETS

1. rbind was used to merge the training dataset and test dataset
2. The features dataset was used as column names. Add column names using the format: eg.   names(X_combine) <-features$V2
3. Merged the subject and activity columns and label the columns "subject and  "activity"
4. Use cbind to join the dataset to get the completely merged dataset. (X_combine)


###  STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 


1. rbind the column names "subject and "activity" to features. Because we rbind the columns earlier.
2. Get names of all columns to keep using the grep command
3. Copy the selected columns to a new dataset  xtidy

###  STEP 3: Uses descriptive activity names to name the activities in the data set
1. Replace all numeric activity with their descriptive name.  Use the format:

				eg:	xtidy$activity <-gsub("1","walking",xtidy$activity)

	Note:  1=walking,  2=walking_upstairs,  3=walking_downstairs,  4=sitting,  5=standing,  6=laying

 
###  STEP 4:   Appropriately labels the data set with descriptive variable names. 

Convert all labels/variables to lowercase and remove all "special characters"** as recommended good practice.

1. Use gsub and tolower to converts all names/variables to lowercase and removes all special characters eg. "-", ")", "("

###  STEP 5:  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1.  groupby each subject and their activities and calculate the "average of the means" and the "average of the standard deviations".
2.  Use group_by() and summarise() commands.


###  Save the tidy data set 
1. Write out the tidy dataset using:  table(xtidy,file="TidyData.txt",row.names=FALSE)

