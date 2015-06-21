## Assignment 1 for Data Science (C3W3)
## from the instructions:
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##
##  5. From the data set in step 4, creates a second, independent tidy data set with 
##     the average of each variable for each activity and each subject.

runAnalysis <- function() {
    # load required libraries
    library(dplyr)
    
    # get the test data
    Xtrain <- read.table("./train/X_train.txt")
    Xtest <- read.table("./test/X_test.txt")
    
    # get the column names
    features <- read.table("features.txt")
    
    #combin the data and name the columns
    combined <- rbind(Xtest,Xtrain)
    names(combined) <- features$V2
    
    # find mean columns
    meanCol <- grep("mean", names(combined))
    
    # find std columns
    stdCol <- grep("std", names(combined))
    
    # Extract measurements for std and mean to new data frame
    extracted <- combined[,c(meanCol,stdCol)]
    
    #get activity Labels and activty ID arrays and subject labels
    actLabels <- read.table("activity_labels.txt",stringsAsFactors = FALSE)
    testAct <- read.table("./test/y_test.txt")
    trainAct <- read.table("./train/y_train.txt")
    actCombined <- c(testAct$V1,trainAct$V1)
    
    testSubjects <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE)
    trainSubjects <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE)
    subjectsCombined <- data.frame(subjects = c(testSubjects$V1, trainSubjects$V1))
    
    # create human friendly label array for activity
    friendly <- data.frame(nums=actCombined)
    friendly$eng=""
    for (i in 1:nrow(friendly)){
        friendly[i,2] <- actLabels[friendly[i,1],2]
    }
    
    # add the descriptive label and numeric value
    finalData <- cbind(friendly, extracted)
    finalData <- cbind(subjectsCombined, finalData)
    
    ##prepare tidey data extract with averaging over activities and participants
    # lets sort the data so we can work with it better, first by subject then by activity
    finalData <- arrange(finalData,subjects, nums)
    byPerson <- split(finalData2,finalData2$subjects)
    
    # break down groups by person then activity. Summarize each activity as a mean calculation
    counter <- 1
    newRowLabels <- c()
    for (i in 1:length(byPerson)){
        byActivity <- split(byPerson[[i]],byPerson[[1]]$nums)
        for (j in 1:length(byActivity)){
            actMean <- c()
            for (k in 4:ncol(byActivity[[j]])){
                aMean <- mean(byActivity[[j]][,k])
                actMean <- c(actMean,aMean)
            }
            newRowLabels <- c(newRowLabels,paste("Subject",byPerson[[i]][1,1],":",byActivity[[j]][1,3]))
            calculations[counter,] <- actMean
            counter <- counter + 1
        }
        
    }
    ## create new data.frame with summarized data
    oldVarNames <- names(finalData)
    newVarNames <- c()
    for (i in 4:length(oldVarNames)){
        newVarNames <- c(newVarNames,paste("SUMMARY",oldVarNames[i],sep="_", collapse = ""))
    }
    exportData <- data.frame(newRowLabels)
    #exportData <- data.frame(calculations[1:(counter-1),1])
    for (i in 2:ncol(calculations)){
        exportData[,i] <- calculations[1:(counter-1),i]
    }
    #rename columns
    names(exportData) <- newVarNames
    
    # Send the result to output
    write.table(exportData,"exportData.txt", row.names = FALSE)
}
