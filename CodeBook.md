
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

1. build a detailed X_train data set
1.1    Read the file x_train.txt into a data frame
1.2    Assign meaningful variable names (column headers)
1.2.1  Read the variable descriptor file, features.txt
1.2.2  Combine with X_train to set variable names
1.3    Assign descriptive activity values to each observation
1.3.1  Read the activity code value file, y_train.txt
1.3.2  Cross each activity code value to english label. Read in the activity
       code value cross reference file activity_labels.txt
1.3.3  Merge activity code to english label file
1.3.4  Add the descriptive english labels to X_train data frame labelled activity
1.4    Assign subject ID values to each observation
1.4.1  Read the file subject_train.txt into a vector
1.4.2  Add this vector as column to X_train data frame, labelled Subject_ID

2. Repeat steps A through D for the test set of data, X_test

3. Combine X_train and X_test datasets
3.1   Add a variable to each data set to denote if the data came from the
      training and testing data set

4. Extracts only the measurements on the mean and standard deviation for each 
   measurement.
4.1   Extract the column variables involving means 
4.1.1 Identify the column indices for these variables
4.1.2 Add indicies for subject_ID and activity variable
4.1.3 build data frame based on these columns
4.2   Extract the column variables involving std deviations 
4.2.1 Identify the column indices for these variables
4.2.2 Add indicies for subject_ID and activity variable
4.2.3 build data frame based on these columns

5. creates a second, independent with the average of each variable for each 
   activity and each subject.

6. Conform data set to tidy data principles

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