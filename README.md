# Getting and Cleaning Data Course Project
(github repo: get_data_course_project)

John Hopkins Data Specialization on Coursera  
Getting and Cleaning Data (2015-08-03) 

This is the project repository for the Getting and Cleaning Data class on Coursera  
Author: PJ Stockdale
Revision: 2015-08-21

### Background

The purpose of this project is to demonstrate the ability to collect, work 
with, and clean a data set. The goal is to prepare a tidy data that can be used 
for later analysis. The repository contains:  

1.  a tidy data set  
2.  a link to this Github repository with the script for performing the analysis  
3.  CodeBook.md - a code book that describes the variables, the data, and any 
    transformations or work that you performed to clean up the data.   
4.  README.md - explains how all of the scripts work and how they are connected.  

### Motivation

One of the most exciting areas in all of data science right now is wearable 
omputing - see for example this article . Companies like Fitbit, Nike, and 
Jawbone Up are racing to develop the most advanced algorithms to attract new 
users. The data linked to from the course website represent data collected 
from the accelerometers from the Samsung Galaxy S smartphone. 

### Source Data

A full description of the source data is available at the site where the data 
was obtained and from reference [1]: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

along with the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The project creates one R script called run_analysis.R that does the following.
 
1.  Merges the training and the test sets to create one data set. [Step 4](#4)
    
2.  Extracts only the measurements on the mean and standard deviation for each 
    measurement. [Step 5](#5)

3.  Uses descriptive activity names to name the activities in the data set 
    [Step 2.2](#2.2), [3.2](#2.2) 
    
    The variable names have been left as specified in the
    original data. The names there are already very descriptive and, given
    that this data set consists of a single calculation performed on each
    composite variable, the addition of an extra term (such as AvgOf_[variable_name])
    does not add additional information.

4.  Appropriately labels the data set with descriptive variable names. 
    [Step 2.3](#2.3), [2.4](#2.4), [3.3](#2.3), [3.4](#2.4)
    
5.  From the data set in step 4, creates a second, independent tidy data set 
    with the average of each variable for each activity and each subject.
    [Step 5.2](#5.2), [5.3](#5.3)

### Final Data Set Description

The final output data set is named **HAR_mean_std_tidy.txt**.
It consists of 68 variables and 180 observations laid out as follows

The data set contains
the arithmetic means of composite body and gravity acceleration measurements
grouped by subject and activity.

Columns 1, subject_ID and 2, activity are factor variables denoting the groups
over which the remaining 66 variables were summarized. 

1. The file is an ASCII text file.
2. field values are separted by a single space " "
3. observations are separated by a CRLF pair ('\\r\\n')
4. Data file can be read into R using
   mean.std.in <- read.table("HAR_mean_std_tidy.txt", sep=" ", quote="")


The features_info.txt file included in the data package, UCI HAR Dataset.zip,
identify two types of variables involving a mean and standard deviation.
1. 33 derived variables denoted mean() along with 33 variables corresponding 
   variables identifying a standard deviation, std(). 
2. 13 variables denoting a measurement that is comprised of a weighted average
   of component measurements, meanFreq() without corresponding standard deviation
   measurements. 
   
In these variables, these variables describe a single conceptual measurement 
represented by a combination of components. The word mean in the label describes
the method of derivation of a single value rather than identifying a representative
value for a set of distinct measurements. Consequently, the 13 variables 
identified with _meanFreq() were excluded from the final data set


### Comments on processing script run_analysis.R

#### Notes:
Script will attempt to determine if HAR data set is already available locally
If the data is not found, the script will attempt to download the files from
the URL found in the variable data_source_desc (for the description of data
set) and data_source (for the zip file).
If the data is found the script prints a message and skip the download

The acty_ID field which is a numerical index field identifying the type of activity
is retained on the the data set through step 5.3 to facilitate ordering. The
variable is dropped in the final tidy set

The file features.txt contains the column headers for the 561 element data set
Features, in this study, appear to be the columns of the data set

The file X_train.txt contains the actual computed measurements. each row in the
data set correspondes to a particular observation. *NOTE* the data set appears
to be positionally indexed rather than explicetely indext. That is, one row, 
row 1 corresponds to observation 1 and so on. In order to link other dimensional
variables to the individual observations, *DO NOT* reorder the data set before linking

features.txt is a two column data file containing. Col 1 is a sequential number
that appears to corresponds to the column number for that variable in the
X_train.txt file. Col 2 identifies the calculation/variable name. Col 1 and
Col 2 are separated by one space

The files in Inertial Signals/ directories contain the actual, unprocessed 
data measurements. Not used in this analysis.

Data is partitioned into two data sets a traning set contained in source
data directory /train and test data in directory /test


This project deals with the data contained in X_train.txt file. This file
contains a list of 561 columns of computed numerical data


The file activity_labels.txt is a code value file assigning an ID to each
of the six activities. this table is located in the data source parent dir

The file y_train.txt is a row based (positional) foreign key table that links
each of the six activites to the corresponding row in the data file 
(X_train.txt)

the file subject_train.txt contains the numbers identifying the subjects in
the study. The file is positionally indexed so that row 10 in subject_train.txt
corresponds the the data contained in the 10th row of x_train.txt

Since the data files are positionally indexed, we need to perform all of the 
joins before additional filtering.



The features_info.txt file included in the data package identify two types of
variables involving a mean.
1. 33 derived variables denoted mean() along with 33 variables corresponding 
   variables identifying a standard deviation, std(). 
   
2. 13 variables denoting a measurement that is comprised of a weighted average
   of component measurements, meanFreq() without corresponding standard deviation
   measurements. 
   
In these variables, these variables describe a single conceptual measurement 
represented by a combination of components. The word mean in the label describes
the method of derivation of a single value rather than identifying a representative
value for a set of distinct measurements. Consequently, the 13 variables 
identified with _meanFreq() were excluded from the final data set

##### Decomposition

It would be possible to break down each variable (column) name into additional
subcomponents that could be made into factor variables. For example, the variable
name tBodyAcc-mean()-X can be broken
down into four components which, together, describe the meaning of the value such 
as the _t_ or _f_ in the first position which indicates the time or frequency domain
of the original measurement and _BodyAcc_ or _GravityAcc_ refers to the component 
(body or gravity)
contributing the accelleration to the measurement. However, the specific values 
contributing to the mean calculation in the data set, HAR_mean_std_tidy.txt,
are already composite values derived from these subcomponents. No additional
information is gained by breaking down the variable names into factor
variables and, if additional grouping type analysis was necessary, I would
argue that it would be more effective to return to the original data.


#### Processing steps

1. Download data file if needed<br />
1.1    Assign local filenames<br />
1.2    Download codebook and data files (if needed)<br />
1.3    Unzip data file<br />
1.4    Reset data directory to point to study data<br />
<br />
2. build a detailed X_train data set<br />
2.1    Read the file x_train.txt into a data frame<br />
<a name="2.2">2.2</a>    Assign meaningful variable names (column headers)<br />
2.2.1  Read the variable descriptor file, features.txt<br />
2.2.2  Combine with X_train to set variable names<br />
<a name="2.3">2.3</a>    Assign descriptive activity values to each observation<br />
2.3.1  Read the activity code value file, y_train.txt<br />
2.3.2  Cross each activity code value to english label. Read in the activity
       code value cross reference file activity_labels.txt<br />
2.3.3  Merge activity code to english label file<br />
2.3.4  Add the descriptive english labels to X_train data frame labelled activity<br />
<a name="2.4">2.4</a>    Assign subject ID values to each observation<br />
2.4.1  Read the file subject_train.txt into a vector<br />
2.4.2  Add this vector as column to X_train data frame, labelled Subject_ID<br />
2.5    Clean up environment<br />
<br />
3. Repeat steps 2.1 through 2.5 for the test set of data, X_test<br />
<br />
4. <a name="4">Combine</a> X_train and X_test datasets<br />
4.1   Add a variable to each data set to denote if the data came from the
      training and testing data set<br />
<br />
5. <a name="5">Extract</a> the column variables involving means and standard deviation<br />
5.1   Extract the column variables involving means and standard deviation<br />
5.1.1 Identify the column indices for mean variables (33 vars)<br />
5.1.2 Identify the column indices for standard deviation variables (33 vars)<br />
5.1.3 Combine mean and std dev columns along with subject_ID and activity columns<br />
5.1.4 build data frame based on these columns<br />
<a name="5.2">5.2</a>   aggregate results by subject_ID and activity<br />
5.2.1 Compute aggregates<br />
5.2.2 order result set by subject ID and activity (use acty_ID to order by number)<br />
5.2.3 Drop activity_ID column as redundant<br />
<a name="5.3">5.3</a>   Write out tidy data set<br />
<br />
6. Script Environment cleanup<br />
6.1 remove script variables<br />
6.2 return to calling directory<br />
<br />

### References

[1]  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
     Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
     Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
     Vitoria-Gasteiz, Spain. Dec 2012
