library(dplyr)

# load the datasets
X_train <- read.table("Dataset/train/X_train.txt")
X_test <- read.table("Dataset/test/X_test.txt")
y_train <- read.table("Dataset/train/y_train.txt")
y_test <- read.table("Dataset/test/y_test.txt")
features <- read.table("Dataset/features.txt")
activities <- read.table("Dataset/activity_labels.txt")
subject_train <- read.table("Dataset/train/subject_train.txt")
subject_test <- read.table("Dataset/test/subject_test.txt")

# rename columns of datasets
feature_names <- vector(mode = "character", length = 561)
feature_names <- features[["V2"]]
colnames(X_train) <- feature_names
colnames(X_test) <- feature_names
colnames(y_train) <- "code"
colnames(y_test) <- "code"
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

# Merges the training and the test sets to create one data set
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
dataset <- cbind(subject_data, X_data, y_data)

# Extracts only the measurements on the mean and standard deviation for each measurement
dataset <- dataset[, grep("subject|code|mean|std",  colnames(dataset))]

# Uses descriptive activity names to name the activities in the data set
dataset <- merge(dataset, activities, by.x = "code", by.y = "V1")
names(dataset)[names(dataset) == "V2"] <- "activity"
dataset$code <- NULL

# Appropriately labels the data set with descriptive variable names
names(dataset)<-gsub("-mean()", "Mean", names(dataset), ignore.case = TRUE)
names(dataset)<-gsub("-std()", "STD", names(dataset), ignore.case = TRUE)
names(dataset)<-gsub("-freq()", "Frequency", names(dataset), ignore.case = TRUE)
names(dataset)<-gsub("^f", "Frequency", names(dataset))
names(dataset)<-gsub("^t", "Time", names(dataset))
names(dataset)<-gsub("Acc", "Accelerometer", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("tBody", "TimeBody", names(dataset))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject
average_dataset <- dataset %>% group_by(subject, activity) %>% summarise_all(list(mean))
write.table(average_dataset, "TidyAverageData.txt", row.name=FALSE)