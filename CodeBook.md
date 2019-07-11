---
title: "CodeBook"
output: html_document
---

The raw dataset describes Human Activity Recognition Using Smartphones Dataset.
The dataset is in the folder "Dataset".

To prepare the dataset the run_analysis.R script performs 5 steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The resulting tidy dataset contains the average values for all variables for each activity and each subject.
