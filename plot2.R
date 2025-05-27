library(dplyr)
## Read, filter and transform data using the pipeline capability of R
## It is assumed that the source file is available in the work directory
hpc<-
  read.csv("household_power_consumption.txt",sep=";",na.strings='?',colClasses =c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, Time, sep=" "),format="%d/%m/%Y %H:%M:%S")), Date=as.Date(Date,format="%d/%m/%Y") ) 

## Create line plot with the given format specifications
with(hpc, plot(Time,Global_active_power, type="l",main = NULL, ylab="Global Active Power (kilowatts)", xlab="", xaxt="n"))
axis.POSIXct(1,format="%a")

## Export plot as PNG
dev.copy(png, file="plot2.png")
dev.off()