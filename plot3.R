library(dplyr)
## Read, filter and transform data using the pipeline capability of R
## It is assumed that the source file is available in the work directory
hpc<-
  read.csv("household_power_consumption.txt",sep=";",na.strings='?',colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, Time, sep=" "),format="%d/%m/%Y %H:%M:%S")), Date=as.Date(Date,format="%d/%m/%Y") ) 

## Create line plot with the given format specifications
with(hpc, plot(Time,Sub_metering_1, type="l",main = NULL, ylab="Energy sub metering", xlab="", xaxt="n", col="black"))
with(hpc,lines(Time,Sub_metering_2, col="red"))
with(hpc,lines(Time,Sub_metering_3, col="blue"))
axis.POSIXct(1,format="%a")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

## Export plot as PNG
dev.copy(png, file="plot3.png")
dev.off()