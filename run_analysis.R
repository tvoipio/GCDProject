# Getting and Cleaning Data, JHU
# Course Project
# TV 2016-08-01

library(dplyr)

data_zip_name <- "UCI_HAR_Dataset.zip"
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_dir <- file.path(".", "UCI HAR Dataset")

# If the data directory does not exist, create it and extract files from the archive
# (downloading the archive if necessary)
if (!dir.exists(data_dir))
{
    if (!file.exists(data_zip_name))
    {
        download.file(data_url, data_zip_name)
    }
    
    unzip(data_zip_name)
    
} else {
    print(paste("Data directory", data_dir, "exists, will not download or unzip"))
}

origwd <- getwd()
setwd(data_dir)

# Activity labels
actlabels <- read.table("activity_labels.txt", col.names = c("act.ID", "activity"))
actlabels$activity <- factor(tolower(as.character(actlabels$activity)))

# Features
features <- read.table("features.txt", col.names = c("feat.ID", "feat.name"),
                       stringsAsFactors = FALSE)

# Feature IDs for means and standard deviations
ext.feats <- features[grepl("std\\(\\)|mean\\(\\)", features$feat.name), "feat.ID"]

feat.cols <- rep("NULL", nrow(features))
feat.cols[ext.feats] <- "numeric"

feat.col.names <- rep("", nrow(features))
col.names <- gsub("\\.+", "\\.",
                  make.names(features[ext.feats, "feat.name"]))
col.names <- sub("\\.$", "", col.names)
feat.col.names[ext.feats] <- col.names

datalist <- list()

for (datatype in c("test", "train"))
{
    file.end <- paste0("_", datatype, ".txt")
    subject <- read.table(file.path(datatype, paste0("subject", file.end)),
                          col.names = "subject")
    label <- read.table(file.path(datatype, paste0("y", file.end)),
                        col.names = c("act.ID"))
    featdata <- read.table(file.path(datatype, paste0("X", file.end)),
                           colClasses = feat.cols,
                           col.names = feat.col.names,
                           #nrows = 10, # DEGUB
                           comment.char = "")
    
    # Note to self: cbind converts strings to factors (see help), thus
    # no need to explicitly convert "class" to a factor
    data <- cbind(subject, label, classification = rep(datatype, nrow(featdata)), featdata)
    
    # Replace activity IDs with (factor) label
    data <- merge(data, actlabels, by = "act.ID", sort = FALSE)
    data <- select(data, -act.ID)
    
    # Reorder columns for a touch of userfriendliness
    data <- select(data, subject, activity, classification, everything())
    
    datalist[[datatype]] <- data
    rm("file.end", "subject", "label", "featdata", "data")
}

activitydata <- rbind(datalist[["train"]], datalist[["test"]])
rm("datalist")

# Create a summarised data set with the means of each variable
activitysummary <- activitydata %>%
    group_by(subject, activity, classification) %>%
    summarize_at(feat.col.names[ext.feats], mean)

ave.col.names <- paste0("ave.", col.names)
# Change the column names to indicate that the data represent means
names(activitysummary) <- c(names(activitysummary)[1:3], ave.col.names)

activitysummary <- ungroup(activitysummary)

# Cleanup
setwd(origwd)