## Quiz week 3


data <- read.csv("ss06hid.csv")
summary(data)

# Question 1
# Households, acres>10, agrprod > $10,000, 

SERIALNO
ACR == 3
AGS == 6

agricultureLogical <- data$ACR==3 & data$AGS == 6 
which(agricultureLogical)

# Question 2
library(jpeg)
img <- readJPEG("getdata-jeff.jpg", native=TRUE)

quantile(img, probs=c(0.3, 0.8), rm.na=TRUE)


# Question 3
# Take 2 datasets, join on country shortcode
# how many id's match?
# sort in desc order by GDP ranking, what is 13th country?

x <- read.csv("GDP.csv", colClasses = c("character", "numeric","character","character"))
y <- read.csv("EDSTATS_Country.csv")

length(intersect(x$Shortcode, y$CountryCode))

m <- merge(x,y, by.x="Shortcode", by.y="CountryCode", all=TRUE)

o <- m[order(m$Ranking, na.last = TRUE, decreasing = TRUE), ]
o$num <- seq(1,nrow(o),1)
subset(o, select=c("Ranking", "Economy", "num"))

o$GDP <- as.numeric(gsub(",","",o$GDP))

# Question 4
library(reshape2)
oMelt <- melt(o, id=c("num","Ranking","Economy", "IncomeGroup"), measure.vars=c("Ranking") )
dcast(oMelt, IncomeGroup ~ variable, mean, na.rm=TRUE)


write.csv(o, "a.csv")





# Question 5

library(Hmisc)
m$rankGroup = cut2(o$Ranking, g=5 )
table(m$rankGroup, m$IncomeGroup)









