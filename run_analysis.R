#*********************************************************
#  This is the script which executes the project section
#  of the Coursera Getting and Cleaning Data course.
#
#  Bruce Beauchamp
#  21 Aug 2014
#*********************************************************

#  Merge the training and test data sets to create a single data set.
#  Assumes that the training and test data are in child directories
#  named test/ and training/, and that the merged files will
#  be in a directory called merged

#  Create the merged directory if it doesn't already exist

if (! file.exists('merged')) {
  dir.create(file.path('merged'))
}

#  Copy the training data to the merged data, replacing it if it
#  already exists.

file.copy("train/X_train.txt", "merged/X_merged.txt", overwrite=TRUE, copy.mode=TRUE)
file.append("merged/X_merged.txt", "test/X_test.txt")

file.copy("train/y_train.txt", "merged/y_merged.txt", overwrite=TRUE, copy.mode=TRUE)
file.append("merged/y_merged.txt", "test/y_test.txt")

file.copy("train/subject_train.txt", "merged/subject_merged.txt", overwrite=TRUE, copy.mode=TRUE)
file.append("merged/subject_merged.txt", "test/subject_test.txt")


#  Load the merged data into a data frame

merged_data_frame <- read.table('merged/X_merged.txt')


# Now get the column names from the features.txt file

features <- read.csv('features.txt', header = FALSE, sep = " ", stringsAsFactors = FALSE)
colnames_list <- features[,2]


#  Change the column names of the merged data frame

for (i in 1:ncol(merged_data_frame)) {
  colnames(merged_data_frame)[i] <- features[i, 2]
}


# copy the merged_data_frame to the mean_sd_data_frame, keeping only the columns
# which represent the mean or std dev of one of the activities

mask <- (grepl("mean()", colnames_list) | grepl("std()", colnames_list))
mean_sd_data_frame <- merged_data_frame[, mask]


#  Now, mean_sd_data_frame contains only those columns which contain mean() or std() in their names.
#  Lets append the activity type merged_y as a column at the end of the mean_sd_data_frame

act_type_id <- read.table("merged/y_merged.txt")
mean_sd_activ_data_frame <- cbind(mean_sd_data_frame, act_type_id)
colnames(mean_sd_activ_data_frame)[ncol(mean_sd_activ_data_frame)] <- "activity_id"

#  Next, append the subject ID as a column

subject_id <- read.table("merged/subject_merged.txt")
mean_sd_activ_subject <- cbind(mean_sd_activ_data_frame, subject_id)
colnames(mean_sd_activ_subject)[ncol(mean_sd_activ_subject)] <- "subject_id"



#  mean_sd_active_subject now contains the column with the activity IDs and subject on it.  
#  We now need to merge the column with the activity names corresponding to the IDs

#  First, load the activity labels into a data frame, and change to more meaningful column names
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels)[1] <- "activity_id"
colnames(activity_labels)[2] <- "activity"

#  "md" stands for "merged data"
md <- merge(mean_sd_activ_subject, activity_labels, by.x="activity_id", by.y="activity_id", all=FALSE)


#  Now calculate the average value for each activity, for each subject, and store it in a dataframe

grouped <- aggregate(md[,2:80],by=list(md$subject_id, md$activity_id), mean)
colnames(grouped)[1] <- 'subject_id'
colnames(grouped)[2] <- 'activity_id'

# write.matrix(grouped, file = "avg_by_subject_activity.csv", sep = ",")

write.table(grouped, file = "avg_by_subject_activity.txt", row.name=FALSE)
