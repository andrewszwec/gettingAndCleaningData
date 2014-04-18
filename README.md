# README 
## Coursera Getting and Cleaning Data: Project

### Introduction
This is a README for the Coursera Getting and Cleaning Data Project.

### Purpose
This README will describe how this script works and any special details about how to operate the script.

### Program Description:
This program Merges the training and the test sets to create one data set. It re-labels 
all the columns to match the corresponding features and activities.

It extracts only the measurements on the mean and standard deviation for each measurement 
and then exports a tidy dataset to a file called "tidyData.csv"

A second, independent tidy data set with the average of each variable for each activity 
and each subject is created an exported as "averages.csv". 

### Script Prerequisites
This script requires the R library "sqldf" to be installed to properly function.

### How to Operate Script
To run this script SELECT-ALL and push Command+Enter (Mac) or Control+Enter (Windows). 

### Outputs
Two output files are created by this script in your working directory:  
*    tidyData.csv  
*    averages.csv