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

#making graph
windows()
hist(subsetdata$Global_active_power,
     col="Red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global active power")

#saving file to png
dev.copy(png,"plot1.png")
dev.off()