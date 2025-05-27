library(dplyr)
## Read, filter and transform data using the pipeline capability of R
## It is assumed that the source file is available in the work directory
hpc<-
  read.csv("household_power_consumption.txt",sep=";",na.strings='?',colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, Time, sep=" "),format="%d/%m/%Y %H:%M:%S")), Date=as.Date(Date,format="%d/%m/%Y") ) 

## Create plot area for the 4 graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Graph #1
with(hpc, plot(Time,Global_active_power, type="l",main = NULL, ylab="Global Active Power (kilowatts)", xlab="", xaxt="n", cex.lab=0.8))
axis.POSIXct(1,format="%a")

## Graph #2
with(hpc, plot(Time,Voltage, type="l",main = NULL, ylab="Global Active Power (kilowatts)", xlab="datetime", xaxt="n", cex.lab=0.8))
axis.POSIXct(1,format="%a")

## Graph #3
with(hpc, plot(Time,Sub_metering_1, type="l",main = NULL, ylab="Energy sub metering", xlab="", xaxt="n", col="black", cex.lab=0.8))
with(hpc,lines(Time,Sub_metering_2, col="red"))
with(hpc,lines(Time,Sub_metering_3, col="blue"))
axis.POSIXct(1,format="%a")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)

## Graph #4
with(hpc, plot(Time,Global_reactive_power, type="l",main = NULL, ylab="Global Active Power (kilowatts)", xlab="datetime", xaxt="n", cex.lab=0.8))
axis.POSIXct(1,format="%a")

## Export plot as PNG
dev.copy(png, file="plot4.png")
dev.off()