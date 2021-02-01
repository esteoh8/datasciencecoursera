## Extract the ""UCI HAR Dataset"" files into current directory.
##  	activity_labels
##  	features.txt
##  	features_info.txt
##  	README.txt
##	test   (directory)
##  	train- (directory)
##
## Copy run_analysis.R into this same directory.
## Load libraries
library(dplyr)
library(reshape2)
##
## note: X_train.txt and X_test.txt can be rbind as they have the correct dimensions
## 
## STEP 1: Merges the training and the test sets to create one data set. 

X_train<-read.table("train/X_train.txt",header=FALSE, stringsAsFactors=FALSE)
X_test<-read.table("test/X_test.txt",header=FALSE, stringsAsFactors=FALSE)
X_combine<- rbind(X_train,X_test)
##  Label all the columns 
features<-read.table("features.txt",header=FALSE,stringsAsFactors=FALSE) 
names(X_combine) <-features$V2


## Repeat for data y_train and y_test. NB.  y_train and y_test are the activity labels

y_train<-read.table("train/y_train.txt",header=FALSE, stringsAsFactors=FALSE)
y_test<-read.table("test/y_test.txt",header=FALSE, stringsAsFactors=FALSE)
y_combine<- rbind(y_train,y_test)
##  Label this column "activity"
colnames(y_combine) <- "activity"

## Repeat for training set ""subject_train"" and the test set "subject_test"".

subject_train<-read.table("train/subject_train.txt",header=FALSE, stringsAsFactors=FALSE)
subject_test<-read.table("test/subject_test.txt",header=FALSE, stringsAsFactors=FALSE)
subject_combine<- rbind(subject_train,subject_test)
##  Label this column "subject"
colnames(subject_combine)  <- "subject"

## Use cbind to combine them all into 1 dataset
allcombine<- cbind(subject_combine, y_combine, X_combine)
##
##  STEP 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
##  rbind the column names "subject and "activity" to features. Because we rbind the columns earlier.
features<- rbind( c("NA","activity"),features)
features<- rbind( c("NA","subject"),features)

## Select the columns to keep and copy to new dataset 
colToKeep<-grep("mean\\(\\)|std\\(\\)|activity|subject", tolower(features$V2))
xtidy<-allcombine[,colToKeep]

##
## STEP 3  Uses descriptive activity names to name the activities in the data set
## Replace all numeric activity with their descriptive names.
## Note:
## 1=walking, 2=walking_upstairs, 3=walking_downstairs, 4=sitting, 5=standing, 6=laying

xtidy$activity<-gsub("1","walking",xtidy$activity)
xtidy$activity<-gsub("2","walking_upstairs",xtidy$activity)
xtidy$activity<-gsub("3","walking_downstairs",xtidy$activity)
xtidy$activity<-gsub("4","sitting",xtidy$activity)
xtidy$activity<-gsub("5","standing",xtidy$activity)
xtidy$activity<-gsub("6","laying",xtidy$activity)
##
## STEP 4  Appropriately label the data set with descriptive variable names. 
## All the columns have been appropriately labelled in steps 1-3
## Good practice to remove all special characters eg. "-", ")", "(" 
## and lowercase them
simplifynames<-gsub("-","",names(xtidy))
simplifynames<-tolower(gsub("\\(\\)","",simplifynames))
names(xtidy)<-simplifynames
##
## 
## STEP 5   From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and each subject.
##
##
xtidyfinal<-group_by(xtidy,subject,activity)
xtidyfinal<-summarise_each(xtidyfinal,funs(mean))
##
## Save the tidy data set
write.table(xtidyfinal,file="TidyData.txt",row.names=FALSE)

