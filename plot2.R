# Creates plot2.png aimed at answering the following question:
# ----
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#    from 1999 to 2008? Use the base plotting system to make a plot answering this question.
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")

# Read data set
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Aggregate yearly totals for Baltimore City, Maryland (fips == "24510")
NEI.Baltimore <- subset(NEI, fips == "24510")
NEI.Baltimore.emmissions.by.year <- aggregate(NEI.Baltimore$Emissions, by=list(NEI.Baltimore$year), FUN=sum)
names(NEI.Baltimore.emmissions.by.year) <- c("year", "total_emissions")

# Plot data and write to file
png(filename="plot2.png")
plot(NEI.Baltimore.emmissions.by.year$year, NEI.Baltimore.emmissions.by.year$total_emissions, xlab="year", ylab="PM2.5 emissions (tons)", main="Yearly PM2.5 emissions Baltimore, MD")
abline(lm(NEI.Baltimore.emmissions.by.year$total_emissions ~ NEI.Baltimore.emmissions.by.year$year),col="red",lwd=1.5)
dev.off()
