library(tidyr);library(dplyr) #load libraries

#load all relevant data sets
subject_test<-read.table("subject_test.txt")
x_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
titles<-read.table("features.txt")
subject_train<-read.table("subject_train.txt")
x_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")

#rename all activities
y_test[y_test==1]<-"WALKING"
y_test[y_test==2]<-"WALKING UPSTAIRS"
y_test[y_test==3]<-"WALKING DOWNSTAIRS"
y_test[y_test==4]<-"SITTING"
y_test[y_test==5]<-"STANDING"
y_test[y_test==6]<-"LAYING"
y_train[y_train==1]<-"WALKING"
y_train[y_train==2]<-"WALKING UPSTAIRS"
y_train[y_train==3]<-"WALKING DOWNSTAIRS"
y_train[y_train==4]<-"SITTING"
y_train[y_train==5]<-"STANDING"
y_train[y_train==6]<-"LAYING"

#rename all columns with the relevant labels
subject_test<-rename(subject_test, Person=V1)
y_test<-rename(y_test, Activity=V1)
names(x_test)<-titles[[2]]
subject_train<-rename(subject_train, Person=V1)
y_train<-rename(y_train, Activity=V1)
names(x_train)<-titles[[2]]

#bind all data into one dataframe
test_all<-cbind(subject_test, y_test, x_test)
train_all<-cbind(subject_train, y_train, x_train)
full_data<-rbind(train_all, test_all)
validnames<-make.names(names=names(full_data), unique = TRUE, allow_=TRUE)
names(full_data)<-validnames

#filter the data to only contain columns containing "mean" and "std"
filtered_data<-select(full_data, Person, Activity,contains("mean"), contains("std"))

#apply a function to average all columns for each activity and for each person

final_averages<-aggregate( .~Person+Activity, filtered_data, mean )


#export the final table
write.table(final_averages, "~/Documents/coursera/gettingdata/week4/UCI HAR Dataset/final_averages.txt", sep="\t", row.name=FALSE) 

