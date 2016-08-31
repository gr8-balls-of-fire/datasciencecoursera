fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile="getdata_2Fdata_Fss06hid.csv", method="curl")
acsComm <- read.csv(getdata_2Fdata_Fss06hid.csv)
acsData <- tbl_df(acsComm)
rm(acsComm)
acsData
agricultureLogical = acsData$ACR == 3 & acsData$AGS == 6
head(which(agricultureLogical), 3)