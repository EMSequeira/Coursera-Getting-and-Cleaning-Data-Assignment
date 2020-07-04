Code Book for run_analysis.R:

The "Downloading and Unzipping Dataset.R" was first run on its own to download, unzip and prepare the data to be handled ahead of time 
before "run_analsysis.R".
The "run_analysis.R" script follows the 5 steps required as described in the course project assignment.
"run_analysis.R" was later amended to also include the work done in "Downloading and Unzipping Dataset.R", so that all the operations 
were done smoothly in one script.

First, downloaded the dataset and unzipped it to a folder called "UCI HAR Dataset".
Then, assigned each data to a seperate variable, one for every text file of data we had.
Those variables are: activities; features; subject_test; x_test; y_test; subject_train; x_train; and y_train.

  activities <- activity_labels.txt : 6 rows, 2 columns.
    List of activities performed when the corresponding measurements were taken and its codes (labels).
    
  features <- features.txt : 561 rows, 2 columns.
    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    
  subject_test <- test/subject_test.txt : 2947 rows, 1 column.
    contains test data of 9/30 volunteer test subjects being observed.
    
  x_test <- test/X_test.txt : 2947 rows, 561 columns.
    contains recorded features test data.
    
  y_test <- test/y_test.txt : 2947 rows, 1 columns.
    contains test data of activities’code labels.
    
  subject_train <- test/subject_train.txt : 7352 rows, 1 column.
    contains train data of 21/30 volunteer subjects being observed.
    
  x_train <- test/X_train.txt : 7352 rows, 561 columns.
    contains recorded features train data.
    
  y_train <- test/y_train.txt : 7352 rows, 1 columns.
    contains train data of activities’code labels.
   
Now, we can merge the training and the test sets to create one data set.
We did this using the rbind() function. 
X (10299 rows, 561 columns) is created by merging x_train and x_test.
Y (10299 rows, 1 column) is created by merging y_train and y_test.
Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function.

With these three merged, we now made one larger merge called "Merged_Data" which is now a merge of Subject, Y and X with cbind().
Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function.

To extracts only the measurements of the mean and standard deviation for every measurement, we made TidyData.
TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements 
of the mean and standard deviation (std) for each measurement.

Now we go to appropriately labels the data set with descriptive variable names, which basically is to not take shortcuts and abbreviate names.
Entire numbers in code column (column 2) of the TidyData replaced with corresponding activity taken from second column of the activities variable.
  The following is doine with the gsub command for the tidynames for the tidy data:
    code column in TidyData renamed into activities
    Acc in column’s name replaced by Accelerometer
    Gyro in column’s name replaced by Gyroscope
    BodyBody in column’s name replaced by Body
    Mag in column’s name replaced by Magnitude
    Character f in column’s name replaced by Frequency
    Character t in column’s name replaced by Time
    tBody in column’s name replaced by TimeBody
    -mean() in column’s name replaced by Mean
    -std() in column’s name replaced by Standard Deviation
    -freq() in column’s name replaced by TidyData
    angle in column’s name replaced by Angle
    gravity in column’s name replaced by Gravity
    
For the final step, which is from the data set in step 4, create a second, independent tidy data set with the average of each variable for 
each activity and each subject.
  To do this, FinalData was created, the results of it below:
    FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity 
    and each subject, after groupped by subject and activity.
    
