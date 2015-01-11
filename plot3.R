##Get the path to the working directory
workingdir <- getwd()

##file path to root directory of local data file folder
file_path_root = workingdir

##read entire the file household power consumption data file

file_path = paste0(file_path_root, "/Data Analysis/exdata-data-household_power_consumption/household_power_consumption.txt")

powerdat <- read.csv(file_path, header= TRUE, sep=";", na.strings = "?")

##subset the data file

days <- powerdat$Date == "1/2/2007" | powerdat$Date == "2/2/2007"

powerdat1 <- powerdat[which(days),]

##remove empty data cases

powerdat1 <- na.omit(powerdat1)

##reformat date and create a standard date and time variable

powerdat1$Date <- as.Date(powerdat1$Date,format = "%d/%m/%Y")

powerdat1$datetime <- paste(powerdat1$Date, powerdat1$Time)

powerdat1$datetime <- strptime(powerdat1$datetime,format = "%Y-%m-%d %H:%M:%S")

##plot all 3 Energy sub metering variables on the same plot vs day of week
##with each identified using a differnt colour 
par(ps=12)  # Make text 12 point
par(font.lab=2)
par(font.main=2)
par(lwd=1)

plot(powerdat1$datetime,powerdat1$Sub_metering_1,ylim=range(c(powerdat1$Sub_metering_1,powerdat1$Sub_metering_2,powerdat1$Sub_metering_3)),ylab="Energy sub metering",xlab="",type="l",col="black",font=2)
lines(powerdat1$datetime,powerdat1$Sub_metering_2,col="red",font=2)
lines(powerdat1$datetime,powerdat1$Sub_metering_3,col="blue",font=2)

legend("topright",text.font=2,seg.len=1.5,y.intersp=0.8,box.lwd=1,lwd=1,xjust=1,col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##copy plot to a png file
dev.copy(png, file="plot3.png")

##close device
dev.off()
