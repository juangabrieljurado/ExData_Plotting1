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

## Make the plot
png("plot2.png", width = 480, height = 480)
plot(date_time, global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()