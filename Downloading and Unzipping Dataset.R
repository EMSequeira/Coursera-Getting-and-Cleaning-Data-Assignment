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