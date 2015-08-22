###Code book for Getting and Cleaning Data Course Project

The final tidy data set **HAR_mean_std_tidy.txt** contains 180 observations across 68
variables. Variables 1 and 2 are 

#### Factors and Variables

**Factor variables** - identifies the specific observation as a combination of
the subject performing the activity and the activity performed.

1: subject_ID

integer - subject_ID values range from 1-30 and identify a specific subject participating
in the study. Taken from the suject_*.txt file in the respective /train or
/test directories of the HAR data set

2: activity

character - identifies the activity being performed. the value represents the
english language statement of the activity such as WALKING and was taken from
the activity_labels.txt file of the HAR data set. 

* 1 WALKING<br />
* 2 WALKING_UPSTAIRS<br />
* 3 WALKING_DOWNSTAIRS<br />
* 4 SITTING<br />
* 5 STANDING<br />
* 6 LAYING<br />

**Computed variables** - consist of the arithmetic mean of the computed statistic
across groups identified by subject_ID and activity as follows

The variable names have been left as specified in the original data. The names
there are already very descriptive and, given that this data set consists of a
single calculation performed on each variable, the addition of an extra term 
(such as AvgOf_[variable_name]) would not add additional information but would
make the resultant variable names harder to read. Refer to the original codebook, **[features_info.txt](#ref1)**, for a more complete explanation of the meaning of the 
specific variable names

3:   tBodyAcc-mean()-X <br />
4:  tBodyAcc-mean()-Y<br />
5: tBodyAcc-mean()-Z<br />
6: tBodyAcc-std()-X<br />
7: tBodyAcc-std()-Y<br />
8: tBodyAcc-std()-Z<br />
9: tGravityAcc-mean()-X<br />
10: tGravityAcc-mean()-Y<br />
11: tGravityAcc-mean()-Z<br />
12: tGravityAcc-std()-X<br />
13: tGravityAcc-std()-Y<br />
14: tGravityAcc-std()-Z<br />
15: tBodyAccJerk-mean()-X<br />
16: tBodyAccJerk-mean()-Y<br />
17: tBodyAccJerk-mean()-Z<br />
18: tBodyAccJerk-std()-X<br />
19: tBodyAccJerk-std()-Y<br />
20: tBodyAccJerk-std()-Z<br />
21: tBodyGyro-mean()-X<br />
22: tBodyGyro-mean()-Y<br />
23: tBodyGyro-mean()-Z<br />
24: tBodyGyro-std()-X<br />
25: tBodyGyro-std()-Y<br />
26: tBodyGyro-std()-Z<br />
27: tBodyGyroJerk-mean()-X<br />
28: tBodyGyroJerk-mean()-Y<br />
29: tBodyGyroJerk-mean()-Z<br />
30: tBodyGyroJerk-std()-X<br />
31: tBodyGyroJerk-std()-Y<br />
32: tBodyGyroJerk-std()-Z<br />
33: tBodyAccMag-mean()<br />
34: tBodyAccMag-std()<br />
35: tGravityAccMag-mean()<br />
36: tGravityAccMag-std()<br />
37: tBodyAccJerkMag-mean()<br />
38: tBodyAccJerkMag-std()<br />
39: tBodyGyroMag-mean()<br />
40: tBodyGyroMag-std()<br />
41: tBodyGyroJerkMag-mean()<br />
42: tBodyGyroJerkMag-std()<br />
43: fBodyAcc-mean()-X<br />
44: fBodyAcc-mean()-Y<br />
45: fBodyAcc-mean()-Z<br />
46: fBodyAcc-std()-X<br />
47: fBodyAcc-std()-Y<br />
48: fBodyAcc-std()-Z<br />
49: fBodyAccJerk-mean()-X<br />
50: fBodyAccJerk-mean()-Y<br />
51: fBodyAccJerk-mean()-Z<br />
52: fBodyAccJerk-std()-X<br />
53: fBodyAccJerk-std()-Y<br />
54: fBodyAccJerk-std()-Z<br />
55: fBodyGyro-mean()-X<br />
56: fBodyGyro-mean()-Y<br />
57: fBodyGyro-mean()-Z<br />
58: fBodyGyro-std()-X<br />
59: fBodyGyro-std()-Y<br />
60: fBodyGyro-std()-Z<br />
61: fBodyAccMag-mean()<br />
62: fBodyAccMag-std()<br />
63: fBodyBodyAccJerkMag-mean()<br />
64: fBodyBodyAccJerkMag-std()<br />
65: fBodyBodyGyroMag-mean()<br />
66: fBodyBodyGyroMag-std()<br />
67: fBodyBodyGyroJerkMag-mean()<br />
68: fBodyBodyGyroJerkMag-std()<br />

####Transformations

1. The final data set contains the arithmetic mean of each of the variables indexed
3 through 68 grouped by the subject_ID and activity variables

2. The file Y_*.txt in the
/train or /test data directories contain a list of activity codes assigned to
each observations in the x_*.txt data set. The corresponding english language
assignment, as listed in the activity_labels.txt file was matched to each code in Y_*.txt and assigned to each observation

------------------------------------------------------------------------------
------------------------------------------------------------------------------

<a name="ref1">Feature_info.txt</a>

[1]  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
     Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
     Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
     Vitoria-Gasteiz, Spain. Dec 2012

Feature Selection 

The features selected for this database come from the accelerometer and gyroscope
3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals 
(prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then 
they were filtered using a median filter and a 3rd order low pass Butterworth 
filter with a corner frequency of 20 Hz to remove noise. Similarly, the 
acceleration signal was then separated into body and gravity acceleration 
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth 
filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derivd 
in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also 
the magnitude of these three-dimensional signals were calculated using the 
Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals 
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ<br />
tGravityAcc-XYZ<br />
tBodyAccJerk-XYZ<br />
tBodyGyro-XYZ<br />
tBodyGyroJerk-XYZ<br />
tBodyAccMag<br />
tGravityAccMag<br />
tBodyAccJerkMag<br />
tBodyGyroMag<br />
tBodyGyroJerkMag<br />
fBodyAcc-XYZ<br />
fBodyAccJerk-XYZ<br />
fBodyGyro-XYZ<br />
fBodyAccMag<br />
fBodyAccJerkMag<br />
fBodyGyroMag<br />
fBodyGyroJerkMag<br />

The set of variables that were estimated from these signals are: 

mean(): Mean value<br />
std(): Standard deviation<br />
mad(): Median absolute deviation<br /> 
max(): Largest value in array<br />
min(): Smallest value in array<br />
sma(): Signal magnitude area<br />
energy(): Energy measure. Sum of the squares divided by the number of values.<br /> 
iqr(): Interquartile range <br />
entropy(): Signal entropy<br />
arCoeff(): Autorregresion coefficients with Burg order equal to 4<br />
correlation(): correlation coefficient between two signals<br />
maxInds(): index of the frequency component with largest magnitude<br />
meanFreq(): Weighted average of the frequency components to obtain a mean frequency<br />
skewness(): skewness of the frequency domain signal <br />
kurtosis(): kurtosis of the frequency domain signal <br />
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.<br />
angle(): Angle between to vectors.<br />

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean<br />
tBodyAccMean<br />
tBodyAccJerkMean<br />
tBodyGyroMean<br />
tBodyGyroJerkMean<br />

The complete list of variables of each feature vector is available in 'features.txt'