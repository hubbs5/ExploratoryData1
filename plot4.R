#EDA Week 4 Plot 1

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

#Create four plots
ylab_p41 = "Global Active Power"
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)))
plot(data$timestamp, data$Global_active_power, main = paste(t_p2), ylab = ylab_p41, type = "l",
     lty = 1, xlab = t_p2)
plot(data$timestamp, data$Voltage, xlab ="datetime", type = "l", ylab = "Voltage")
plot(data$timestamp, data$Sub_metering_1, col = "black", type = "l", ylab = "Energy Sub Metering",
     xlab = " ")
lines(data$timestamp, data$Sub_metering_2, col = "red")
lines(data$timestamp, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"), bty ="n")
plot(data$timestamp, data$Global_reactive_power, xlab = "datetime", type = "l", ylab = "Global_reactive_power")

#Create PNG
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
