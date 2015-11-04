# Creates plot1.png aimed at answering the following question:
# ----
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#    Using the base plotting system, make a plot showing the total PM2.5 emission
#    from all sources for each of the years 1999, 2002, 2005, and 2008.
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")

# Read data set
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Aggregate yearly totals
NEI.total.emmissions.by.year <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
names(NEI.total.emmissions.by.year) <- c("year", "total_emissions")

# Plot data, add linear fit and write to file
png(filename="plot1.png")
plot(NEI.total.emmissions.by.year$year, NEI.total.emmissions.by.year$total_emissions, xlab="year", ylab="PM2.5 emissions (tons)", main="Yearly PM2.5 emissions USA (measured total)")
abline(lm(NEI.total.emmissions.by.year$total_emissions ~ NEI.total.emmissions.by.year$year),col="red",lwd=1.5)
dev.off()

