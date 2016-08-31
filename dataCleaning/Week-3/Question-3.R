library(data.table)
fileURL1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
URLdest1 = "getdata_Fdata_FGDP.csv"
fileURL2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
URLdest2 = "getdata_Fdata_FEDSTATS_Country.csv"
download.file(fileURL1, URLdest1, method = 'curl')
download.file(fileURL2, URLdest2, method = 'curl')
gdpData = fread("getdata_Fdata_FGDP.csv", skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "Rank", "Economy", "Total"))
eduData = fread("getdata_Fdata_FEDSTATS_Country.csv")
merged = merge(gdpData, eduData, by = 'CountryCode')
nrow(merged)
arrMerged <- arrange(merged, desc(Rank))
arrMerged[13, "Economy"]