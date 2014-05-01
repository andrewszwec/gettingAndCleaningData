### Getting and Cleaning data Video :: week 4

## Video 1
toupper()
tolower()
strplit()

remove all '.'

x <- "Hello"

firstElement <- function(x) {
      sapply(splitNames, firstElement)
}
firstElement(x)


gsub()

grep() # returns number at which thing is found
grepl() # returns true and false

grep( , value=TRUE) # returns the cell where the word appears

library(stringr)
nchar() # how many characters

substr()
paste()
paste0() # pastes with no space in between
str_trim() # like trim

# always use all lowercase for column names

## Video 2
regular expressions

^ = anchor to start ine
$ = anchor to end of line
[^a] = not 'a'


## Video 3

'.' = matches anything
| = OR
[a-z]? = '?' means optional

# Repetition
* = none or more
+ = 1 or more
# interval qualifies (Range)
{1,5} = min, max 
{1,}, {,5}, {1}

# REGEX to find duplicate words
 +([a-zA-Z]+) +\1 + = '\1' refers to group 1, so we are looking for some word, followed by itself 
                        (not at the start of a line)

^s(.*)s$ = '*' is greedy
^s(.*?)s$ = '?' makes it less greedy

## Video 4
# Working with dates
d1 = date()       # Character type
d2 = Sys.Date()   # Date type

format(d2, "a% %b %d")
%d = day as number
%a = abbreviated weekday
%A = unabbreviated weekday
%m = month (00-12)
%b = abbreviated month 
%B = unabbreviated month 
%y = 2 digit year 
%Y = four digit year

x= c("1jan1960", "2jan1960"); z= as.Date(x, "%d%b%Y")
z

weekdays(d2)
months(d2)
julian(d2)  ## Days since epoch

library(lubridate)
ymd("20140108")

mdy("08/04/2013")
dmy("01-02-2013")

ymd_hms("2011-08-03 10:15:03")

ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
?Sys.timezone

x = dmy(c("1jan2013"))
wday(x[1])
wday(x[1], label=TRUE)
POSIXct or POSIXlt


## Video 5
# Data sources
http://data.gov.au
data.gov/opendatasites

Gapminder.org
twitteR package























