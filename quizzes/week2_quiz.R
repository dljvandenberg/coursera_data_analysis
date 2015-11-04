### Getting and Cleaning Data

## Week 2 - question 1

# See example: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
# Registered application 'github' at https://github.com/settings/applications
library(httr)
library(httpuv)
library(jsonlite)
myapp <- oauth_app("github", key = "7b1b902097bfcaa6f94e", secret = "5af9ee69dfe16c1bf4127b2b3430b6e9e2ce51f5")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data <- fromJSON(toJSON(content(req)))
datasharing_info <- data[data$name=="datasharing",]
datasharing_info$created_at



## Week 2 - questions 2 and 3

library(sqldf)

# Download file, read as variable acs and cleanup temporary file
dir <- "~/git/datasciencecoursera" 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- "tmpfile.csv"
setwd(dir)
download.file(url, file, method="curl")
acs <- read.csv(file)
unlink(file)

# Select relevant data
selected1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
selected2 <- sqldf("select distinct AGEP from acs")


## Week 2 - question 4

# Read html file
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
connection <- url(url)
data <- readLines(connection, n = 100L)
close(connection)
# Count number of characters in the 10th, 20th, 30th and 100th lines
nchar(data[[10]])
nchar(data[[20]])
nchar(data[[30]])
nchar(data[[100]])


## Week 2 - question 5

# Read html file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
connection <- url(url)
data <- read.fwf(connection, width=c(10,9,4,9,4,9,4,9,4),header=FALSE, skip=4)
close(connection)
# Determine sum of the numbers in the fourth of the nine columns
data[,4] <- as.numeric(data[,4])
sum(data[,4])
#TODO