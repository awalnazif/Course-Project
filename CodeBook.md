## The following codes modify the variables names
column_names<- gsub("^t", "time", column_names)
column_names<- gsub("^f", "frequency", column_names)
column_names<- gsub("Acc", "Accelerometer", column_names)
column_names<- gsub("Gyro", "Gyroscope", column_names)
column_names<- gsub("Mag", "Magnitude", column_names)
column_names<- gsub("BodyBody", "Body", column_names)

