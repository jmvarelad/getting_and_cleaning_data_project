## Course: Data Science Foundations using R - Getting and Cleaning Data

## Description of the course project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Description of ```run_analysis.R```

- Loads required libraries: dplyr and reshape2.
- Loads test data into dataframes: x_test, y_test and subject_test.
- Loads train data into dataframes: x_train, y_train and subject_train.
- Loads features and activity labels.
- Adds column names to the dataframes.
- Extracts only the measurements on the mean and standard deviation from x_test and x_train.
- Adds activities names to y_test and join with x_test and subject_test, creating a new dataframe (x_joined_test).
- Adds activities names to y_train and join with x_train and subject_train, creating a new dataframe (x_joined_train).
- Merges test and train sets, creating a new dataframe(data_joined).
- Melts data with the function melt.
- Applies mean function to data_joined using dcast function.
- Exports the dataset.
