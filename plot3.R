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
# create a new column with data and time combined in a standard format
df$tmp <- paste(df$Date,df$Time)
df$tmp <- strptime(df[,"tmp"],"%d/%m/%Y %H:%M:%S")   
# plot the Sub_metering_1
with(df, plot(df$tmp, as.numeric(as.character(df$Sub_metering_1)) , ylab = "Energy sub metering", xlab="", main="",type="l" ))
# add line for Sub_metering_2
lines(df$tmp, as.numeric(as.character(df$Sub_metering_2)),col="red")
# add line for Sub_metering_3 
lines(df$tmp, as.numeric(as.character(df$Sub_metering_3)),col="blue")
# add legend
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue") , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
 
dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off(3)
