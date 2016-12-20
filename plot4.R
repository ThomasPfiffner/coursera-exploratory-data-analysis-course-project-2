# plot 4: coal combustion

library(dplyr)
# read and prepare data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# find coal combustion in the SCC dataframe
is.combustion.coal <- grepl("Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]
# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]
# group by year and sum emissions
yearly.data <- group_by(emissions, year)
yearly.total <- summarise(yearly.data, total.pm25 = sum(Emissions))

# create plot and save as png file
png('plot4.png')
barplot(height = yearly.total$total.pm25, names.arg = yearly.total$year, 
     main = "Emissions from coal combustion-related sources",
     xlab = "year", ylab = expression("total pm"[2.5]*" emission"))
dev.off()