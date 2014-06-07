##
## This script plots a histogram of the Global Active Power on days 2007-02-01
## and 2007-02-02 from UC Irvine's data on Individual Household Power
## Consumption and saves it to a PNG file.
##

## Download and unzip data if necessary

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zippedData = "exdata-data-household_power_consumption.zip"
dataFile = "household_power_consumption.txt"

if (!file.exists(zippedData)) {
    download.file(url = url, destfile = zippedData)
    unzip(zippedData)
}

## Read in and subset data

irvineData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")
irvineSubset <- subset(irvineData, Date == "1/2/2007" | Date == "2/2/2007")

## Plot the data

with(irvineSubset, hist(Global_active_power,
                        col = "orangered2",
                        main = "Global Active Power",
                        xlab = "Global Active Power (kilowatts)",
                        ylab = "Frequency"))

## Save the data plot to PNG

dev.copy(png, file="plot1.png", units="px", width=480, height=480)

## Close the graphic device

dev.off()