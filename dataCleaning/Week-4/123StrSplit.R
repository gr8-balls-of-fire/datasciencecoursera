fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, "usc.csv", method="curl" )
VarNames <- names(usc)
SplitVarNames <- strsplit(VarNames, "wgtp")
SplitVarNames[123]