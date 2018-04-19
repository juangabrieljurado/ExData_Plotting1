## Unzip the file
file_zip <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_unzip <- unzip(fichero_zip)
electric_data <- read.table(file_unzip, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

## Some checks of the file
head(electric_data)
dim(electric_data)
names(electric_data)
str(electric_data)

## Convert to datetime
date_time <- strptime(paste(electric_data_subset$Date, electric_data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Convert to numeric the sub_metering fields
sub_met1 <- as.numeric(electric_data_subset$Sub_metering_1)
sub_met2 <- as.numeric(electric_data_subset$Sub_metering_2)
sub_met3 <- as.numeric(electric_data_subset$Sub_metering_3)

## Make the plot
png("plot3.png", width = 480, height = 480)
plot(date_time, sub_met1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(date_time, sub_met2, type = "l", col = "red")
lines(date_time, sub_met3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 2.5)
dev.off()