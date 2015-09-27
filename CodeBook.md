
## Raw Data
Data sets just load from the data files. All uses `read.csv` for load action.

- **dFeatures**: Load from "UCI HAR Dataset/features.txt". List of all features.

- **dActivityLabels**: Load from "UCI HAR Dataset/activity_labels.txt". Links the class labels with their activity name.

- **dSubjectTest**: Load from "UCI HAR Dataset/test/subject_test.txt". Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. And this is for test data.

- **dXTest**: Load from"UCI HAR Dataset/test/X_test.txt". A 561-feature vector with time and frequency domain variables. And this is for test data.

- **dYTest**: Load from"UCI HAR Dataset/test/Y_test.txt".
Each row identifies the labels which performed the activity for each window sample. And this is for test data.

- **dSubjectTrain**:  Load from"UCI HAR Dataset/train/subject_train.txt". Same as dSubjectTest, except this is for train data.

- **dXTrain**: Load from"UCI HAR Dataset/train/X_train.txt". Same as dXTest, except this is for train data.

- **dYTrain**: Load from"UCI HAR Dataset/train/Y_train.txt". Same as dYTest, except this is for train data.


## Merges the training and the test sets.
There are 3 kinds of data, subject, x, and y, need to be merged. All uses `rbind` for merge action.

- **dSubjectAll**: Merged from *dSubjectTrain* and  *dSubjectTest*.

- **dXAll**: Merged from *dXTrain* and *dXTest*.

- **dYAll**: Merged from *dYTrain* and *dYTest*.


## Extracts only the measurements on the mean and standard deviation for each measurement.
Add 2 veriables to determine whether the feature is on the mean and standard deviation. Uses `grepl` to find feature name contains "mean()" or "std()". Uses `ifelse` to return whether true or false to new variables. And uses `with` to loop judgment function within all records in *dFeatures*.

- **dFeatures$is_mean**: Boolean type veriable. Use to determine whether the feature name contans "mean()".

- **dFeatures$is_std**: Boolean type veriable. Use to determine whether the feature name contans "std()".

Create data set to keep features on the mean and standard deviation only. Uses `subset` do the filter.

- **tFeatures**:  Features just keep features on the mean and standard deviation.

Extracts only the measurements on the mean and standard deviation. Uses `select` chose variables contains in *tFeatures*.

- **tXAll**:  Data from *dXAll*, just keep variables contains in *tFeatures*.


## Uses descriptive activity names to name the activities in the data set
Uses feature names to name the activities in the data set. Uses `names` to set names of data set *tXAll* with *tFeatures$feature_name*.


## Merge all data into one data set.
Merge the 3 kinds of data into one. Uses `cbind` for this merge action.

- **tAll**: All data in one. Merged from *dSubjectAll*, *dYAll* and *tXAll*.


## Independent tidy data set with the average of each variable for each activity and each subject.
Uses mean function to aggregate variables, group by subject and activity. Uses `aggregate` calculate mean. And uses `arrange` to make data set in proper order.

- **nAll**: Aggregate from *tAll*. Tidy data set with the average of each variable for each activity and each subject.

