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
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(data2$dateTime, data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()