library(plyr)

# Read data from files
dFeatures <- read.csv("./UCI HAR Dataset/features.txt", header = F, colClasses = "character", sep = "")
names(dFeatures) <- c("feature_id", "feature_name")

dActivityLabels <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = F, colClasses = "character", sep = "")
names(dActivityLabels) <- c("activity_label_id", "activity_label_name")

dSubjectTest <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = F, colClasses = "character", sep = "")
names(dSubjectTest) <- c("subject_id")

dXTest <-read.csv("./UCI HAR Dataset/test/X_test.txt", header = F, colClasses = "numeric", sep = "")
names(dXTest) <- dFeatures$feature_id

dYTest <-read.csv("./UCI HAR Dataset/test/Y_test.txt", header = F, colClasses = "numeric", sep = "")
names(dYTest) <- c("activity_label_id")

dSubjectTrain <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = F, colClasses = "character", sep = "")
names(dSubjectTrain) <- c("subject_id")

dXTrain <-read.csv("./UCI HAR Dataset/train/X_train.txt", header = F, colClasses = "numeric", sep = "")
names(dXTrain) <- dFeatures$feature_id

dYTrain <-read.csv("./UCI HAR Dataset/train/Y_train.txt", header = F, colClasses = "numeric", sep = "")
names(dYTrain) <- c("activity_label_id")

# Merges the training and the test sets to create one data set
dSubjectAll <- rbind(dSubjectTrain, dSubjectTest)
dXAll <- rbind(dXTrain, dXTest)
dYAll <- rbind(dYTrain, dYTest)

# Extracts only the measurements on the mean and standard deviation for each measurement.
dFeatures$is_mean <- with(dFeatures, ifelse(grepl("mean()", feature_name, fixed = T), T, F))
dFeatures$is_std <- with(dFeatures, ifelse(grepl("std()", feature_name, fixed = T), T, F))
tFeatures <- subset(dFeatures, is_mean | is_std)
tXAll <- select(dXAll, as.numeric(tFeatures$feature_id))

# Appropriately labels the data set with descriptive variable names.
#tYAll <- merge(dYAll, dActivityLabels, by = "activity_label_id")
#tFeatures$feature_code <- gsub("\\(\\)", "", gsub("-", "_", tFeatures$feature_name))
names(tXAll) <- tFeatures$feature_name
tAll <- cbind(dSubjectAll, dYAll, tXAll)

# Independent tidy data set with the average of each variable for each activity and each subject.
nAll <- aggregate(tAll[tFeatures$feature_name], by = tAll[c("subject_id", "activity_label_id")], FUN = mean)
nAll <- arrange(nAll, as.numeric(subject_id), activity_label_id)

write.table(nAll, file = "data.txt", row.names = F)
