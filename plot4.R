library(ggplot2)
# Unzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Load the data into R
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
# We're going to merge the two datasets for this plot
mergedData <- merge(nei, scc, by = "SCC")
# Now we need to get the matches of "coal"
colMatch <- grep("coal", mergedData$Short.Name, ignore.case = TRUE)
# With those matches, let's get the actual data
coalData <- mergedData[colMatch, ]
# Wee need to aggregate this data too
aggData <- aggregate(Emissions ~ year, coalData, sum)
# PNG export settings
png(filename = "./plots/plot4.png", width = 600,
    height = 600, units = "px")
# A quick plot for this one
qplot(year, Emissions, data = aggData, geom = "line") +
    # Also we want some points in each observation    
    geom_point() +
    # The y label    
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    # And finally the plot's title
    ggtitle("Coal combustion-related emissions across the US from 1999 to 2008")
dev.off()