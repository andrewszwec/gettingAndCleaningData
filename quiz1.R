## Remember to set your working directory
setwd("C:/Users/aszwec/Documents/gettingAndCleaningData")

## Quiz
# https://class.coursera.org/getdata-002/quiz/attempt?quiz_id=25

## Downloading files (csv)
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile="./data/housing.csv", method="curl") ## Curl for Mac
list.files("./data")

dateDownloaded<-date()
dateDownloaded


housingdata <- read.table("./data/housing.csv", sep=",", header=TRUE)
head(housingdata)


nrow(housingdata[,which(housingdata$VAL==24 & housingdata$VAL != NA)])

##################################################################################
## Q1
##################################################################################
dt<-fread("./data/housing.csv")

select count(*) where VAL=24 and SERIALNO is unique

nrow(dt[dt$VAL == 24])

##################################################################################
## Q3
##################################################################################
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, destfile="./data/gas.csv", method="curl") ## Curl for Mac
list.files("./data")

library(xlsx)
dt <- read.xlsx("./data/gas.csv", sheetIndex=1,header=TRUE)
head(dt)

##
dat<-fread("./data/gasxlsx.csv")

sum(dat$Zip*dat$Ext,na.rm=T) 



##################################################################################
## Q4
##################################################################################
library(XML)
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse("C:/Users/aszwec/Documents/gettingAndCleaningData/data/my.xml", useInternal=TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)

zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)


dt <- data.table(zipcodes)

nrow(dt[dt$zipcodes==21231])


##################################################################################
## Q5
##################################################################################

url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, destfile="./data/idaho.csv", method="curl") ## Curl for Mac
list.files("./data")

DT <- fread("./data/idaho.csv")


system.time()

#system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
#system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
#system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15) )
system.time(mean(DT$pwgtp15,by=DT$SEX))














