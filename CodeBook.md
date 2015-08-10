
The file features.txt contains the column headers for the 561 element data set
Features, in this study, appear to be the columns of the data set

The file X_train.txt contains the actual computed measurements. each row in the
data set correspondes to a particular observation. *NOTE* the data set appears
to be positionally indexed. In order to link other dimensional variables to
the individual observations, *DO NOT* reorder the data set before linking

The column headings in features.txt apply to each of the 561 data columns in
X_train.txt

The files in Inertial Signals/ directories contain the actual, unprocessed 
data measurements. Not used in this analysis.

This project deals with the X_train.txt file

The file activity_labels.txt is a code value file assigning an ID to each
of the six activities


The file y_train.txt is a row based (positional) foreign key table that links
each of the six activites to the corresponding row in the data file (X_train.txt)

uniq 
So, I will want to create a data frame with the values from X_train.txt and
apply the column headers from features.txt
