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
# Set environment
#-----------------------------------------------------------------------------
# global directoriesls()
projdir  <- "." # 
dwnlddir <- "." # assume data is relative to current directory
workdir  <- "." # work is peformed in this directory
datadir  <- "." # ultimate location of data

# usefull standard variables
acty.idx.label <- c("activity", "acty_ID")
subj.idx.label <- "subject_id"

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
# Download source data if they do not already exist
#-----------------------------------------------------------------------------
if( get_data == TRUE ){
    # file names
    codebook_fname <- "human_activity_recognition_codebook.html"
    download_data_fname <- "human_activity_recognition_data.zip"

    # source data URI
    data_source_desc <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
    data_source      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

    # download source
    dwnld_dest <- file.path(dwnlddir,data_source_desc)
    if(!file.exists(dwnld_dest)){
        download.file(data_source_desc, dwnld_dest)
    }else{
        print("Data source description file already exists. Skipping download ...")
    }

    dwnld_dest <- file.path(dwnlddir,download_data_fname)
    if(!file.exists(dwnld_dest)){
        download.file(data_source, dwnld_dest, method="curl", extra="-k")

        # unzip source to data directory
        unzip(zipfile=dwnld_dest, exdir=workdir)
    }else{
        print("Data file already exists. Skipping download ...")
    }

    # data from zip is in a set of subdirectories under the folder created
    # when unzipping the archive.  Get the path to these folders
    arclist <-  unzip(dwnld_dest, list=TRUE)
    data.dir.name <- dirname(arclist[[1]][[1]])

    # reset datadir variable to point to the actual data directory
    datadir <- file.path(datadir,data.dir.name)
}else{
    print( "Skipping the retrieval of project data ...")
}

