# Course-Project
## Peer-graded Assignment: Getting and Cleaning Data Course Project
## By Awal, Nazif

## Loading the required package
library(dplyr)

## Reading in the already downloaded tests datasets
test_X <- read.table('UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('UCI HAR Dataset/test/y_test.txt')
subject_test<- read.table('UCI HAR Dataset/test/subject_test.txt')

## Reading in the alraedy downloaded train datasets
train_X<- read.table('UCI HAR Dataset/train/X_train.txt')
train_y<- read.table('UCI HAR Dataset/train/y_train.txt')
subject_train<- read.table('UCI HAR Dataset/train/subject_train.txt')

## Reading in the already downloaded features dataset
features<- read.table('UCI HAR Dataset/features.txt')

## subsetting the features dataset with names mean
means<- grep("mean",features$V2)

## subsetting the features dataset with names std
stds<- grep("std", features$V2)

## subsetting the test_x dataset for column names with means
test_means<-test_X[,means]

## subsetting the test_x dataset for column names with stds
test_stds<-test_X[,stds]

## Combining the test_x dataset with column names means (test_means) and stds (test_stds)
test_means_stds<-bind_cols(test_means,test_stds)

## Combining the subject_test dataset with test_X columns with names means and stds
tests<- bind_cols(subject_test,test_y,test_means_stds)

## subsetting the train_x dataset for column names with means
train_means<-train_X[,means]

## subsetting the train_x dataset for column names with stds
train_stds<- train_X[,stds]

## Combining the train_x dataset with column names means (train_means) and stds (train_stds)
train_means_stds<- bind_cols(train_means, train_stds)

## Combining the subject_train dataset with train_X columns with names means and stds
train<- bind_cols(subject_train,train_y,train_means_stds)

## Combining the tests and train datasets
data<- bind_rows(tests, train)

## Reading in the activity_labels  dataset
labels<- read.table("UCI HAR Dataset/activity_labels.txt")

## Subsetiing the 2nd column of the label dataset
labels<- labels$V2

## Replacing the 2nd column (V11) of dataset set named data with activity labels
data$V11<-labels[data$V11]

## Subsetting the 2nd column(v2) of the features dataset with names means
mean_names<- grep("mean",features$V2, value = TRUE)

## Subsetting the 2nd column(v2) of the features dataset with names std
std_names<- grep("std",features$V2, value = TRUE)

## Creating variable names for the dataset data
column_names<- c("Subject","Activity", mean_names, std_names)

## Modifying the variables names
column_names<- gsub("^t", "time", column_names)
column_names<- gsub("^f", "frequency", column_names)
column_names<- gsub("Acc", "Accelerometer", column_names)
column_names<- gsub("Gyro", "Gyroscope", column_names)
column_names<- gsub("Mag", "Magnitude", column_names)
column_names<- gsub("BodyBody", "Body", column_names)

## Naming the variable columns of the dataset data
colnames(data)<- column_names

## Writing the dataset set to a file name "data.txt"
write.table(x = data, file = "data.txt")
