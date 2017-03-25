# plot4.R
#

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile = "./electricPowerConsumption"
datatxt = "./household_power_consumption.txt"

# download the source data, if necessary
if (!file.exists(datatxt)){
  download.file(url,datafile,method="curl")
  unzip(datafile)
  print("Downloaded data")
} 

# read the data into a dataframe

hpcbig = read.table(datatxt, header=TRUE, na.strings = "?", colClasses = c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),sep=";")
hpcbig[,1] = as.Date(hpcbig[,1], format="%d/%m/%Y")

# extract the dates we wantl
hpc = subset(hpcbig, hpcbig$Date == as.Date("2007-02-01") | hpcbig$Date == as.Date("2007-02-02"))

# get a list of all the points in time
dateTimeString = paste(hpc$Date,hpc$Time)
hpcDateTime <- strptime(dateTimeString, "%Y-%m-%d %H:%M:%OS")

#open the png device
png(filename="./plot4.png", width=480, height=480)
par(mfrow=c(2,2))

#draw plot 1
plot(hpcDateTime, hpc$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#draw plot 2
plot(hpcDateTime, hpc$Voltage ,type = "l", ylab = "Voltage", xlab = "datetime")

#draw plot 3
plot(hpcDateTime, hpc$Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab = "")
lines(hpcDateTime, hpc$Sub_metering_2, col = "red")
lines(hpcDateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", lwd = "1", bty = "n", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#draw plot 4
plot(hpcDateTime, hpc$Global_reactive_power ,type = "l", ylab = "Global_reactive_power", xlab = "datetime")

#close the device
dev.off()