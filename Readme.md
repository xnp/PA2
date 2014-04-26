Readme file for peer assessment
-------------------------------

This repository has the following files:


- **CodeBook.md** - a code book that describes the variables, the data, and the various transformations that were performed in order to clean up the data

- **Readme.md** - this file
                
- **run_analysis.R** - the main script file that performs the analysis on the data, namely:
    
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names. 
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Requirements
--
The library `data.table` must be installed in the R environment.

Execution
--
In order to perform the analysis, one may run:

```R
source("run_analysis.R")
```

at the R prompt. The script expects the following files residing in the same directory:

- features.txt
- activity_labels.txt
- X_test.txt
- X_train.txt
- y_test.txt
- y_train.txt
- subject_test.txt
- subject_train.txt

If any file is missing, an error is thrown.


After a successfull execution, the following datasets are returned:
 - **analysis.full** - a dataframe containing the full merged train and test data
 - **analysis.averages** - a dataframe containing an independent tidy set with the averages of mean and StdDev values for each subject and each activity.
 
Also, **tidydata.txt**, a text file with the tidy set from `analysis.averages` created in the directory.
