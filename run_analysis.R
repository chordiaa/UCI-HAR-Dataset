# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

xtrain <- read.table("train/X_train.txt")
xtest <- read.table("test/X_test.txt")
X <- rbind(xtrain, xtest)

subtrain <- read.table("train/subject_train.txt")
subtest <- read.table("test/subject_test.txt")
Subject <- rbind(subtrain, subtest)

ytrain <- read.table("train/y_train.txt")
ytest <- read.table("test/y_test.txt")
Y <- rbind(ytrain, ytest)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]


# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]


# 4. Appropriately labels the data set with descriptive variable names.

names(Subject) <- "subject"
names(Y) <- "activity"
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))



# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

cleaned <- cbind(Subject, Y, X)
uniqueSubjects = unique(Subject)[,1]
numSubjects = length(unique(Subject)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "uci_char_tidy_data_set.txt", row.names=FALSE)