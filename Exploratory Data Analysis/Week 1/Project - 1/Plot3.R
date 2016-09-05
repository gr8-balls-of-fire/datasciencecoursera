## load dplyr package
library(dplyr)
## while the filename extension is 'txt' is is a csv file with ";" as separatot
## load the file into a data table using read.csv function 
hpc <- data.table(read.csv("household_power_consumption.txt",sep = ";", na.strings = c("?","","NA"), header = TRUE))
## reduce the data set to 1st & 2nd Feb 2007
hpc <- hpc[hpc$Date=="1/2/2007"|hpc$Date=="2/2/2007",]
## mutate hpc to get a POSIXct dateTime column added
hpc <- mutate(hpc,dateTime = as.POSIXct(paste(as.Date(hpc$Date,format = "%d/%m/%Y"), hpc$Time)))
## remove the Date and the Time column and get the dateTime column as the irst column of the table
hpc <- select(hpc, dateTime,c(3:9))
## plot the required graph
with(hpc, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
## close the png device so that the file is written
dev.off()