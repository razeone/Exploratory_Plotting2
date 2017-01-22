library(ggplot2)
# Unzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Load the data into R
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
# Let's merge the data
mergedData <- merge(scc, nei, by = "SCC")
# Now let's subset data of LA and Baltimore
baltAndLa <- mergedData[mergedData$fips == "24510"|mergedData$fips == "06037", ]
aggData <- aggregate(Emissions ~ year + fips, baltAndLa, sum)
# PNG export settings
png(filename = "./plots/plot6.png", width = 600,
    height = 600, units = "px")
ggplot(aggData, aes(year, Emissions, color = fips)) +
    geom_line() +
    # Also we want some points in each observation    
    geom_point() +
    # The y label    
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    # And finally the plot's title
    ggtitle("Motor vehicle related emissions Baltimore (24510) and LA (06037) from 1999 to 2008")
dev.off()