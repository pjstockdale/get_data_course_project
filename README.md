# Getting and Cleaning Data Course Project
(get_data_course_project)

John Hopkins Data Specialization on Coursera  
Getting and Cleaning Data (2015-08-03) 

This is the project repository for the Getting and Cleaning Data class on Coursera  
Author: PJ Stockdale  

### Background

The purpose of this project is to demonstrate my ability to collect, work 
with, and clean a data set. The goal is to prepare tidy data that can be used 
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

### Data

A full description of the source data is available at the site where the data 
was obtained and from reference [1]: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

along with the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The project creates one R script called run_analysis.R that does the following.
 
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each 
    measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set 
    with the average of each variable for each activity and each subject.

### Data Set Description


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

### References

[1]  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
     Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
     Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
     Vitoria-Gasteiz, Spain. Dec 2012
