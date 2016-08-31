fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, "gdp.csv", method="curl")
gdp <- data.table(read.csv("gdp.csv", header = TRUE, skip=4))
gdp <-select(gdp, 5)
gdp <- mutate(X.4 = gsub(",","",X.4))
gdp<- gdp[1:190,]
gdp <- as.vector(gdp)
gdp <- as.numeric(gdp)
mean(gdp)