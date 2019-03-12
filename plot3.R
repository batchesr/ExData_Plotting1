

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
data$Datetime <- as.POSIXct(Datetime)

#Create the plot
with(data, {
        plot(Sub_metering_1~Datetime, col="black", type="l", ylab="Energy sub metering", xlab="")
                     lines(Sub_metering_2~Datetime, col="red")
                     lines(Sub_metering_3~Datetime, col="blue")
})

#Add a legend
legend("topright", col=c("black","red","blue"), lty=1, lwd=2, xpd=TRUE, legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))

#Create png file
png("plot3.png",width=480,height=480,units="px")

dev.off()