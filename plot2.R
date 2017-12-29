readDataFromFile <- function(filename) {
    read.csv(filename, sep = ';', colClasses = 'character')
}

prepareDataFromInput <- function(fileData) {
    fileData[which(fileData$Date == '1/2/2007' | fileData$Date == '2/2/2007'), ]
}

plotData <- function(data) {
    data[, 'Global_active_power'] <- as.numeric(data[, 'Global_active_power'])
    data <- data[!is.na(data[, 'Global_active_power']), ]
    data$Date <- strptime(paste(data$Date, data$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
    png('./plot2.png', width = 480, height = 480)
    plot(data$Date, data$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (kilowatts)')
    dev.off()
}

plotData(prepareDataFromInput(readDataFromFile('../household_power_consumption.txt')))
