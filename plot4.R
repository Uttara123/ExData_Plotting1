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

# create a new column with date and time combined in a standard format
df$tmp <- paste(df$Date,df$Time)
df$tmp <- strptime(df[,"tmp"],"%d/%m/%Y %H:%M:%S")   

par(mfrow = c(2,2))
# plot #1
with(df, plot(df$tmp, as.numeric(as.character(df$Global_active_power)) , ylab = "Global Activer Power", xlab="", main="", type="l" )) 

# plot #2
with(df, plot(df$tmp, as.numeric(as.character(df$Voltage)) , ylab = "Voltage", xlab="datetime", main="", type="l" )) 

# plot #3
with(df, plot(df$tmp, as.numeric(as.character(df$Sub_metering_1)) , ylab = "Energy sub metering", xlab="", main="",type="l" ))
lines(df$tmp, as.numeric(as.character(df$Sub_metering_2)),col="red")
lines(df$tmp, as.numeric(as.character(df$Sub_metering_3)),col="blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue") , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

#plot #4
with(df, plot(df$tmp, as.numeric(as.character(df$Global_reactive_power)) , ylab = "Global_reactive_power", xlab="datetime", main="", type="l" )) 

# copy the plot to a png file
dev.copy(png, file="plot4.png", width = 480, height = 480)
dev.off(3)
