# In this run_analysis.R script, we will be:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.
# All of these things will be done shortly down below.

# Befofe we do any work in tidying the dataset, we first need to download, unzip and prepare the data
# that we will be working with. This will be done first down below.

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
# We will be doing this in accordance to the 5 steps that are outlined in the assignment description.

# Step 1: Merging the training and test datasets to make a single data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Step 2: Extract only the measurements on the mean and standard deviation.

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Step 3: Use descriptive activity names to name all the activities in the data set.

TidyData$code <- activities[TidyData$code, 2]

# Step 4: Appropriately label the data set.

# What gsub does below is substitute the current names in the TidyData dataset we made with more
# appropriate, descriptive names, mainly it just being the full word or name instead of just an 
# abbreviation.

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "Standard Deviation", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# Step 5: Create a second, independent, tidy data set with the averages of each variable for every
# training activity and every subject.

FinalData <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

# With this done, we can view the FinalData table from the environment tab in R Studio, and we should see
# a nice, clean, tidy table, with labeled rows and columns, and one value per column, with one trial 
# observation per row.