# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


getDirectory <- function(){
  print("**************************************************************************")
  print("In what directory is the folder \'...\\UCI HAR Dataset\\...\' stored?") 
  print("(Cut and paste dir here, it will be something like...") 
  print("\'C:\\Users\\username\\Documents\\gettingAndCleaningData\\')")
  print("Hit enter to use default. ")
  print("**************************************************************************")
  x <- readline("-> ")   
  x <- as.character(unlist(strsplit(x, ",")))
  return(x)
}


#######################################################################
# Main
#
#
#######################################################################
run_analysis <- function(){
  
  # Default Relative Directory
  dataDirectory  <- '../UCI\ HAR\ Dataset/..'
  if(  length(a<-getDirectory())>0  ){
    dataDirectory <- a  
  }
  print(paste("Directory: ", dataDirectory))
  
  
  training <- fread('')
  
  
}


run_analysis()






