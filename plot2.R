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
png(filename = 'plot2.png', width=480, height=480, units="px");
plot(
  type = 'l',
  dataNeta$Global_active_power, 
  main = '', 
  ylab = 'Global Active Power (kilowatts)', xlab = '',
  xaxt='n'
)
axis(1, at=c(0,nrow(dataNeta)/2,nrow(dataNeta)), labels = c('Thu','Fri','Sat'))
dev.off()

