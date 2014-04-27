## Getting and cleaning data :: Week 3 Videos 

dataset(iris)

## Video 1
# Subsetting
# Multiple filters
X[ (X$var1 <= 3 & X$var2 > 11), ] # NA.s stuff this upp
# Better
X[which(X$var2 > 8), ]

sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var1, na.last=TRUE)

# Order a df
x[order(X$var1, X$var3), ]

library(pylr)
# sorts on var1
arrange(X, var1)

arrange(X, desc(var1))

## Video 2
head ()
tail()
summary()
quantile(restData$councilDistrict, na.rm=TRUE)
0% 25% 50% 75% 100%
1   2   9   11  14

# useNa = displays NAs
table( restData$zipCode, useNa="ifany")

# Check for missing values
sum(is.na(iris$Sepal.Length))

any(is.na(iris$Sepal.Length))

all(iris$Sepal.Length>0)

colSums(is.na(iris))

all(colSums(is.na(iris)))

# Find the number of records with a certain value e.g. Species
table(iris$Species %in% c("virginica", "setosa"))

# Find records with Species == "virginica" or "setosa"
iris[iris$Species %in% c("virginica", "setosa"), ]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

## Crosstabs
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

## Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ ., data=warpbreaks)

# now compact the data from above!
ftable(xt)

# Size of data
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")


## Video 3

# creating sequences
s1 <- seq(1,10,by=2) ; s1
s2 <- seq(1,10, length=3); s2
# Matches same length as x with a sequence
x <- c(1,3,8,25,100) ; seq(along=x)

# Subsetting
iris$mySpecies = iris$Species %in% c("virginica", "setosa")
table(iris$mySpecies)

iris$SepalWrong = ifelse(iris$Sepal.Length < 1, TRUE, FALSE)
table(iris$SepalWrong, iris$Sepal.Length)


## Change Continuous variable into a categorical variable
# Bucket it by quantiles
iris$Groups = cut(iris$Sepal.Length, breaks=quantile(iris$Sepal.Length))
table(iris$Groups)

# View buckets and counts
table(iris$Groups, iris$Sepal.Length)

# Easier cutting
library(Hmisc)
iris$Groups = cut2(iris$Sepal.Length, g=4 )
table(iris$Groups)


iris$zcf <- factor(iris$Petal.Width)
iris$zcf
class(iris$zcf)

# Give variables a ref id rather than a name, this can be used in models etc... Its called a FACTOR
yesno <- sample(c("yes","no"), size=10, replace=TRUE)
# You still need to do a unique() to find what is in your col
yesnofac = factor(yesno, levels=c("yes", "no"))
as.numeric(yesnofac)


## Mutate function in plyr
# Mutate creates a new column based off a function and adds it to you dataset
library(plyr)
iris2 = mutate(iris,sepalGroups= cut2(Sepal.Length, g=4 )) ; head(iris2)

# Comon transformations
abs
sqrt
ceiling
round
signif()
log()
exp()


### Video 4

## Reshaping data
# This is really cool and useful (Like a PIVOT)
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
# Which are the natural keys, call them id's. Which are the measures you are interested in. 
# Put them in one column
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars=c("mpg","hp") )
head(carMelt, n=3)


# Casting DFs

cylData <- dcast(carMelt, cyl ~ variable)
cylData

# Slice and dice data for means!
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

head(InsectSprays)
# Sum the counts for each different type of insect spray
tapply(InsectSprays$count, InsectSprays$spray, sum)

## SPLIT APPLY COMBINE
# SPLIT
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

# APPLY
sprCount  = lapply(spIns, sum)
sprCount

# COMBINE
unlist(sprCount)

# or....
sapply(spIns, sum)

# or using plyr....
ddply(InsectSprays, .(spray), summarize, sum=sum(count))

# find an aggregation of some data and append it to the table at an atomic level
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)

# acast -> turns it into an array


### Video 5

# Merging data
# All = TRUE does a full outer join
merge(x,y, by.x="id", by.y="id", all=TRUE)

interset()

# Other Packages
join in plyr

# Joining multiple data frames

df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
df3 <- data.frame(id=sample(1:10), z=rnorm(10))

dfList = list(df1,df2,df3)
join_all(dfList)






