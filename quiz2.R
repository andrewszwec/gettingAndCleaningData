## Quiz 2

# Question 1

## Get GitHub Data for J Leek
library(httr)
library(httpuv)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", "67bce46759fb5d0c8e19", "a18f6083317f7fb9efbe4bdad80daa231d8f7759")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
content(req)

library(jsonlite)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2


## Question 2
## Connect to the interwebs and get some data
library(sqldf)
acs <- read.csv("./data/getdata-data-ss06pid.csv")
names(acs)
sqldf('select pwgtp1, pwgtp2, pwgtp3 from acs where AGEP<50 limit 10')


## Question 4

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])


# 45, 31, 7, 25


## Question 5
mydata <- read.csv("/Users/andrewszwec/Documents/Coursera/dataScienceSpecialisation/rProgramming/getdata-wksst8110.csv", 
           header = TRUE )
head(mydata)

sum(mydata[5])


