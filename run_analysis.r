#Assume files are located in working directory to start
setwd("C:/Users/nicholas.anderson/Documents/R/GettingAndCleaningData/Project")

#Load necessary packages
library(sqldf)
library(dplyr)

#File creation (if needed)
createFiles<-TRUE #Toggles whether or not file creation step is executed (useful for multiple runs)
if(createFiles){
fileList<-c("subject_test","subject_train","X_test","X_train","Y_test","Y_train","activity_labels","features") #Edit list of files to be imported here
for(file in fileList){
  fileName<-paste(file,".txt",sep="")
  assign(file,read.table(fileName))
}
}

#Combine test and training data
combinedData<-rbind(X_test,X_train)
Y_both<-rbind(Y_test,Y_train)
subject_both<-rbind(subject_test,subject_train)

#Convert list of numerical indicators for activity into descriptive activities
Y_both<-sqldf("select a.V2 from Y_both y left outer join activity_labels a on y.V1 = a. V1")

#Set column names
colnames(Y_both)<-"Activity"
colnames(subject_both)<-"Subject"
colnames(combinedData)<-features[,"V2"]

#Find column names that contain 'mean' or 'std'
columnVector<-sqldf("select V1 from features where V2 like '%mean%' or V2 like '%std%'")

#Eliminate all columns not included in 'columnVector'
combinedData<-combinedData[,unlist(columnVector)]

#Add activity and subjects to "X" data
combinedData<-cbind(Y_both,combinedData)
combinedData<-cbind(subject_both,combinedData)

#Group data by subject and activity and summarize each column using mean
groupedData<-group_by(combinedData,Activity,Subject)
summary<-summarise_each(groupedData,funs(mean))
write.table(summary,"summaryMeans.txt",row.name=FALSE)
