library(ggplot2)
# Unzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Load the data into R
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
mergedData <- merge(scc, nei, by = "SCC")
# Let's susbset the data of Baltimore (fips = 24510)
baltimore <- subset(mergedData, fips == 24510)
motorData <- baltimore[baltimore$type == "ON-ROAD", ]
aggData <- aggregate(Emissions ~ year, motorData, sum)
# PNG export settings
png(filename = "./plots/plot5.png", width = 600,
    height = 600, units = "px")
# A quick plot for this one
qplot(year, Emissions, data = aggData, geom = "line") +
    # Also we want some points in each observation    
    geom_point() +
    # The y label    
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    # And finally the plot's title
    ggtitle("Motor vehicle related emissions in Baltimore city from 1999 to 2008")
dev.off()