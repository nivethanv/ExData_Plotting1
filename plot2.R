#reading raw data file in
fulldata<-read.table("household_power_consumption.txt",
                     sep=";", 
                     header=TRUE, 
                     stringsAsFactors = FALSE)

#filtering for dates of interest
fulldata$Date<-as.Date(fulldata$Date, format="%d/%m/%Y")
subsetdata<-subset(fulldata, Date=="2007-02-01" | Date=="2007-02-02")

#converting column of interest to numeric type, so it can be plotted
subsetdata$Global_active_power<-as.numeric(subsetdata$Global_active_power)

#making a variable that has both date and time info, to plot on x axis
dateTime<-paste(subsetdata$Date, subsetdata$Time)
dateTime<-strptime(dateTime, "%Y-%m-%d %H:%M:%S")
subsetdata<-cbind(dateTime,subsetdata)

#plotting graph
windows()
with(subsetdata, plot(dateTime, Global_active_power,
                      xlab="",
                      ylab="Global Active Power (kilowatts)",
                      type="l"))
#saving file to png
dev.copy(png,"plot2.png")
dev.off()