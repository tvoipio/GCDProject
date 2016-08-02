# GCDProject

*Getting and Cleaning Data* course project: human activity data.

## Contents

This repo includes the following files:

* *README.md*: this file
* *run_analysis.R*: an R script for processing the UCI HAR dataset into two abbreviated and tidied dataframes and writes the datasets into text files
* *CodeBook.md*: Detailed information on the tidied dataset produced by *run_analysis.R*
 
## Data source

The dataset is the University of California, Irvine (UCI) *Human Activity Recognition Using Smartphones* dataset, <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>, by Jorge L. Reyes-Ortiz *et al*. The data is distributed as a collection of fixed-width format data files, along with documentation. For more details about the data, how it was obtained, and how it was processed to produce the 561-variable data set, see the original documentation.

## Tidy datasets

The analysis script in this repository (*run_analysis.R*) produces two dataframes into the R environment, *activitydata* and *activitysummary*. The former includes 10,229 observations from a total of 30 test subjects, and each observation includes the test subject ID, classification (test/training data), type physical activity being performed by the test subject, and values of 66 different variables calculated from linear and angular acceleration measurements. The latter dataframe contains the means of the 66 variables for each subject and activity type.

## Data processing

The script *run_analysis.R* performs the steps described below.

### Data acquisition

If the data directory defined at the top of the script does not exist, the UCI HAR Dataset is downloaded from Cloudfront (if necessary) and uncompressed. Further processing assumes that the directory and data file structure is as in the compressed dataset file.

### Activity labels

One of the files in the dataset defines the mapping between physical activities (walking, standing, sitting, etc) and corresponding numeric activity identifiers. The mapping is read from the file and the activity names are converted into lowercase letters.

### Feature selection

The original data includes observations on 561 different "features" derived from the original raw data. From these 561 features, the ones which represent means or standard deviations of physical quantities are selected, 66 features in total. The selection is based on the feature names, with features whose names contain "mean()" or "std()" (standard deviation). Mapping between column numbers in the files containing the actual data and the feature names is read from a file in the dataset.

### Data read-in

Measurement data and numeric activity labels are read into data frames from the respective data files, separately for test and training data. Numeric activity labels are replaced by a factor variable whose levels are human-readable activity names. The test and training data are merged into a single dataframe, with the classification being denoted with a factor variable.

### Summarization

The means of the data on the selected features are calculated for each subject and activity, and stored in the dataframe *activitysummary*.

### Writeout

The data in *activitydata* and *activitysummary* are written out using `write.table()` into the text files `activitydata.txt` and `activitysummary.txt`.