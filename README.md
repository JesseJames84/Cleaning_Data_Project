# Cleaning_Data_Project

Project for the Getting and Cleaning Data Coursera course. The R script in run_analysis.R does the following:

1. Downloads and unzips the dataset 
2. Loads and clean the activity and feature information
3. Loads the training and test data with columns wiht mean or standard deviation variable
4. Loads the activity and subject data, merging them with the appropriate dataset
5. Combines training and test data 
6. Adds descriptive column names to data
7. Converts activities to descriptive categories 
8. Grouping by subject and activity, calculates mean for each measurement variable 
9. Produces tidy data file, tidy_data.txt.
