##############################################################################
# run_analysis.R
#
# Data Science Specialization
# 03 Cleaning and Tidying Data
# project: Tidy data set for Human Activity Recognition using Smartphones
#
##############################################################################
# Author: PJ Stockdale
# Revision: 0.1.0
# Revision Date: 2015-08-06
##############################################################################
# Notes:
# 1. by default, the script assumes it will run within the project directory
#    which will contain downloads, unpacked ata and analysis. The global dir-
#    ectory variables allow customization of these locations
##############################################################################

#-----------------------------------------------------------------------------
# 0. Set environment
#-----------------------------------------------------------------------------
# global directoriesls()
projdir  <- "." # 
dwnlddir <- "." # assume data is relative to current directory
workdir  <- "." # work is peformed in this directory
datadir  <- "." # ultimate location of data
olddir   <- "." # provide for return to calling directory

# source data URI
data_source_desc <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
data_source      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# usefull standard variables
acty.idx.label <- c("activity", "acty_ID")
subj.idx.label <- "subject_id"

# general use files 
out.file.name <- "HAR_mean_std_tidy.txt"  # output file name
cv.col.name <- "features.txt"             # ordered code value table for variable names
cv.activity <- "activity_labels.txt"      # code value table for activity

# Load dplyr package
library(dplyr)

# change into project directory
if(projdir != '.'){
    olddir <- getwd()
    setwd(projdir)
}

# download the project data set
get_data <- TRUE;

# If data has already been downloaded, uncomment the following two lines.
# otherwise, leave these lines commented to ensure data set is downloaded
get_data <- FALSE    # do not actually download data
datadir <- file.path(datadir,"UCI HAR Dataset")


#-----------------------------------------------------------------------------
# 1. Download source data if they do not already exist
#-----------------------------------------------------------------------------
if( get_data == TRUE ){
    # 1.1 local data file names
    codebook_fname <- "human_activity_recognition_codebook.html"
    download_data_fname <- "human_activity_recognition_data.zip"

    # 1.2 download source
    dwnld_dest <- file.path(dwnlddir,codebook_fname)
    if(!file.exists(dwnld_dest)){
        download.file(data_source_desc, dwnld_dest)
    }else{
        print("Data source description file already exists. Skipping download ...")
    }

    dwnld_dest <- file.path(dwnlddir,download_data_fname)
    if(!file.exists(dwnld_dest)){
        download.file(data_source, dwnld_dest, method="curl", extra="-k")
    }else{
        print("Data file already exists. Skipping download ...")
    }
    
    # 1.3 unzip source to data directory
    unzip(zipfile=dwnld_dest, exdir=workdir)
    
    # 1.4 Reset data directory to point to study data
    #     data from zip is in a set of subdirectories under the folder created
    #     when unzipping the archive. Reset the path to these folders
    arclist <-  unzip(dwnld_dest, list=TRUE)
    data.dir.name <- dirname(arclist[[1]][[1]])
    datadir <- file.path(datadir,data.dir.name)
    
    # 1.5 clean up
    rm(codebook_fname, download_data_fname,dwnld_dest, arclist, 
       data.dir.name)
}else{
    print( "Skipping the retrieval of project data ...")
}

