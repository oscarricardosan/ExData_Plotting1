if(!file.exists('household_power_consumption.zip'))
  download.file(
    'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
    destfile = 'household_power_consumption.zip'
  )
#Read data
if(!file.exists('household_power_consumption.txt'))
  unzip('household_power_consumption.zip');
if(!(exists('dataPrin') & exists('dataNeta'))){
  dataPrin <- read.csv(
    'household_power_consumption.txt',na.strings = "?", 
    colClasses = c(
      'character','character','numeric',
      'numeric','numeric','numeric',
      'numeric','numeric','numeric'
    ), quote = '', sep = ';'
  )
  dataPrin$Time <- strptime(dataPrin$Time, format = '%H:%M:%S')
  dataPrin$Date<- as.Date(dataPrin$Date, format='%d/%m/%Y')
  dataNeta <- subset(dataPrin, Date=='2007-02-01'|Date=='2007-02-02')
}
png(filename = 'plot3.png', width=480, height=480, units="px");
plot(
  type = 'n', dataNeta$Sub_metering_1,  main = '', 
  ylab = 'Energy sub metering', xlab = '', xaxt='n'
)
lines(dataNeta$Sub_metering_1, col="black")
lines(dataNeta$Sub_metering_2, col="red")
lines(dataNeta$Sub_metering_3, col="blue")
legend(
  'topright',
  legend = c(
    'Sub_metering_1','Sub_metering_2','Sub_metering_3'
  ), 
  col = c('black','red','blue'), lty = 1
)
axis(1, at=c(0,nrow(dataNeta)/2,nrow(dataNeta)), labels = c('Thu','Fri','Sat'))
dev.off()

