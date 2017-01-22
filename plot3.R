# We need to load ggplot2 for this plot
library(ggplot2)
# Unzip the data
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Load the data into R
nei <- readRDS("./data/summarySCC_PM25.rds")
dim(nei) # 6497651 * 6
scc <- readRDS("./data/Source_Classification_Code.rds")
dim(scc) # 11717 * 15
# Let's susbset the data of Baltimore (fips = 24510)
baltimore <- subset(nei, fips == 24510)
# Aggregate data
aggYearAndType <- aggregate(Emissions ~ year + type, baltimore, sum)
# The png export settings
png(filename = "./plots/plot3.png", width = 600,
    height = 600, units = "px")
# We use the ggplot function to use the aesthetics aes()
g <- ggplot(aggYearAndType, aes(x = year, y = Emissions, color = type))
# After we call ggplot, we need to define the type of graphics, in this case
# geom_line
g + geom_line() +
    # I'd like to have also points
    geom_point() +
    # Add y label
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    # And finally the plot's title
    ggtitle("Particle Matter Emissions in Baltimore City from 1999 to 2008")
    # Don't forget to call dev.off()
dev.off()