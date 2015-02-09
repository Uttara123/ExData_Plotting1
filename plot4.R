# read the file
df <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
# subset dates for Fe 01 and Feb 02 of 2007
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]
# exclude any rows with values of "?"
df <- df[df$Date != "?",]
df <- df[df$Global_active_power != "?", ]
df <- df[df$Sub_metering_1 != "?",]
df <- df[df$Sub_metering_2 != "?",]
df <- df[df$Sub_metering_3 != "?",]
# convert date into day of the week
df$tmp <- paste(df$Date,df$Time)
df$tmp <- strptime(df[,"tmp"],"%d/%m/%Y %H:%M:%S")   
df$Time <- strptime(df[,"Time"],"%H:%M:%S")   
#df$Date <- weekdays(df$Date)
# create the plot
#hist(as.numeric(as.character(df$Global_active_power)), col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
par(mfrow = c(2,2))
with(df, plot(df$tmp, as.numeric(as.character(df$Global_active_power)) , ylab = "Global Activer Power", xlab="", main="", type="l" )) 
with(df, plot(df$tmp, as.numeric(as.character(df$Voltage)) , ylab = "Voltage", xlab="datetime", main="", type="l" )) 
with(df, plot(df$tmp, as.numeric(as.character(df$Sub_metering_1)) , ylab = "Energy sub metering", xlab="", main="",type="l" ))
legend("topright", legend = "Sub_metering_1")
# copy the plot to a png file
lines(df$tmp, as.numeric(as.character(df$Sub_metering_2)),col="red")
legend("topright", legend = "Sub_metering_2")
lines(df$tmp, as.numeric(as.character(df$Sub_metering_3)),col="blue")
legend("topright", legend = "Sub_metering_3")

with(df, plot(df$tmp, as.numeric(as.character(df$Global_reactive_power)) , ylab = "Global_reactive_power", xlab="datetime", main="", type="l" )) 



# copy the plot to a png file
dev.copy(png, file="plot4.png", width = 480, height = 480)
dev.off(3)
