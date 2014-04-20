# CodeBook
## Coursera Getting and Cleaning Data: Project

### Purpose
This Code Book describes the variables, the data, and any transformations or work that was performed to clean up the data and produce "tidydata.csv".

### Variables
Below is an extract that describes each of the variable types in the dataset "tidydata.csv".

* id: Unique record identifier in tidydata.csv
* Subjects: The subjects who undertook the trial
* activityDesc:   A Description of the activity that was carried out e.g. WALKING, STANDING, etc...
* Features which have been selected from the original UCI HAR Dataset. These features are described below:

#### Feature Selection
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

The complete list of variables of each feature vector is available in 'UCI HAR Dataset/features.txt' 



### Data
Data can be found in your work directory in "tidydata.csv"" and "averages.csv"

#### tidydata.csv
This file contains the means and standard deviations for each set of the measurements for each feature plus the activity that was taking place and the subject that carried out the trial. There are multiple records for each activity and each subject.    

For a complete list of variables is "tidydata.csv" please see variables.md

#### averages.csv

This file contains the avearges of the means and standard deviations for all the measurements in both the training and test data sets. The averages have been calculated by for each subject within each activity .The data is ordered by activity then by subject.      

Variables in this file are:  
* activityDesc  
* Subjects  
* average of means and standard deviations....

For a complete list of variables is "averages.csv" please see variables.md  

### Transformations
Steps involved in producing "tidydata.csv"" and "averages.csv"

#### UCI HAR Dataset Data Model
For an idea of how the UCI HAR data links together see the data model click the link below:  
https://docs.google.com/presentation/d/1c38KQPjkOHfm-b4j9FZWysKkAPRU-CrxhdJAYTKkL4Q/edit?usp=sharing

#### Import Data from UCI HAR Dataset and produce "tidydata.csv"
1. Read in reference data from files and add column names. This reference data (contained in features.txt and activities.txt provided the link to the activities that occured to produce the results in X_test.txt, Y_test.txt, X_train.txt, Y_train.txt)
2. Read in Test data from files and add column names. Note: X_test.txt gets its column names from features.txt
3. Make a large flat data frame for Test Data called 'tt'
4. Repeat the same steps for the Training data. Read in Training data from files and add column names. Note: X_train.txt gets its column names from features.txt
5. Make a large flat data frame for Training Data called 'tn'
6. Merge training and test data sets using a union methodoloygy (rbind to append test data to the training dataset). During the Training and Test dataset creation a column called dataSetInd was added to indicate which dataset the record came from originally e.g. Training or Test.
7. Next get only measurements on the mean and standard deviation for each measurement as the assignment requests.
8. Add these measurements to the Tidy Dataset and write it to file as "tidydata.csv".

#### Calculate Averages for each measurement in "tidydata.csv" export as "averages.csv""
1. Next create second, independant dataset with averages of each variable for each activity and each subject. Export as "averages.csv".
2. Create data.table called dt (data table is faster for aggregations and merges)
3. Remove '-', ',' and '()' from names in data table so they can be accessed in the data.table
4. Group by Activities and Subjects and calculate the mean for each column of mean and standard deviation measurements
5. Order data by Activity then by Subjects 
6. Write data to file averages.csv in your working directory



























