## load data.table package
library(data.table)
library(dplyr)
## Set Working directory
setwd("/home/gr8-balls-of-fire/datasciencecoursera/Exploratory Data Analysis/Week 1/Project - 1")
## set the URL string
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## download the file using CURL method
download.file(fileURL,destfile = "household_power_consumption.zip", method = "curl")
## unzip the downloaded file
unzip("household_power_consumption.zip")
## while the filename extension is 'txt' is is a csv file with ";" as separatot
## load the file into a data table using read.csv function 
hpc <- data.table(read.csv("household_power_consumption.txt",sep = ";", na.strings = c("?","","NA"), header = TRUE))
## reduce the data set to 1st & 2nd Feb 2007
hpc <- hpc[hpc$Date=="1/2/2007"|hpc$Date=="2/2/2007",]

##hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")