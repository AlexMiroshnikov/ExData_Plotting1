readDataFromFile <- function(filename) {
    read.csv(filename, sep = ';', colClasses = 'character')
}

prepareDataFromInput <- function(fileData) {
    fileData[which(fileData$Date == '1/2/2007' | fileData$Date == '2/2/2007'), ]
}

plotData <- function(data) {
    data[, 'Sub_metering_1'] <- as.numeric(data[, 'Sub_metering_1'])
    data[is.na(data$Sub_metering_1), 'Sub_metering_1'] <- 0
    data[, 'Sub_metering_2'] <- as.numeric(data[, 'Sub_metering_2'])
    data[is.na(data$Sub_metering_2), 'Sub_metering_2'] <- 0
    data[, 'Sub_metering_3'] <- as.numeric(data[, 'Sub_metering_3'])
    data[is.na(data$Sub_metering_3), 'Sub_metering_3'] <- 0
    
    data$Date <- strptime(paste(data$Date, data$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')

    png('./plot3.png', width = 480, height = 480)
    maxY <- max(max(data$Sub_metering_1), max(data$Sub_metering_2), max(data$Sub_metering_3))

    plot(c(data$Date[1], data$Date[length(data$Date)]), c(0, maxY), type='n', xlab = '', ylab = 'Energy sub metering')
    lines(data$Date, data$Sub_metering_1, col = 'black')
    lines(data$Date, data$Sub_metering_2, col = 'red')
    lines(data$Date, data$Sub_metering_3, col = 'blue')

    legend(
        'topright',
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
        lty = c(1, 1, 1),
        col = c('black','red', 'blue')
    )

    dev.off()
}

plotData(prepareDataFromInput(readDataFromFile('../household_power_consumption.txt')))
