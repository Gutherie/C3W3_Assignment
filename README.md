# C3W3_Assignment

This project includes a single file that includes an R language function designed to process data from a movement study.
The datafiles used for processing are located here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

To test run this program please ensure you have extracted the files in your working directory or make the extraction location your working directory before you execute the program.

##Observations
The output file will provide observations of the data sorted by participant and activity. Each participant may have many entries for a given activity such as "WALKING".  The observation is the average all the entries for a given user for each activity. Each participant will have up to 6 observations related to the six distinct activities provided by the study (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 

##Program Function
* To generate a tidey data-set
* Aggregate test and train data
* Correctly label variables using provided activity labels 
* Subset data by average and standard deviation columns
* Summarizes the activity measurements by averaging the collected averages and standard deviation by activity type and person
* Create row names based on a string catenation of person id and activity type
* Modify column name to indicate Summary
* Generate an export file 

##Program file
* A single file named run_analysis.R Written in R

##Library Requirements
* dplyr

## Instructions
* Download run_analysis.R and store in your working directory
* Download and extract http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones into your working directory
* Check that dplyr is installed
* source run_analysis.R into your R environment 
* call runAnalysis()
* Observe output stored in working directory in a file named exportData.txt
 
Information about variables is stored in DataDictionary.md



