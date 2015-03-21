## Single function written in this file is used to read the training and test data sets.
## All the data sets are merged as a single dataset and variable names are renamed to follow the
## syntax. The data set created at the end is a tidy data set and it follows the tidy data principles.


run_analysis <- function() {
    
    ## Load library
    library(reshape2)

    ## Read all the original data sets
    features.data <- read.table("UCI HAR Dataset/features.txt") 
    activity.data <- read.table("UCI HAR Dataset/activity_labels.txt")
    
    
    ## Read training datasets
    x.train.data <- read.table("UCI HAR Dataset/train/X_train.txt") 
    y.train.data <- read.table("UCI HAR Dataset/train/Y_train.txt")
    subject.train.data <- read.table("UCI HAR Dataset/train/Subject_train.txt")
    
    
    ## Read test data sets
    x.test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
    y.test.data <- read.table("UCI HAR Dataset/test/Y_test.txt")
    subject.test.data <- read.table("UCI HAR Dataset/test/Subject_test.txt")
    
    
    ## Merge both training and test data sets
    x.merged.data <- rbind(x.train.data, x.test.data)
    y.merged.data <- rbind(y.train.data, y.test.data)
    subject.merged.data <- rbind(subject.train.data, subject.test.data)
    
    
    ## Change the V.. colnames to actual feature names
    colnames(x.merged.data) <- features.data$V2
    
    ## Retrieve only the mean & std columns. Only those with bracket are selected.
    mean.vector <- grep("mean()", features.data$V2, fixed=TRUE)
    length(mean.vector) ##33
    
    std.vector <- grep("std()", features.data$V2, fixed=TRUE)
    length(std.vector) ##33
    
    mean.std.vector <- c(mean.vector, std.vector)
    
    x.meanstd.final <- x.merged.data[,mean.std.vector]
    dim(x.meanstd.final) ##10299, 66
    
    ## Change the acitivity id to names
    name.vector <- vector(mode="character", length=0)
    for(i in y.merged.data$V1) {
     if(i %in% activity.data$V1 ) {
         activity.index <- which(activity.data$V1==i)
         ##activity.data$V2[activity.index]) is a factor convert to character
         name.vector <- append(name.vector, as.character(activity.data$V2[activity.index] ) , after=length(name.vector))
         
     }
    }
    
    ## Add a new name column matching the activity ids
    y.merged.data <- cbind(y.merged.data, V2=name.vector)
    
    ## Combine y(activity), subject and x
    all.merged.data <- cbind(y.merged.data$V2, subject.merged.data, x.meanstd.final)##10299, 68
    colnames(all.merged.data)[1] <- "activity"
    colnames(all.merged.data)[2] <- "subject"
    
    ## Remove parenthesis from column names
    temp.col.names <- colnames(all.merged.data)
    tmp.vector <- vector(mode="character", length=0)
    for(y in 1:68) {
        tmp.vector[y] <- colnames(all.merged.data)[y]
        tmp.vector[y] <- gsub("()","",tmp.vector[y], fixed=TRUE)
        tmp.vector[y] <- gsub("BodyBody","Body",tmp.vector[y], fixed=TRUE)
    }
    ## Make syntatically valid names
    colnames(all.merged.data) <- make.names(tmp.vector, unique=TRUE)
    
    ## Assign activity and subject as id variables and other columns as measure vars 
    melt.data <-melt(all.merged.data, id=c("subject","activity"),measure.vars=c(3:68))
    
    ## Create mean for each variable for each subject and activity
    tidy.data <- dcast(melt.data, subject+activity~variable, mean)
    
    ## Check the dimension of tidy data
    print(dim(tidy.data)) ##180,68    
        
    ## Final step - write the tiday data to a file
    write.table(tidy.data,file="HAM_TidyData.txt",row.names=FALSE)
    
}
 