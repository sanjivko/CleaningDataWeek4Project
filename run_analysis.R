#run_analysis.R
library(stringi)
library(tidyverse)
#setwd 
#setwd("C:/Users/ojhas/Documents/DataScTools/R/Week4Assignment/UCI HAR Dataset")

activity_label = as_tibble(readLines("activity_labels.txt"))
al = vector(mode="character")
for (i in activity_label$value) {
  al[length(al)+1] = unlist(stri_split_fixed(i, " "))[2]
  #print (al)
}



features = as_tibble(read.table("features.txt", stringsAsFactors = FALSE))
#unique(features$V2)

#Training data###############################################################################################
#read subjects
subject = as_tibble(readLines("train/subject_train.txt"))
colnames(subject) <- c('subject')

#read actvities and convert to names
activity = as_tibble(readLines("train/y_train.txt"))
activity = activity %>% mutate(activity=al[as.numeric(value)]) %>% mutate(value=NULL)

#read feature data
f_data = as_tibble(read.table("train/X_train.txt"))
names(f_data) <- str_replace_all(make.unique(features$V2), regex("[,-]"), "_")

#str_replace_all(features$V2, regex("[,-]"), ".")
                
#read inertial signals
bodyAccX = as_tibble(read.table("train/Inertial Signals/body_acc_x_train.txt"))
colnames(bodyAccX) <- paste("bodyAccX", colnames(bodyAccX), sep = '_')

bodyAccY = as_tibble(read.table("train/Inertial Signals/body_acc_y_train.txt"))
colnames(bodyAccY) <- paste("bodyAccY", colnames(bodyAccY), sep = '_')

bodyAccZ = as_tibble(read.table("train/Inertial Signals/body_acc_z_train.txt"))
colnames(bodyAccZ) <- paste("bodyAccZ", colnames(bodyAccZ), sep = '_')

bodyGyroX = as_tibble(read.table("train/Inertial Signals/body_gyro_x_train.txt"))
colnames(bodyGyroX) <- paste("bodyGyroX", colnames(bodyGyroX), sep = '_')

bodyGyroY = as_tibble(read.table("train/Inertial Signals/body_gyro_y_train.txt"))
colnames(bodyGyroY) <- paste("bodyGyroY", colnames(bodyGyroY), sep = '_')

bodyGyroZ = as_tibble(read.table("train/Inertial Signals/body_gyro_z_train.txt"))
colnames(bodyGyroZ) <- paste("bodyGyroZ", colnames(bodyGyroZ), sep = '_')

totalAccX = as_tibble(read.table("train/Inertial Signals/total_acc_x_train.txt"))
colnames(totalAccY) <- paste("totalAccY", colnames(totalAccY), sep = '_')

totalAccY = as_tibble(read.table("train/Inertial Signals/total_acc_y_train.txt"))
colnames(totalAccY) <- paste("totalAccY", colnames(totalAccY), sep = '_')

totalAccZ = as_tibble(read.table("train/Inertial Signals/total_acc_z_train.txt"))
colnames(totalAccZ) <- paste("totalAccZ", colnames(totalAccZ), sep = '_')


inertial_d = as_tibble(cbind(bodyAccX, bodyAccY, bodyAccZ, bodyGyroX, bodyGyroY, bodyGyroZ, totalAccX,totalAccY,totalAccZ))


train_d = as_tibble(cbind(subject, activity,  inertial_d, f_data))

#Test Data ####################################################################################################
#read subjects
subject = as_tibble(readLines("test/subject_test.txt"))
colnames(subject) <- c('subject')

#read actvities and convert to names
activity = as_tibble(readLines("test/y_test.txt"))
activity = activity %>% mutate(activity=al[as.numeric(value)]) %>% mutate(value=NULL)

#read feature data
f_data = as_tibble(read.table("test/X_test.txt"))
names(f_data) <- str_replace_all(make.unique(features$V2), regex("[,-]"), "_")

#read inertial signals
bodyAccX = as_tibble(read.table("test/Inertial Signals/body_acc_x_test.txt"))
colnames(bodyAccX) <- paste("bodyAccX", colnames(bodyAccX), sep = '_')

bodyAccY = as_tibble(read.table("test/Inertial Signals/body_acc_y_test.txt"))
colnames(bodyAccY) <- paste("bodyAccY", colnames(bodyAccY), sep = '_')

bodyAccZ = as_tibble(read.table("test/Inertial Signals/body_acc_z_test.txt"))
colnames(bodyAccZ) <- paste("bodyAccZ", colnames(bodyAccZ), sep = '_')

bodyGyroX = as_tibble(read.table("test/Inertial Signals/body_gyro_x_test.txt"))
colnames(bodyGyroX) <- paste("bodyGyroX", colnames(bodyGyroX), sep = '_')

bodyGyroY = as_tibble(read.table("test/Inertial Signals/body_gyro_y_test.txt"))
colnames(bodyGyroY) <- paste("bodyGyroY", colnames(bodyGyroY), sep = '_')

bodyGyroZ = as_tibble(read.table("test/Inertial Signals/body_gyro_z_test.txt"))
colnames(bodyGyroZ) <- paste("bodyGyroZ", colnames(bodyGyroZ), sep = '_')

totalAccX = as_tibble(read.table("test/Inertial Signals/total_acc_x_test.txt"))
colnames(totalAccY) <- paste("totalAccY", colnames(totalAccY), sep = '_')

totalAccY = as_tibble(read.table("test/Inertial Signals/total_acc_y_test.txt"))
colnames(totalAccY) <- paste("totalAccY", colnames(totalAccY), sep = '_')

totalAccZ = as_tibble(read.table("test/Inertial Signals/total_acc_z_test.txt"))
colnames(totalAccZ) <- paste("totalAccZ", colnames(totalAccZ), sep = '_')


inertial_d = as_tibble(cbind(bodyAccX, bodyAccY, bodyAccZ, bodyGyroX, bodyGyroY, bodyGyroZ, totalAccX,totalAccY,totalAccZ))


test_d = as_tibble(cbind(subject, activity,  inertial_d, f_data))



merged_data = rbind(test_d, train_d)

mean_std_dv_data = select(merged_data, matches("subject|activity|mean[()]|std[()]", ignore.case = FALSE) )
mean_std_dv_data                        
?matches

final = mean_std_dv_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(final, row.names = FALSE)

