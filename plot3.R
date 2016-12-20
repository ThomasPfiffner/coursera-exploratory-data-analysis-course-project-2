# plot 3: total emission for Baltimore per year and type of emission

library(dplyr)
library(ggplot2)

# read and prepare data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# group the data for Baltimore City by year and emission type,  summ by Emissions
yearly.data <- group_by(subset(NEI, fips == "24510"), year,type)
yearly.total <- summarise(yearly.data, total.pm25 = sum(Emissions))

# create ggplot and save as png file
png('plot3.png')
qplot(year, total.pm25, data = yearly.total, facets = type ~., geom="line") + 
  facet_grid(type ~.,scales="free") +
  ylab(expression("total pm"[25]*" emission")) +
  ggtitle("Total Emission in Baltimore City (fips 24510) ")
dev.off()