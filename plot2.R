

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
plot(data$Global_active_power~data$Datetime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")

#Create png file
png("plot2.png",width=480,height=480,units="px")

dev.off()