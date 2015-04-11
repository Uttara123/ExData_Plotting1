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
# create a new column with the date and time combined into standard format
df$tmp <- paste(df$Date,df$Time)
df$tmp <- strptime(df[,"tmp"],"%d/%m/%Y %H:%M:%S")   
# plot the graph on the screen
with(df, plot(df$tmp, as.numeric(as.character(df$Global_active_power)) , ylab = "Global Activer Power(kilowatts)", xlab="", main="", type="l" )) 
# copy the plot to a png file
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off(3)
