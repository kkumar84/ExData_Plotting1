## We will assume that plot4.R is stored in the same directory as 
## household_power_consumption.txt. This code defines a function that does 
## not take any arguments, but reads the .txt file, processes it as detailed below,
## and produces the histogram required. 
## The code takes ~30 secs as reading in the txt file(133 MB) is time consuming.

plot4 <- function(){
  
  ## creating a temporary data frame using the txt file. 
  tmppowused.df <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
  
  ## converting the first column to type Date so we can subset data from Feb1 &2, 2007
  tmppowused.df$Date <- as.Date(as.character(tmppowused.df$Date), format = "%d/%m/%Y")
  
  ## dataframe for Feb 1&2, 2007
  powused.df <- subset(tmppowused.df, tmppowused.df$Date %in% c(as.Date("2007-02-01"),
                                                                as.Date("2007-02-02")))
  
  ## Replacing Time with POSIXlt class time
  powused.df$Time <- strptime(paste(powused.df$Date, as.character(powused.df$Time)),"%Y-%m-%d %H:%M:%S")
  
  ## opening file device. plot3.png is stored in the working directory
  png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
  
  ## 2x2 for plots
  par(mfrow = c(2,2))
  
  ## plotting the four plots
  
  plot(powused.df$Time,powused.df$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  
  plot(powused.df$Time,powused.df$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  
  plot(powused.df$Time, powused.df$Sub_metering_1, type = "l", xlab = "",ylab = "Energy sub metering")
  lines(powused.df$Time, powused.df$Sub_metering_2, type = "l", col = "red")
  lines(powused.df$Time, powused.df$Sub_metering_3, type = "l", col = "blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col= c("black","red","blue"))
  
  plot(powused.df$Time,powused.df$Global_reactive_power, xlab = "datetime", ylab = "Global Reactive Power", type = "l")
  
  dev.off()
  
}
  