### Getting and cleaning data Quiz :: Week 4
## Question 1

data <- read.csv("ss06hid.csv")
?strsplit
split <- sapply(names(data), strsplit, split="wgtp") 
split[123]


## Question 2
data <- read.csv("GDP.csv", header=FALSE, skip=5)
dim(data)
head(data)
tail(data)
data <- data[1:190,c(1,2,4,5)]
dim(data)
names(data) <- c("code","rank","desc","gdp")
head(data)
data$gdp2 <- as.numeric(gsub(",", "", data$gdp ))
mean(data$gdp2)


## Question 3
?grep
data$desc[99]
data$desc[186]
d <- gsub("\xf4","o",data$desc)
d <- gsub("\xe3o|\xe9", "", d)
grep("^United", d)


## Question 4

edu <- read.csv("EDSTATS_Country.csv")
head(edu)
tail(edu)
m <- merge(data, edu, by.x="code", by.y="CountryCode", all=TRUE)
names(m)

rowWithEOF <- m[grep("Fiscal year end", m$Special.Notes), ]
eofJune <- m[grep("[jJ]une|[jJ]un", rowWithEOF$Special.Notes),  ]
dim(eofJune)

## Question 5
install.packages("quantmod")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(amzn)
numSampleIn2012 <- length(sampleTimes[which(year(sampleTimes)==2012) ])
samplesIn2012 <- sampleTimes[which(year(sampleTimes)==2012) ]
numSmplsMon2012 <- length(samplesIn2012[weekdays(as.Date(samplesIn2012), abbreviate = TRUE)=="Mon"])

