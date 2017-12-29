readDataFromFile <- function(filename) {
    read.csv(filename, sep = ';', colClasses = 'character')
}

prepareDataFromInput <- function(fileData) {
    fileData[which(fileData$Date == '1/2/2007' | fileData$Date == '2/2/2007'), ]
}

plotData <- function(data) {
    data[, 'Global_active_power'] <- as.numeric(data[, 'Global_active_power'])
    data <- data[!is.na(data[, 'Global_active_power']), ]
    png('./plot1.png', width = 480, height = 480)
    hist(data[, c('Global_active_power')], main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
    dev.off()
}

plotData(prepareDataFromInput(readDataFromFile('../household_power_consumption.txt')))
