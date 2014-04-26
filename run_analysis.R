# This script runs an analysis on test and train data according to the specifications
# of the peer assessment. Namely, it joins train and test datasets, keeps specific
# columns and returns the full dataset, as well as a second, independent with some
# averages. For more info, please read README.md and CodeBook.md.


analysis <- function() {
        # Define a list of filenames used for the analysis
        filenames <- c("features.txt", "activity_labels.txt",
                       "X_test.txt", "X_train.txt",
                       "y_test.txt", "y_train.txt",
                       "subject_test.txt", "subject_train.txt")
        
        # If not all file exist, exit with an error.
        if ( !all(file.exists(filenames))) {
                stop("At least one file is missing. Make sure all files exist in the same directory.")
        }
        
        
        # Read the feature labels from the respective file and name them 
        # accordingly.
        features.labels <- read.table("features.txt", stringsAsFactors=F)
        names(features.labels) <- c("feat.num", "feature")
        
        # Read the activity labels from the respective file and name them
        # accordingly.
        activity.labels <- read.table("activity_labels.txt", stringsAsFactors=F)
        names(activity.labels) <- c("act.num", "activity")
        
        
        makedf <- function(type=NULL) {
                ## This function creates a dataframe by combining subject, activity
                ## and mean/std values. 'type' must be either "train" or "test".
                
                # Check whether the argument is valid
                if (!(type %in% c("train", "test"))) {
                        stop("type must be either 'train' or 'test'.")
                }
                
        
                # Read the subject list
                subject <- read.table(paste0("subject_", type, ".txt"), stringsAsFactors=F, comment.char="")
                
                # Read the activities list
                y <- read.table(paste0("y_", type, ".txt"), stringsAsFactors=F, comment.char="")
        
                # In order to substitute numbercodes for descriptive words (i.e. "WALKING"),
                # we use the activity.labels dataframe. We assign the character vector that
                # matches each numbercode from y to an descriptive "activity" of activity.labels
                # back to y.
                names(y) <- "act.num"
                y <- activity.labels[y$act.num, "activity"]
        
                # Read the mean/std values.
                x <- read.table(paste0("X_", type, ".txt"), stringsAsFactors=F, comment.char="")
                
                # Create a dataframe via binding by column subject, y and x
                df <- cbind(subject, y, x)
        
                # Name the resulting dataframe
                names(df) <- c("subject", "activity", features.labels$feature)
                
                # Return the dataframe
                return(df)
                
        }
        
        
        
        # Create the dataframe of training data
        train.df <- makedf("train")
        
        # Create the datagrame of test data
        test.df <- makedf("test")
        
        
        # Create the final dataframe via binding by row the two aforementioned dataframes
        final.df <- rbind(train.df, test.df)
        
        # Keep only the requested column names (subject, activity and all mean/std values) 
        names.keep <- grep("^subject$|^activity$|mean\\(|std\\(", names(final.df))
        final.df <- final.df[, c(names.keep)]
        
        
        # Load the library used for data.table
        library(data.table)
        
        # Create the final datatable with the help of the final dataframe
        final.dtb <- data.table(final.df)
        
        # Key the datatable by subject and activity
        setkeyv(final.dtb, c("subject", "activity"))
        
        # Create the independent tidy dataset by splitting the datatable over subject
        # and activity and then taking the average of the values for the last 66 columns.
        tidydata <- final.dtb[, lapply(.SD, mean), by=list(subject, activity), .SDcols=-c(1:2)]
        
        # Return a list of the full dataframe, as well as the independent tidy dataset
        # of the average values for subject and activity (coerced back into a dataframe).
        return(list(final.df, as.data.frame(tidydata)))

}

# Run the analysis and assign the resulting list to analysis.data
analysis.list <- analysis()

# Assign the full dataframe to analysis.dataframe
analysis.full <- analysis.list[[1]]

# Assign the independent tidy dataset of the averages to analysis.averages
analysis.averages <- analysis.list[[2]]


write.table(analysis.averages, "tidydata.txt")

# Perform some cleanup
rm(analysis.list)
