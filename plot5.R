# Creates plot5.png aimed at answering the following question:
# ----
# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")
library(ggplot2)

# Read data sets
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Merge data sets
NEI.SCC <- merge(NEI, SCC)

# Select data for Baltimore motor vehicle sources
NEI.SCC.Baltimore.motor.vehicles <- subset(NEI.SCC, fips == "24510" & EI.Sector %in% c("Mobile - On-Road Gasoline Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Diesel Heavy Duty Vehicles"))

# Aggregate emissions by year
NEI.SCC.Baltimore.motor.vehicles.emissions.by.year <- aggregate(NEI.SCC.Baltimore.motor.vehicles$Emissions, by=list(NEI.SCC.Baltimore.motor.vehicles$year), FUN=sum)
names(NEI.SCC.Baltimore.motor.vehicles.emissions.by.year) <- c("year", "total_emissions")

# Plot data and write to file
png(filename="plot5.png", width=480, height=480)
print(qplot(data=NEI.SCC.Baltimore.motor.vehicles.emissions.by.year, x=year, y=total_emissions, ylab="PM2.5 emissions (tons)", main="PM2.5 emissions from motor vehicle sources in Baltimore, MD") + geom_smooth(method="lm"))
dev.off()