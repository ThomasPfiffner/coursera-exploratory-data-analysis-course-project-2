# plot 2: total emission for Baltimore  per year

library(dplyr)
# read and prepare data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# group the data for Baltimore City by year and summarize by the Emissions
yearly.data <- group_by(subset(NEI, fips == "24510"), year)
yearly.total <- summarise(yearly.data, total.pm25 = sum(Emissions))

# create png file
png('plot2.png')
barplot(height = yearly.total$total.pm25, names.arg = yearly.total$year, 
        xlab = "year", ylab = expression("Total pm"[25]*" emission"), 
        main = expression("Total pm"[25]*" emission per year in Baltimore City"))
dev.off()