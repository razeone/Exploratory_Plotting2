# Unzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Load the data into R
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
# Let's susbset the data of Baltimore (fips = 24510)
baltimore <- subset(nei, fips == 24510)
# Let's aggregte the data emissions through each year
aggEmissions <- aggregate(baltimore$Emissions, by = list(baltimore$year),
                          FUN = "sum")
# The PNG settings for exporting the plot
png(filename = "./plots/plot2.png",
    width = 600, height = 600,
    units = "px")
# The plot function itself
plot(aggEmissions, type = "l", xlab = "Year",
     ylab = expression('Total PM'[2.5]*" Emission"),
     main = 'Particle Matter Emissions in Baltimore from 1999 to 2008')
# Don't forget to call dev.off
dev.off()