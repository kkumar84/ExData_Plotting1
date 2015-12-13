## We will assume that plot2.R is stored in the same directory as 
## household_power_consumption.txt. This code defines a function that does 
## not take any arguments, but reads the .txt file, processes it as detailed below,
## and produces the histogram required. 
## The code takes ~30 secs as reading in the txt file(133 MB) is time consuming.

plot2 <- function(){
 
  
  ## creating a temporary data frame using the txt file. 
  tmppowused.df <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
  
  ## converting the first column to type Date so we can subset data from Feb1 &2, 2007
  tmppowused.df$Date <- as.Date(as.character(tmppowused.df$Date), format = "%d/%m/%Y")
  
  ## dataframe for Feb 1&2, 2007
  powused.df <- subset(tmppowused.df, tmppowused.df$Date %in% c(as.Date("2007-02-01"),
                                                                as.Date("2007-02-02")))
  
  ## Replacing Time with POSIXlt class time
  powused.df$Time <- strptime(paste(powused.df$Date, as.character(powused.df$Time)),"%Y-%m-%d %H:%M:%S")
  
  ## opening file device. plot2.png is stored in the working directory
  png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
  
  plot(powused.df$Time, powused.df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  ## switching off the file device
  dev.off()
   
}