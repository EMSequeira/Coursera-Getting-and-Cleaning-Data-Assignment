# For this first script, we are simply downloading and unzipping the dataset so that we can work
# with it later on.

library(dplyr)

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

# Check if this data set exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Unzipping if the data set exists.
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

# We should now have the unzipped UCI HAR Dataset in our repository in R, and are ready to move onwards!

# Now, we can assign asll the data frames that we have in our dataset.
# We want to read all the tables that appear in the data set txt files, so we will run read.table multiple times
# for every text file we have access to, to register all the informaiton. 

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# With this all done and read into R, we can proceed with cleaning up the data.
