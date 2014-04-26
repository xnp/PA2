Code book file for peer assessment
----------------------------------

The data used in this analysis comes from the [Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).

This document presents the initial data information, the procedure selected for cleaning the initial data and the resulting data.


Initial dataset information
--

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
	

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

    mean(): Mean value
    std(): Standard deviation
    mad(): Median absolute deviation 
    max(): Largest value in array
    min(): Smallest value in array
    sma(): Signal magnitude area
    energy(): Energy measure. Sum of the squares divided by the number of values. 
    iqr(): Interquartile range 
    entropy(): Signal entropy
    arCoeff(): Autorregresion coefficients with Burg order equal to 4
    correlation(): correlation coefficient between two signals
    maxInds(): index of the frequency component with largest magnitude
    meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    skewness(): skewness of the frequency domain signal 
    kurtosis(): kurtosis of the frequency domain signal 
    bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

    gravityMean
    tBodyAccMean
    tBodyAccJerkMean
    tBodyGyroMean
    tBodyGyroJerkMean



Processing the data
--
In order to combine the train and test data, the following steps were performed:
 - a "features.labels" and an "activity.labels" dataframes were constructed in order to keep the respective descriptive fields.
 - a dataframe constructor was created that combines test or train data by reading the subject, activity and measurements files and then joining them together, after replacing the numbercodes of activity with descriptive words.
 - after creating the two separate but complete train and test dataframes, they were combined by row.
 - the resulting dataframed was further trimmed down via dropping all non-"mean/std" or "subject", "activity" variables.
 - a data.table was created by the trimmed down dataframe, where a fucntion was performed on the subsetted (by subject and activity) data.
 - the procedure till this moment was wrapped inside a function called "analysis()" in order to better modularize the code.
 - "analysis()" returned a list with two elements, the full dataframe of the 10299 observations and the independent dataframe of the averages by subject and activity.
 - the first list element was assigned to `analysis.full` while the second to `analysis.averages`.



Resulting data
--
The resulting data consists of two indpendent datasets:

 1. The `analysis.full` dataframe contains the combined test and train dataset of 10299 observations of 68 variables ("subject", "activity" and just the "mean()" and "std()" variables from the initial dataset) with the same meaning and value of each variable, except in the `activity` variable where the numbercode has been replaced with a descriptive label (i.e. "WALKING", "STANDING", etc) with respect to the initial dataset.

 2. The `analysis.averages` dataframe contains 180 observations of 68 variables("subject", "activity" and the average of the rest 66 variables of the previous dataset, for each subject and each activity.

