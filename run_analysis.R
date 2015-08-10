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
projdir  <- "." # assume script is run from project directory
dwnlddir <- "." # assume data is relative to current directory
workdir  <- "." # work is peformed in this directory
datadir  <- "." # ultimate location of data

# change into project directory
if(projdir != '.'){
    olddir <- getwd()
    setwd(projdir)
}

#-----------------------------------------------------------------------------
# Download source data if they do not already exist
#-----------------------------------------------------------------------------
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

# data from zip is in a set of subdirectories under the folder created when
# unzipping the archive.  Get the path to these folders
arclist <-  unzip(dwnld_dest, list=TRUE)
data.dir.name <- dirname(arclist[[1]][[1]])

# reset datadir variable to point to the actual data directory
datadir <- file.path(datadir,data.dir.name)

# return to original directory
if(projdir != '.'){
    setwd(olddir)
}
