# First let's unnzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Then load the data
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
# Let's aggregate the data emissions trhough each year
aggEmissions <- aggregate(nei$Emissions, by = list(nei$year), FUN = "sum")
# PNG configuration for the plot
png(filename = "./plots/plot1.png",
    width = 600, height = 600,
    units = "px")
# The plot function itself
plot(aggEmissions, type = "l", xlab = "Year",
     ylab = expression('Total PM'[2.5]*" Emission"),
     main = 'Particle Matter Emissions in the US from 1999 to 2008')
# Don't forget to call dev.off
dev.off()