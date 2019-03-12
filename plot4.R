

#Download and unzip files
path<-getwd()
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,file.path(path,"power.zip"))
dataFiles2<-unzip(zipfile="power.zip")
data_full<-read.table(dataFiles2, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Fixing the date format
data_full$Date<-as.Date(data_full$Date, format="%d/%m/%Y")

#Pulling the needed data
data<-subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

#Changing Date format
Datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#Set up for multiple plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#Create the plots
with(data, {
        plot(data$Global_active_power~data$Datetime,     ##Top Left Plot (copied from plot2.R)
             type="l", 
             ylab="Global Active Power", 
             xlab="")
        plot(data$Voltage~data$Datetime,                 ##Top Right Plot 
             type="l", 
             ylab="Voltage", 
             xlab="datetime")
        plot(Sub_metering_1~Datetime,                    ##Bottom Left Plot
             col="black", 
             type="l", 
             ylab="Energy sub metering",
             xlab="")  
                lines(Sub_metering_2~Datetime, col="red")
                lines(Sub_metering_3~Datetime, col="blue")
                legend("topright", 
                       col=c("black","red","blue"), 
                       cex=0.8, 
                       pt.cex = 0.5,
                       lty=1, 
                       lwd=2, 
                       bty="n", 
                       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       xpd=TRUE)
        plot(data$Global_reactive_power~data$Datetime,   ##Bottom Right Plot 
             type="l", 
             ylab="Global_reactive_power", 
             xlab="datetime")
})

#Create png file
png("plot4.png",width=480,height=480,units="px")

dev.off()