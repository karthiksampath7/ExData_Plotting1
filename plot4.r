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

png("plot4.png")

par(mfrow=c(2,2), mar=c(5,4,4,2))

#plot UR
with(data, plot(Global_active_power ~ as.numeric(Time), type="l", xaxt="n", xlab="", ylab = "Global Active Power"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") 

#plot UL
with(data, plot(Voltage ~ as.numeric(Time), type="l", xaxt="n", xlab="datetime"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") 

#plot BR
with(data, plot(Sub_metering_1 ~ as.numeric(Time), type="l", xaxt="n", xlab="", ylab = "Energy sub metering"))
with(data, points(Sub_metering_2 ~ as.numeric(Time), type="l", col="red"))
with(data, points(Sub_metering_3 ~ as.numeric(Time), type="l", col="blue"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") 
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

#plot BL
with(data, plot(Global_reactive_power ~ as.numeric(Time), type="l", xaxt="n", xlab="datetime"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") 
dev.off()
