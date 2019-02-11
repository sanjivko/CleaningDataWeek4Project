# CleaningDataWeek4Project

How it works
1. The script must be placeed inside the directory created after extracting the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip file.

After extracting the above following directory is created. 
"UCI HAR Dataset"
Place the script run_analysis.R in the along with the README.txt, thats present in the extracted directory.

2. The script first creates a tidy dataframe with the test data and then with the training data and then merges both of them.
   The variables captured are the 561 features and the 128 readings for the gyro/accerator taken in a window. 

3. After merging it extracts the mean and standard deviation columns. 

4. It then summarizes the data based on subject and activity by running mean on all the readings.
