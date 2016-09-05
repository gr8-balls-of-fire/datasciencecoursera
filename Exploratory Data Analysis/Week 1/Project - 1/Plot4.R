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
## create the plot space
par(mfrow = c(2,2))
## plot the required graph
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(hpc, {
  plot(Global_active_power~dateTime, type="l", cex.lab = 0.75, ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~dateTime, type="l", cex.lab = 0.75,ylab="Voltage (volt)", xlab="")
  
  plot(Sub_metering_1~dateTime, type="l", cex.lab = 0.75, ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, cex = 0.7 ,lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  plot(Global_reactive_power~dateTime, type="l", cex.lab = 0.75, ylab="Global_Rective_Power",xlab="datetime")
})
## close the png device so that the file is written
dev.copy(png,file="plot4.png", width = 480, height = 480)
dev.off()