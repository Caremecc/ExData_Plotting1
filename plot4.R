## Load the data set in to R
epc <- file("household_power_consumption.txt")

## Read dataset
epcdata <- read.table(text = grep("^[1,2]/2/2017", readLines(epc), value = TRUE), 
                      col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", "Global_intensity", 
                                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                      sep = ";", header = TRUE)

EPD_Data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';',
                     na.string = "?", nrows = 2075259, check.names = FALSE,
                     stringsAsFactors = FALSE, comment.char = "", quote = '\"')

## Change the date format
EPD_Data$Date <- as.Date(EPD_Data$Date, "%d/%m/%Y")

##filter out the dates to be use 2007-02-01 to 2007-02-02.
EPDdata <- subset(EPD_Data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(EPD_Data)

## Time conversion
date_time <- paste(as.Date(EPDdata$Date), EPDdata$Time)
EPDdata$Date_Time <- as.POSIXct(date_time)

## Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(EPDdata, {
  plot(Global_active_power ~ Date_Time, type = "l",
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Date_Time, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Date_Time, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ Date_Time, col = "red")
  lines(Sub_metering_3 ~ Date_Time, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
  plot(Global_reactive_power ~ Date_Time, type = "l",
       ylab = "Global_reactive_power", xlab = "date_time")
})

## To name, size and save the created plot
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
