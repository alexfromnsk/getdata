Getting and Cleaning Data Coursera Course

run_analysis.R performs the tasks needed by our lectures:

•	0. Loads library and information in data.frames from train/test/activity/features .txt files

•	1. Merges train and test data via rbind.

•	2. Extracts only the measurements on the mean and standard deviation for each measurement by creating a subsetting logical vector with features positions in features.txt

•	3. Labels activity in the activity type (y’datas) data

•	4. Merges processed subject, activity and X-data in one dataframe. Renames the columns in this dataframe.

•	5. Generates a new dataset with average measures for each subject and activity type. Melt and dcast from “reshape2” library is used. 

Output is saved as mean_data.txt.
