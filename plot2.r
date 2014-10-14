setwd("C:\Dev\RStudio\projects")

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

daterange=c(as.POSIXlt(min(data$Time)), as.POSIXlt(max(data$Time)+60))

png("plot2.png")
with(data, plot(Global_active_power ~ as.numeric(Time), type="l", xaxt="n", xlab="", ylab = "Global Active Power (kilowatts)"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") 
dev.off()