#-----------------------------------------------------------------------------
# 1. build a detailed X_train data set
#-----------------------------------------------------------------------------
# 1.0 Set source directory
srcdir <- file.path(datadir,"train")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.1 read the file x_train.txt into a data frame
# data is all numeric with no labels
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fname <- file.path(srcdir,"X_train.txt")
X_train <- read.table(fname, sep="", header=FALSE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.2 Assign meaningful variable names (column headers). 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.2.1 Read the variable descriptor file, features.txt
fname <- file.path(datadir,"features.txt")
var.names <- read.delim2(fname, header=FALSE, sep=" ")

# 1.2.2 combine with X_train to set variable names
colnames(X_train) <- var.names$V2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.3    Assign descriptive activity values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.3.1  Read the activity code value file, y_train.txt
#        make it a data frame for later convenience
fname <- file.path(srcdir,"y_train.txt")
acty.id <- data.frame(read.table(fname, header=FALSE))
names(acty.id) <- c("acty_ID")

# 1.3.2  Cross each activity code value to english label. Read in the activity
#        code value cross reference file activity_labels.txt
fname <- file.path(datadir,"activity_labels.txt")
acty.label <- read.table(fname, header=FALSE)
names(acty.label) <- c("acty_ID", "acty_label")

# 1.3.3  Merge activity code to english label file, use dplyr package
#acty.df.1 <- merge(acty.id, acty.label, by="acty_ID", sort=FALSE)
acty.df.1 <- left_join(acty.id, acty.label, by="acty_ID")

# Verify merge is correct count occurances of each acty.id
#df1 <- acty.df %>% count(acty_ID)
#df2 <- acty.id %>% count(acty_ID)
#if( identical(df1, df2) ){
#    print("Verifying build of activity cross reference table ... OK")
#}else{
#    print("Verifying build of activity cross reference table ... FAIL")
#}

# 1.3.4  Add the descriptive english labels to X_train data frame labelled activity
X_train_bak2 <- X_train           # for mistake recovery
#X_train <- cbind(acty.df.1$acty_label, X_train)
X_train <- cbind(acty.df.1$acty_label, acty.df.1$acty_ID, X_train)
names(X_train)[1:2] <- acty.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.4    Assign subject ID values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.4.1  Read the file subject_train.txt into a vector and coerce the integer
#        variable representing subject to a factor
fname <- file.path(srcdir, "subject_train.txt")
subj.id <- read.table(fname)
#subj.id$V1 <- as.factor(subj.id$V1)

# 1.4.2  Add this vector as column to X_train data frame, labelled Subject
X_train_bak1 <- X_train              # for mistake recovery
X_train <- cbind( subj.id, X_train)
names(X_train)[1] <- subj.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.5 Environment clean up
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#rm(df1, df2, subj.id, acty.id, acty.df, X_train_bak1, X_train_bak2)


#-----------------------------------------------------------------------------
# 2. build a detailed X_test data set
#-----------------------------------------------------------------------------
# 2.0 Set source directory
srcdir <- file.path(datadir,"test")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.1 read the file x_test.txt into a data frame
# data is all numeric with no labels
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fname <- file.path(srcdir,"X_test.txt")
X_test <- read.table(fname, sep="", header=FALSE)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.2 Assign meaningful variable names (column headers). 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.2.1 Read the variable descriptor file, features.txt
#       use the df var.names created in step 1.2.1
#fname <- file.path(datadir,"features.txt")
#var.names <- read.delim2(fname, header=FALSE, sep=" ")

# 2.2.2 combine with X_ to set variable names
colnames(X_test) <- var.names$V2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.3    Assign descriptive activity values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.3.1  Read the activity code value file, y_test.txt
#        make it a data frame for later convenience
fname <- file.path(srcdir,"y_test.txt")
acty.id <- data.frame(read.table(fname, header=FALSE))
names(acty.id) <- c("acty_ID")

# 2.3.2  Cross each activity code value to english label. use the data frame
#        acty.label created and 1.3.2

# 2.3.3  Merge activity code to english label file, use dplyr package
#acty.df.2 <- merge(acty.id, acty.label, by="acty_ID", all=TRUE, sort=FALSE)
acty.df.2 <- left_join(acty.id, acty.label, by="acty_ID")

# Verify merge is correct count occurances of each acty.id
#df1 <- acty.df %>% count(acty_ID)
#df2 <- acty.id %>% count(acty_ID)
#if( identical(df1, df2) ){
#    print("Verifying build of activity cross reference table ... OK")
#}else{
#    print("Verifying build of activity cross reference table ... FAIL")
#}

# 2.3.4  Add the descriptive english labels to X_test data frame labelled activity
X_test_bak2 <- X_test                  # for mistake recovery
#X_test <- X_test_bak2
#X_test <- cbind(acty.df$acty_label, X_test)
X_test <- cbind(acty.df.2$acty_label, acty.df.2$acty_ID, X_test)
names(X_test)[1:2] <- acty.idx.label


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.4    Assign subject ID values to each observation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.4.1  Read the file subject_test.txt into a vector and coerce the integer
#        variable representing subject to a factor
fname <- file.path(srcdir, "subject_test.txt")
subj.id <- read.table(fname)
#subj.id$V1 <- as.factor(subj.id$V1)

# 2.4.2  Add this vector as column to X_test data frame, labelled Subject
X_test_bak1 <- X_test                  # for mistake recovery
#X_test <- X_test_bak1
#X_test$subject_ID <- subj.id
X_test <- cbind(subj.id, X_test)
names(X_test)[1] <- subj.idx.label

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2.5 Environment clean up
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#rm(df1, df2, subj.id, acty.id, acty.label, acty.df, X_test_bak1, X_test_bak2)

#-----------------------------------------------------------------------------
# 3. Combine X_train and X_test datasets
#-----------------------------------------------------------------------------
# 3.1   append the test data set to the training data set
data.comb <- rbind(X_train, X_test)  

#-----------------------------------------------------------------------------
# 4.1   Extract the column variables involving means and standard deviation
#-----------------------------------------------------------------------------
# 4.1.1 Identify the column indices for mean variables (33 vars)
mean.cols <- grep("mean[(]",names(data.comb), ignore.case=TRUE)

# 4.1.1 Identify the column indices for standard deviation variables (33 vars)
std.cols <- grep("std[(]",names(data.comb), ignore.case=TRUE)

# 4.1.2 Combine mean and std dev columns along with subject_ID and activity columns
#       although not strictly necessary, we will sort the column numbers so 
#       that the original order of the columns will be maintained (68 vars)
mean.std.vars <- sort( c( 1, 2, 3, mean.cols, std.cols) )

# 4.1.3 build data frame based on these columns
#       expecting 10299 obs with 68 variables each
mean.std.df <- data.comb[, mean.std.vars]

#-----------------------------------------------------------------------------
# complete data processing
#-----------------------------------------------------------------------------

#mean.std.sorted <- mean.std.df[order(mean.std.df$subject_id, mean.std.df$activity),]
#mean.std.sorted <- mean.std.df[order(mean.std.df$subject_id, mean.std.df$acty_ID),]
#mean.std.sorted <- mean.std.df[order(mean.std.df$acty_ID, mean.std.df$subject_id),]

# aggregate results by subject_ID and activity
#mean.df.aggr <- aggregate(mean.std.sorted[,-(1:2)], by=list( subject_ID=mean.std.sorted$subject_id), mean)
mean.df.aggr <- aggregate(mean.std.df[,-(1:2)], by=list( subject_ID=mean.std.df$subject_id, activity=mean.std.df$activity), mean)
#mean.df.aggr.1 <- aggregate(mean.std.sorted[,-(1:2)], by=list( subject_ID=mean.std.sorted$subject_id, activity=mean.std.sorted$activity), mean)
#mean.df.aggr.2 <- aggregate(mean.std.sorted[,-(1:2)], by=list( subject_ID=mean.std.sorted$subject_id, activity=mean.std.sorted$acty_ID), mean)

mean.df.final <- mean.df.aggr[order(mean.df.aggr$subject_ID, mean.df.aggr$acty_ID),]

#-----------------------------------------------------------------------------
# Environment cleanup
#-----------------------------------------------------------------------------

# return to original directory
if(projdir != '.'){
    setwd(olddir)
}
