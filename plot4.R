## Include libraries
library(lubridate)

## Columns in dataset: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
data1 <- read.csv("household_power_consumption.txt", sep = ";")

## fix classes
data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))
data1$Global_reactive_power <- as.numeric(as.character(data1$Global_reactive_power))
data1$Voltage <- as.numeric(as.character(data1$Voltage))
data1$Global_intensity <- as.numeric(as.character(data1$Global_intensity))
data1$Sub_metering_1 <- as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2 <- as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3 <- as.numeric(as.character(data1$Sub_metering_3))

## New dateTime columns
dateTime <- dmy(data1$Date) + hms(data1$Time)
data1 <- cbind(data1, dateTime)

## Filter dataset
data2 <- data1[data1$dateTime >= ymd('2007-02-01') & data1$dateTime < ymd('2007-02-03'),]

## Graphics
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2))
## Top-Left
plot(data2$dateTime, data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Top-Right
plot(data2$dateTime, data2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Bottom-Left
plot(data2$dateTime, data2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data2$dateTime, data2$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red")
lines(data2$dateTime, data2$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue")
legend(x = "topright", legend = c("Sub metering 1","Sub metering 2", "Sub metering 3"), col=c("black", "red", "blue"), lwd = 1) 

## Bottom-Right
plot(data2$dateTime, data2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()