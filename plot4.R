## Unzip the file
file_zip <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_unzip <- unzip(fichero_zip)
electric_data <- read.table(file_unzip, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

## Some checks of the file
head(electric_data)
dim(electric_data)
names(electric_data)
str(electric_data)

## Subset the data
library(dplyr)
electric_data_subset <- filter(electric_data, Date == "1/2/2007" | Date == "2/2/2007")
table(electric_data_subset$Date)
global_active_power <- as.numeric(electric_data_subset$Global_active_power)

## Convert to datetime
date_time <- strptime(paste(electric_data_subset$Date, electric_data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Convert to numeric the sub_metering fields
sub_met1 <- as.numeric(electric_data_subset$Sub_metering_1)
sub_met2 <- as.numeric(electric_data_subset$Sub_metering_2)
sub_met3 <- as.numeric(electric_data_subset$Sub_metering_3)

## Convert to numeric the voltage and global reactive power fields
voltage_line <- as.numeric(electric_data_subset$Voltage)
global_reactive_power_line <- as.numeric(electric_data_subset$Global_reactive_power)

## Make the plots

png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
plot(date_time, global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(date_time, sub_met1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(date_time, sub_met2, type = "l", col = "red")
lines(date_time, sub_met3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1.5, lty = 1, bty = "n")
plot(date_time, voltage_line, type ="l", xlab = "datetime", ylab = "Voltage")
plot(date_time, global_reactive_power_line, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
