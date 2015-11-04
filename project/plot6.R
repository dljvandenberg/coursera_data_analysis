# Creates plot6.png aimed at answering the following question:
# ----
# 6. Compare emissions from motor vehicle sources in Baltimore City with
#    emissions from motor vehicle sources in Los Angeles County, California
#    (fips == "06037").  Which city has seen greater changes over time
#    in motor vehicle emissions?
# ---

# Preparations
setwd("~/git/coursera_exdata_project_emissions")
library(ggplot2)
library(dplyr)

# Read data sets
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Merge data sets
NEI.SCC <- merge(NEI, SCC)

# Select data for Baltimore and Los Angeles motor vehicle sources
NEI.SCC.Baltimore.LosAngeles.motor.vehicles <- subset(NEI.SCC, (fips == "24510" | fips == "06037") & EI.Sector %in% c("Mobile - On-Road Gasoline Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Diesel Heavy Duty Vehicles"))

# Aggregate emissions by year
NEI.SCC.Baltimore.LosAngeles.motor.vehicles.emissions.by.year <- aggregate(NEI.SCC.Baltimore.LosAngeles.motor.vehicles$Emissions, by=list(NEI.SCC.Baltimore.LosAngeles.motor.vehicles$year, NEI.SCC.Baltimore.LosAngeles.motor.vehicles$fips), FUN=sum)
names(NEI.SCC.Baltimore.LosAngeles.motor.vehicles.emissions.by.year) <- c("year", "fips", "total_emissions")

# Add column with county names
NEI.SCC.Baltimore.LosAngeles.motor.vehicles.emissions.by.year <- mutate(NEI.SCC.Baltimore.LosAngeles.motor.vehicles.emissions.by.year, County = ifelse(fips=="24510", "Baltimore City", ifelse(fips=="06037", "Los Angeles County", NA)))

# Plot data and write to file
png(filename="plot6.png", width=640, height=480)
print(qplot(data=NEI.SCC.Baltimore.LosAngeles.motor.vehicles.emissions.by.year, x=year, y=total_emissions, ylab="PM2.5 emissions (tons)", main="PM2.5 emissions from motor vehicle sources", color=County, log="y") + geom_smooth(method="lm"))
dev.off()