#EDA Week 2 Plot 1

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
t_p2 = " "
ylab_p2 = "Global Active Power (kilowatts)"

plot(data$timestamp, data$Global_active_power, main = paste(t_p2), ylab = ylab_p2, type = "l",
     lty = 1, xlab = t_p2)

#Create PNG
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()