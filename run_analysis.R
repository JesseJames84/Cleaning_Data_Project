##Install and load Packages
install.packages("dplyr")
library(dplyr)

## Download and unzip data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
unzip("Dataset.zip", exdir = "/cloud/project/data")


##Load and clean information about activities and features
activitylabels <- read.table("/cloud/project/data/UCI HAR Dataset/activity_labels.txt")
activitylabels <- as.character(activitylabels$V2)
activitylabels <- gsub("_","", activitylabels) ## remove underscore
activitylabels <- tolower(activitylabels) ## lower case

features <- read.table("/cloud/project/data/UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)

wfeatures <- grep(".*mean.*|.*std.*", features$V2)

##Load train and test data
train <- read.table("/cloud/project/data/UCI HAR Dataset/train/X_train.txt")[wfeatures]
act_train <- read.table("/cloud/project/data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("/cloud/project/data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(sub_train, act_train, train)

test <- read.table("/cloud/project/data/UCI HAR Dataset/test/X_test.txt")[wfeatures]
act_test <- read.table("/cloud/project/data/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("/cloud/project/data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(sub_test, act_test, test)

##Merge data
data <- as.numeric(rbind(train, test))

##Add descriptive column names
cnames <- features[wfeatures,2]
cnames <- gsub("[-()]", "", cnames)
cnames <- gsub("^f", "frequencydomain", cnames)
cnames <- gsub("^t", "timedomain", cnames)
cnames <- gsub("Acc", "accelerometer", cnames)
cnames <- gsub("Gyro", "gyroscope", cnames)
cnames <- gsub("Mag", "magnitude", cnames)
cnames <- gsub("Freq", "frequency", cnames)
cnames <- gsub("std", "standarddeviation", cnames)
cnames <- tolower(cnames)
colnames(data) <- c("subject", "activity", cnames)

##Add descriptive activity names
for(i in 1:length(activitylabels)){
  data$activity[data$activity == i] = activitylabels[i]
}

##Create second data set with averages by subject and activity 
avgdata <- group_by(data, subject, activity)
avgdata <- summarise_all(avgdata, mean)

##Convert data to text file
write.table(avgdata, "tidy_data.txt", row.names = FALSE, quote = FALSE)