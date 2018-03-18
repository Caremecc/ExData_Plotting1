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

## Plot 2
plot(EPDdata$Global_active_power ~ EPDdata$Date_Time, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## To name, size and save the created plot
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
