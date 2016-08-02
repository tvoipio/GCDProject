# Code book

This file describes the structure of the two dataframes produced by `run_analysis.R` and their relationship to the UCI HAR dataset ("original dataset"). For more information on the original dataset, see its accompanying `README.txt`.

## activitydata

This dataframe consists of 10,229 observations of 66 variables and three classification variables, for a total of 69 columns.  The columns are:

* `subject`, integer in the interval [1, 30]. Identifies the test subject. Obtained from `train/subject_train.txt` and `test/subject_test.txt`
* `activity`, 6-level factor variable (`laying`, `sitting`, `standing`, `walking`, `walking_downstairs`, `walking_upstairs`). Identifies the physical activity performed by the test subject, classification based on video of the subject. Classification is obtained from the UCI HAR dataset by combining the activity data in `train/y_train.txt` and `test/y_test.txt` with the mapping between numeric activity identifiers and text labels in `activity_labels.txt`.
* `classification`, bilevel factor variable (`train`, `test`). Identifies whether the observation is to be treated as *train*ing data or for *test*ing predictive models. The classification is determined by whether the data was in the `train/` directory or the `test/` directory in the original dataset.
* 66 feature columns (see below for details), values derived from accelerometer and gyroscope data as described in the UCI HAR dataset README file. Numeric values, normalized to the interval [-1, 1]. The column order is the same as the order of the features given below. The numeric values of the data are not altered in any way. The column names are derived from the feature names by
    - removing parentheses; and
    - replacing dashes with periods

The following features are included. For their descriptions, see `features_info.txt` in the UCI HAR dataset.

* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()

## activitydatasummary

Contains the means of the values of the 66 feature data columns in `activitydata` for each subject and physical activity and three classification data columns, total of 69 columns. 180 rows in total (30 subjects, 6 distinct activities).

The first 3 columns, `subject`, `activity`, and `classification` are the same as above. The 66 feature data columns represent the means, calculated for each subject-activity combination, of the 66 feature data variables listed above. Each column name is obtained from the column names in `activitydata` by prefixing `ave.` to indicate average value.