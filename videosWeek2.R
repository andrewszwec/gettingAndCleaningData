## Getting and Cleaning Data :: Week 2 Videos

# video 1
library(RMySQL)
ucscDb <- dbConnect(MySQL(), user='genome', host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

library(RMySQL)
ucscDb <- dbConnect(MySQL(), user='genome', db="hg19", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "select * from acembly limit 10;"); dbDisconnect(ucscDb);

dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19,"select count(*) from affyU133Plus2")

## Too big
#affyData <- dbReadTable(hg19,"affyU133Plus2")
#head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3 limit 20")
affyMis <- fetch(query, n=10); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10); dbClearResult(query);

dim(affyMisSmall)

dbDisconnect(hg19);

# video 2 :: Reading from HDF5
# This is a binary file format used for storing values. 
# Supposedly very fast and portable compared to sql
Stores large data and structure data
hierarchal data formate

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created

## Create some Hierachical Data Format structure
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

## Write something to h5
A = matrix(1:10, nr=5, nc=2)
h5write(A,"example.h5", "foo/A")
h5ls("example.h5")

## Getting data back
readA = h5read("example.h5", "foo/A")
readA


## Writing and reading in chunks
## Write over the top of what is already in "foo/A", but only overwrite col 1, records 1 to 3
h5write(c(12,13,14),"example.h5","foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")


## Video 3 :: Web scraping

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
head(htmlCode)

## Method 1
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html,"//title", xmlValue)

xpathSApply(html,"//td[@id='col-citedby']", xmlValue)


## Method 2
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)


pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2

names(pg2)

## Handles
## Cookies stay with handles
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")


## Video 4 :: APIs
myapp = oauth_app("twitter",
                  key="zO1Y0pkdhMOlBiRjIdkVSSEDT", secret="wVZLCuGZz25nemUwGgvY656DtdvzGCGTu9zKF0PnyCMxcSCIbK")
sig = sign_oauth1.0(myapp, token ="221691010-dnw0ZUuoTGkKbTF3yj4K33eoEUo8rr8jM7ljdsFd",
                    token_secret = "4NDtzpLQ45UYBY22f1Fgl2tLyB7iF2Kt6197Sr6zpic7I")

homeTL = GET("http://api.twitter.com/1.1/statuses/home_timeline.json", sig)
homeTL

library(jsonlite)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2


## Video 5 :: Reading from other sources

file()
url()
gzfile()
bzfile()
?conectinos
foriegn() package
	reaad.arff (Weka)
	read.dta (strata)
	read.mtp (minitab)
	read.octave 
	read.spss
	read.xport (SAS)
	
RPostgresSQL()
RODBC -> POstgreSQL, MySQL, SQLite()
RMongo()

jpeg()
readbitmap()
png()
EBImage() (bioconductor)

## GIS DATA
rdgal()
rgeos()
raster()

#REding Music
tuneR()
seewave()

















