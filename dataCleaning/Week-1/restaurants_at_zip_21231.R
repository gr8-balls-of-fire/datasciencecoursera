setwd("/home/gr8-balls-of-fire/datasciencecoursera/dataCleaning")
dlfile<-xmlTreeParse("getdata_Fdata_Frestaurants.xml")
fileTop <- rootNode(dlFile)
fileTop[[1]][[1]][["zipcode"]] ## gives the entre element <zipcode>the actual number </zipode>
fileNext <- fileTop[[1]]
fileNext[[1]][["zipcode"]]
## not required to do this --- xmlSApply(fileNext, function(x) xmlSApply(x,xmlValue)) ## get a matrix of addresses each adress is a list
nodes <- getNodeSet(fileNext,"//row/zipcode")
dfNodeset <- as.matrix(nodes) ##convert to matrix
zipcodes <- lapply(nodes, function(x) xmlSApply(x, xmlValue))
zips <- sapply(zipcodes,function(x) x[[1]][[1]])
i=0
for (number in zips) {
  if (number == "21231") {
    i = i+1
  }
}
print i