# Creates plot3.png aimed at answering the following question:
# ----
# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#    which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#    Which have seen increases in emissions from 1999–2008?
#    Use the ggplot2 plotting system to make a plot to answer this question.
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")
library(ggplot2)

# Read data set
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Aggregate yearly totals for Baltimore City, Maryland (fips == "24510")
NEI.Baltimore <- subset(NEI, fips == "24510")
NEI.Baltimore.emmissions.by.type.year <- aggregate(NEI.Baltimore$Emissions, by=list(NEI.Baltimore$type, NEI.Baltimore$year), FUN=sum)
names(NEI.Baltimore.emmissions.by.type.year) <- c("type", "year", "total_emissions")

# Plot data and write to file
png(filename="plot3.png", width=1024, height=480)
print(qplot(data=NEI.Baltimore.emmissions.by.type.year, x=year, y=total_emissions, facets=. ~ type, ylab="PM2.5 emissions (tons)", main="Yearly PM2.5 emissions by type in Baltimore, MD") + geom_smooth(method="lm"))
dev.off()