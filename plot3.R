#reading raw data file in
fulldata<-read.table("household_power_consumption.txt",
                     sep=";", 
                     header=TRUE, 
                     stringsAsFactors = FALSE)

#filtering for dates of interest
fulldata$Date<-as.Date(fulldata$Date, format="%d/%m/%Y")
subsetdata<-subset(fulldata, Date=="2007-02-01" | Date=="2007-02-02")

#converting columns of interest to numeric type, so they can be plotted
subsetdata$Sub_metering_1<-as.numeric(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_2<-as.numeric(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_3<-as.numeric(subsetdata$Sub_metering_3)


#making a variable that has both date and time info, to plot on x axis
dateTime<-paste(subsetdata$Date, subsetdata$Time)
dateTime<-strptime(dateTime, "%Y-%m-%d %H:%M:%S")
subsetdata<-cbind(dateTime,subsetdata)

#plotting graph
windows()
with(subsetdata, plot(dateTime, Sub_metering_1,
                      xlab="",
                      ylab="Energy sub metering",
                      type="l"))
with(subsetdata, lines(dateTime,Sub_metering_2, col="red"))
with(subsetdata, lines(dateTime,Sub_metering_3, col="blue"))
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), 
       col=c("black", "red","blue"))

#saving file to png
dev.copy(png,"plot3.png")
dev.off()

