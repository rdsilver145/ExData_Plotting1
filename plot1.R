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


##Plot a histogram

par(ps=12)  # Make text 12 point
par(font.lab=2)
par(font.main=2)
par(lwd=1)
hist(font=2, as.numeric(powerdat1$Global_active_power),breaks=12,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")

##copy plot to a png file
dev.copy(png, file="plot1.png")

##close device
dev.off()