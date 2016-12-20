# plot 6: emissions from motor vehicle sources in Baltimore and Los Angeles County

library(dplyr)
library(ggplot)
# read and prepare data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter the data by the "on-raod" type (aequivalent to motor vehicle),
# for Baltimore City and Los Angeles County, grouped by year and fips
yearly.data <- group_by(filter(NEI, (fips == "24510" | fips =="06037") & type == "ON-ROAD"), fips, year)
# sum the grouped data by Emissions
yearly.total <- summarise(yearly.data, total.pm25 = sum(Emissions))
# new column with the names of the two relevant fips 
yearly.total$City[yearly.total$fips == "06037"] <- "Los Angeles County"
yearly.total$City[yearly.total$fips == "24510"] <- "Baltimore City"

# create plot and save as png file
png('plot6.png')
qplot(year, total.pm25, data = yearly.total, facets = City ~. , geom="line", main = "Baltimore City/Los Angeles County: Emissions of motor vehicle")+
  facet_grid(City ~., scales = "free") +
  ylab(expression("total pm"[25]*" emission"))
dev.off()