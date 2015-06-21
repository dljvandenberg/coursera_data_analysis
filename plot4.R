# Creates plot4.png aimed at answering the following question:
# ----
# 4. Across the United States, how have emissions from coal combustion-related sources
#    changed from 1999–2008?
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")
library(ggplot2)

# Read data sets
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Merge data sets
NEI.SCC <- merge(NEI, SCC)
# Select coal combustion-related sources
NEI.SCC.coal.combustion <- subset(NEI.SCC, subset = EI.Sector %in% c("Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal", "Fuel Comb - Comm/Institutional - Coal"))

# Determine emissions by year for coal combustion-related sources
NEI.SCC.coal.combustion.emissions.by.year <- aggregate(NEI.SCC.coal.combustion$Emissions, by=list(NEI.SCC.coal.combustion$year), FUN=sum)
names(NEI.SCC.coal.combustion.emissions.by.year) <- c("year", "total_emissions")

# Plot data and write to file
png(filename="plot4.png", width=480, height=480)
print(qplot(data=NEI.SCC.coal.combustion.emissions.by.year, x=year, y=total_emissions, ylab="PM2.5 emissions (tons)", main="PM2.5 emissions for coal combustion-related sources") + geom_smooth(method="lm"))
dev.off()