## Getting and Cleaning Data :: Week 1 Videos


##  Creating a dir if it doesnt exist
if(!file.exists("data")){
  dir.create("data")
  
}

## Downloading files (csv)
url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(url, destfile="./data/cameras.csv", method="curl") ## Curl for Mac
list.files("./data")

dateDownloaded<-date()
dateDownloaded

cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData)

## Downloading files (xlsx)
url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(url, destfile="./data/cameras.xlsx", method="curl") ## Curl for Mac
list.files("./data")

dateDownloaded<-date()
dateDownloaded

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1,header=TRUE)
head(cameraData)


library(xlsx)
colIndex<-2:3
rowIndex<-1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset


read.xlsx2 #faster
XLconnect # better to manipulate XL files
XLConnect Vignette


## Parsing XML

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)

names(rootNode)

rootNode[[1]]

rootNode[[1]][[2]]

xmlSApply(rootNode, xmlValue)


# XPath
# //node (double slash means node at any level, single slash means node at top level)
xpathSApply(rootNode,"//name",xmlValue)

xpathSApply(rootNode,"//price",xmlValue)

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
## means - go and get the HTML from the website. Use Interanl True means get all components
doc<-htmlTreeParse(fileUrl, useInternal=TRUE)
# //li -> list items
scores<-xpathSApply(doc,"//li[@class='score']",xmlValue)
teams<-xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams


## JSON
library(jsonlite)
jsonData<-fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
# Drilling Down
names(jsonData$owner)
jsonData$owner$login

# Convert df to JSON
myjson<-toJSON(iris, pretty=TRUE)
cat(myjson)
# convert back
iris2<-fromJSON(myjson)
head(iris2)

# data.table (heaps faster than data.frame)
library(data.table)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))

tables()

DT[2,]

DT[c(2,3)]
DT[,c(2,3)]

{
  x=1
  y=1
}
k={print(10);5}
print(k)


## IMPORTANT - you can pass it functions and it just does them! see below
DT[,list(mean(x),sum(z))]

DT[,table(y)]


# Add a new column called w that =z^2 AMAZING (:= adds new col)
DT[, w:=z^2]

## Multi Step operation
DT[,m:= {tmp<-(x+z); log2(tmp+5)}]
DT

## Make a binary variable where x > 0 = TRUE else FALSE!
DT[,a:=x>0]

## Take the mean and group recors by 'a'
## Creates new variable that is dependant on 'a' and is an aggregate of the dataset
DT[, b:= mean(x+w), by=a]

# Special Variable for Count
set.seed(123);
DT <-data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

## Use Keys
DT<- data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
setkey(DT,x)
# Subset df on Key='a'
DT['a']
DT

## df joins using Keys
DT1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x); setkey(DT2,x)
merge(DT1, DT2)

## Fast Reading tables use...
fread(file)