#-----------------------------------------------------------------------------
# 2. build a detailed X_train data set
#-----------------------------------------------------------------------------
# 2.0 Set source directory
srcdir <- file.path(datadir,"train")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.1 read the file x_train.txt into a data frame
# data is all numeric with no labels
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fname <- file.path(srcdir,"X_train.txt")
X_train <- read.table(fname, sep="", header=FALSE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.2 Assign meaningful variable names (column headers). 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.2.1 Read the variable descriptor file, features.txt
fname <- file.path(datadir,cv.col.name)
var.names <- read.delim2(fname, header=FALSE, sep=" ")

# 2.2.2 combine with X_train to set variable names
colnames(X_train) <- var.names$V2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.3    Assign descriptive activity values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.3.1  Read the activity code value file, y_train.txt
#        make it a data frame for later convenience
fname <- file.path(srcdir,"y_train.txt")
acty.id <- data.frame(read.table(fname, header=FALSE))
names(acty.id) <- c("acty_ID")

# 2.3.2  Cross each activity code value to english label. Read in the activity
#        code value cross reference file activity_labels.txt
fname <- file.path(datadir,cv.activity)
acty.label <- read.table(fname, header=FALSE)
names(acty.label) <- c("acty_ID", "acty_label")

# 2.3.3  Merge activity code to english label file, use dplyr package
acty.df.1 <- left_join(acty.id, acty.label, by="acty_ID")

# 2.3.4  Add the descriptive english labels to X_train data frame labelled activity
X_train_bak2 <- X_train           # for mistake recovery
X_train <- cbind(acty.df.1$acty_label, acty.df.1$acty_ID, X_train)
names(X_train)[1:2] <- acty.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.4    Assign subject ID values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.4.1  Read the file subject_train.txt into a vector and coerce the integer
#        variable representing subject to a factor
fname <- file.path(srcdir, "subject_train.txt")
subj.id <- read.table(fname)

# 2.4.2  Add this vector as column to X_train data frame, labelled Subject
X_train_bak1 <- X_train              # for mistake recovery
X_train <- cbind( subj.id, X_train)
names(X_train)[1] <- subj.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.5 Environment clean up
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note X_train_bak1 & X_train_bak2 could also be removed if space or memory
#      were an issue
rm(subj.id, acty.id, acty.df.1)

#-----------------------------------------------------------------------------
# 3. build a detailed X_test data set
#-----------------------------------------------------------------------------
# 3.0 Set source directory
srcdir <- file.path(datadir,"test")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.1 read the file x_test.txt into a data frame
# data is all numeric with no labels
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fname <- file.path(srcdir,"X_test.txt")
X_test <- read.table(fname, sep="", header=FALSE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.2 Assign meaningful variable names (column headers). 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.2.1 Read the variable descriptor file, features.txt
#       use the df var.names created in step 1.2.1

# 3.2.2 combine with X_ to set variable names
colnames(X_test) <- var.names$V2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.3    Assign descriptive activity values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.3.1  Read the activity code value file, y_test.txt
#        make it a data frame for later convenience
fname <- file.path(srcdir,"y_test.txt")
acty.id <- data.frame(read.table(fname, header=FALSE))
names(acty.id) <- c("acty_ID")

# 3.3.2  Cross each activity code value to english label. use the data frame
#        acty.label created in step 1.3.2

# 3.3.3  Merge activity code to english label file, use dplyr package
acty.df.2 <- left_join(acty.id, acty.label, by="acty_ID")

# 3.3.4  Add the descriptive english labels to X_test data frame labelled activity
X_test_bak1 <- X_test                  # for mistake recovery
X_test <- cbind(acty.df.2$acty_label, acty.df.2$acty_ID, X_test)
names(X_test)[1:2] <- acty.idx.label


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.4    Assign subject ID values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.4.1  Read the file subject_test.txt into a vector and coerce the integer
#        variable representing subject to a factor
fname <- file.path(srcdir, "subject_test.txt")
subj.id <- read.table(fname)

# 3.4.2  Add this vector as column to X_test data frame, labelled Subject
X_test_bak2 <- X_test                  # for mistake recovery
X_test <- cbind(subj.id, X_test)
names(X_test)[1] <- subj.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.5 Environment clean up
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Note X_test_bak1 & X_test_bak2 could also be removed if space or memory
#      were an issue
rm(subj.id, acty.id, acty.label, acty.df.2, var.names)

#-----------------------------------------------------------------------------
# 4. Combine X_train and X_test datasets
#-----------------------------------------------------------------------------
# 4.1   append the test data set to the training data set
data.comb <- rbind(X_train, X_test)  

#-----------------------------------------------------------------------------
# 5. create a second, independent with the average of each variable for each 
#    activity and each subject
#-----------------------------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.1 Extract the column variables involving means and standard deviation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.1.1 Identify the column indices for mean variables (33 vars)
mean.cols <- grep("mean[(]",names(data.comb), ignore.case=TRUE)

# 5.1.2 Identify the column indices for standard deviation variables (33 vars)
std.cols <- grep("std[(]",names(data.comb), ignore.case=TRUE)

# 5.1.3 Combine mean and std dev columns along with subject_ID and activity columns
#       although not strictly necessary, we will sort the column numbers so 
#       that the original order of the columns will be maintained (68 vars)
mean.std.vars <- sort( c( 1, 2, 3, mean.cols, std.cols) )

# 5.1.4 build data frame based on these columns
#       expecting 10299 obs with 69 variables each
mean.std.df <- data.comb[, mean.std.vars]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.2 aggregate results by subject_ID and activity
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.2.1 Compute aggregates
mean.std.aggr <- aggregate(mean.std.df[,-(1:2)], by=list( subject_ID=mean.std.df$subject_id, activity=mean.std.df$activity), mean)

# 5.2.2 order result set by subject ID and activity (use acty_ID to order by number)
mean.std.sorted <- mean.std.aggr[order(mean.std.aggr$subject_ID, mean.std.aggr$acty_ID),]

# 5.2.3 Drop activity_ID column as redundant
mean.std.tidy <- mean.std.sorted[, -3]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.3 Write out tidy data set
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5.3.1 output to text file
fname <- file.path(projdir,out.file.name)
write.table(mean.std.tidy, fname, quote=FALSE)

#-----------------------------------------------------------------------------
# 6. Script environment cleanup
#-----------------------------------------------------------------------------

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 6.1 remove data and other variables
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# remove intermediate data
rm( data.comb,   mean.std.aggr, mean.std.df,  mean.std.sorted, 
    X_test_bak1, X_test_bak2,   X_train_bak1, X_train_bak2 )

# remove master data sets (comment out if you wish to retain)
rm(X_test)
rm(X_train)
rm(mean.std.tidy)

# remove unneeded variables
rm( acty.idx.label, cv.activity, cv.col.name, datadir, dwnlddir, fname,
    get_data, mean.cols, mean.std.vars, out.file.name, srcdir, std.cols,
    subj.idx.label, workdir,  data_source_desc, data_source)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 6.2 return to original calling directory
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if(projdir != '.'){
    setwd(olddir)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 6.3 and finish
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rm(projdir, olddir)