#EDA Week 3 Plot 1

#Exploratory Data Analysis Project

#Ensure dates are read in English, not German
Sys.setlocale("LC_TIME", "English")

#Check for packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("lubridate")) {
  install.packages("liubridate")
}

#Apply Packages
library(data.table)
library(lubridate)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "~/R/Exploratory Data Analysis/household_power_consumption.zip")
#Unzip and Extract Data
power_data <- read.table(unz("~/R/Exploratory Data Analysis/household_power_consumption.zip", "household_power_consumption.txt"), header = T, sep = ";")

#Formate dates
power_data$Date <- dmy(power_data$Date)
power_data$Date <- as.Date(power_data$Date)

#Subset Data
data <- subset(power_data, (Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")))
attach(data) #I can clean out all of the data$xxx with this command

#Ensure Proper Classes
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))

#Create Power vs. Time Plot
#Combine date and time to produce timestamp
data$Time <- as.character(data$Time)
data$Date_char <- as.character(data$Date)
data <- transform(data, timestamp = format(as.POSIXct(paste(data$Date, data$Time)), format =
                                             "%Y-%m-%d %H:%M:%S"))
#Convert to POSIXct class so that days show up
data$timestamp <- as.POSIXct(data$timestamp)

#Create Sub-Metering Plot
t_p3 = " "
ylab_p3 = "Energy Sub Metering"
plot(data$timestamp, data$Sub_metering_1, col = "black", main = paste(t_p3), ylab = ylab_p3,
     xlab = t_p3, type = "l")
lines(data$timestamp, data$Sub_metering_2, col = "red")
lines(data$timestamp, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

#Create PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()