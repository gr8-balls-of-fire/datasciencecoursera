fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileURL, "instructor.jpg", mode = 'wb', method = 'curl')
jpgData = readJPEG("instructor.jpg", native = TRUE)
quantile(jpgData, probs = c(0.3, 0.8))