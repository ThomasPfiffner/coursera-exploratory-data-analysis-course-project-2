# plot 5: emissions from motor vehicle sources in Baltimore

library(dplyr)
# read and prepare data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter the data by the "on-raod" type (aequivalent to motor vehicle),
# for Baltimore City, grouped by year, sum by emission
yearly.data <- group_by(subset(NEI, fips == "24510", type = "ON-ROAD"), year)
yearly.total <- summarise(yearly.data, total.pm25 = sum(Emissions))

# create plot and save as png file
png('plot5.png')
barplot(height = yearly.total$total.pm25, names.arg = yearly.total$year, 
     xlab = "year", ylab = expression("total pm"[2.5]*" emission"),
     main = "Emissions from Motor Vehicle in Baltimore",)
dev.off()

