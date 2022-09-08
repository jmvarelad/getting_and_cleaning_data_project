## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#0. Preliminary steps
#load required libraries
library(dplyr)
library(data.table)
library(reshape2)

#read test set
x_test <- read.delim("./test/X_test.txt", header = FALSE, sep = "", dec = ".")
y_test <- read.delim("./test/y_test.txt", header = FALSE, sep = "", dec = ".")
subject_test <- read.delim("./test/subject_test.txt", header = FALSE, sep = "", dec = ".")

#read training set
x_train <- read.delim("./train/X_train.txt", header = FALSE, sep = "", dec = ".")
y_train <- read.delim("./train/y_train.txt", header = FALSE, sep = "", dec = ".")
subject_train <- read.delim("./train/subject_train.txt", header = FALSE, sep = "", dec = ".")

#read features
features <- read.delim("./features.txt", header = FALSE, sep = "", dec = ".")

#read activity_labels
act_labels <- read.delim("./activity_labels.txt", header = FALSE, sep = "", dec = ".")

#add column names
cols <- features %>% select(2)
colnames(x_test) <- cols$V2
colnames(x_train) <- cols$V2

#extract only the measurements on the mean and standard deviation
x_test_f <- x_test %>% select(contains("mean()")|contains("std()"))
x_train_f <- x_train %>% select(contains("mean()")|contains("std()"))

#add activities names to y_test and join with x_test and subject_test
y_test <- y_test %>% mutate(act_labels[y_test[,1],])
colnames(y_test) <- c("Activity_ID", "Activity_name")
colnames(subject_test) = "Subject"
x_joined_test <- cbind(y_test, subject_test, x_test_f)

#add activities names to y_train and join with x_train and subject_train
y_train <- y_train %>% mutate(act_labels[y_train[,1],])
colnames(y_train) <- c("Activity_ID", "Activity_name")
colnames(subject_train) = "Subject"
x_joined_train <- cbind(y_train, subject_train, x_train_f)

#------------------------------------------------------------------------------
#1. merge test and train sets, and create a new data set
data_joined <- rbind(x_joined_test, x_joined_train)

#------------------------------------------------------------------------------
#2. extract only the measurements on the mean and standard deviation
#Already done

#------------------------------------------------------------------------------
#3. Uses descriptive activity names to name the activities in the data set
#Already done

#------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive activity names.
#Already done

#------------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
id_labels <- c("Subject", "Activity_ID", "Activity_name")
data_labels <- setdiff(colnames(data_joined), id_labels)

#Melt data with the function melt
melt_data <- melt(data_joined, id = id_labels, measure.vars = data_labels)

#Apply mean function to data_joined using dcast function
tidy_data <- dcast(melt_data, Subject + Activity_name ~ variable, mean)

#Export the data set
write.table(tidy_data, file = "./tidy_data.txt")
