#Download and unzip files
path<-getwd()
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,file.path(path,"power.zip"))
dataFiles2<-unzip(zipfile="power.zip")

powerConsump<-read.table(dataFiles2,header=TRUE,sep=";",stringsAsFactors=FALSE,dec=".")

#Change date format
powerConsump[powerConsump$Date %in% c("1/2/2007","2/2/2007") ,]

#Define Global Active Power subset
globalActivePower<-as.numeric(powerConsump$Global_active_power)

#Plot 
hist(globalActivePower, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylim=c(0,1000000))

#Create png file
png("plot1.png",width=480,height=480,units="px")

dev.off()
