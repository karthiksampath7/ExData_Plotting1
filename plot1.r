setwd("C:/Users/rtimpe/Desktop/Coursera/ExploratoryDataAnalysis/Project 1")

raw.data <- read.table("household_power_consumption.txt", sep=";", header=T)
raw.data <- subset(raw.data, Date %in% c("1/2/2007", "2/2/2007"))

data <- raw.data

data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage  <- as.numeric(as.character(data$Voltage))
data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))

png("plot1.png")
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
