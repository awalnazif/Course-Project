library(dplyr)
library(tidyr)
test_X <- read.table('UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('UCI HAR Dataset/test/y_test.txt')
subject_test<- read.table('UCI HAR Dataset/test/subject_test.txt')
train_X<- read.table('UCI HAR Dataset/train/X_train.txt')
train_y<- read.table('UCI HAR Dataset/train/y_train.txt')
subject_train<- read.table('UCI HAR Dataset/train/subject_train.txt')
features<- read.table('UCI HAR Dataset/features.txt')
means<- grep("mean",features$V2)
stds<- grep("std", features$V2)
test_means<-test_X[,means]
test_stds<-test_X[,stds]
test_means_stds<-bind_cols(test_means,test_stds)
tests<- bind_cols(subject_test,test_y,test_means_stds)
train_means<-train_X[,means]
train_stds<- train_X[,stds]
train_means_stds<- bind_cols(train_means, train_stds)
train<- bind_cols(subject_train,train_y,train_means_stds)
data<- bind_rows(tests, train)
lables<- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
data$V11<-lables[data$V11]
mean_names<- grep("mean",features$V2, value = TRUE)
std_names<- grep("std",features$V2, value = TRUE)
column_names<- c("Subject","Activity", mean_names, std_names)
colnames(data)<- column_names
data2<- select(data, Subject, Activity, contains("mean"))
data2<-gather(data2, Average, Count, names(data2)[3:48]) %>%
        select(Subject,Activity, Count) %>% 
        group_by(Subject, Activity) %>%
        summarise(Average=mean(Count)) %>%
        print()
    
