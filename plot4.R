##
## This script plots the Global Active Power, Energy Sub Metering, Voltage and
## Global Reactive Power from days 2007-02-01 to 2007-02-02 in UC Irvine's data
## on Individual Household Power Consumption and saves it to a PNG file.
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

## Add POSIXct formatted dates and times to subset

irvineSubset$datetime <- strptime(paste(irvineSubset$Date, irvineSubset$Time),
                                  "%d/%m/%Y %H:%M:%S")

## Create a PNG graphic device

png(filename = "plot4.png", units = "px", width = 480, height = 480)

## Plot the data

par(mfcol=c(2,2)) ## Create an empty 2X2 plot workspace

## Top-left Plot
with(irvineSubset, plot(datetime, Global_active_power,
                        type = "l",
                        xlab = "",
                        ylab = "Global Active Power (kilowatts)"))

## Bottom-left Plot
with(irvineSubset, plot(datetime, Sub_metering_1,
                        type = "l",
                        xlab = "",
                        ylab = "Energy sub metering"))

with(irvineSubset, lines(datetime, Sub_metering_2, col="red"))

with(irvineSubset, lines(datetime, Sub_metering_3, col="blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

## Top-right Plot
with(irvineSubset, plot(datetime, Voltage, type = "l"))

## Bottom-right Plot
with(irvineSubset, plot(datetime, Global_reactive_power, type = "l"))

## Merge Plots
par(mfrow=c(1,1))

## Close the graphic device

dev.off()