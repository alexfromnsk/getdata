library("reshape2")
# You should create one R script called run_analysis.R that does the following. 
# 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#I have already unzipped and placed files in my working directory
setwd("C:/Users/Alex/Documents/R-projects/getdata")

#Load information in data.frames
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

# 1.Merges the training and the test sets to create one data set.
x_merged<-rbind(x_train, x_test)
y_merged<-rbind(y_train, y_test)
subject_merged<-rbind(subject_train, subject_test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

logvect_Mean<-which(grepl("mean()",features$V2))
logvect_Std<-which(grepl("std()",features$V2))
logvect_MeanStd<-unique(c(logvect_Mean,logvect_Std))
#I used grep for creating logical vector and which for obtaining positions, combine and get unique
#I don't know should I use "mean" or "mean()", but I think "measurements on the mean and 
#standard deviation for each measurement" means we need to obtain features like fBodyBodyGyroJerkMag-mean() and not fBodyBodyGyroJerkMag-meanFreq()

#subsetting only needed measurements 
x_merged<-x_merged[,logvect_MeanStd]

# 3.Uses descriptive activity names to name the activities in the data set
# just like in step 2
y_merged[,1]<-activities[y_merged[,1],2]

# 4.Appropriately labels the data set with descriptive variable names.
#combine all data in one frame

combined_data<-cbind(subject_merged,y_merged,x_merged)
colnames(combined_data)[c(1,2)]<-c("subject_id","activity_type")

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#just like in lectures, the trick is to use a+b~c formula, look on dcast function help for more info
melted_data <- melt(combined_data, id = c("subject_id", "activity_type"))
mean_data <- dcast(melted_data, subject_id + activity_type ~ variable, mean)
write.table(mean_data, './mean_data.txt',row.name=FALSE)
