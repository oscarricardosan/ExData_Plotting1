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
png(filename = 'plot1.png', width=480, height=480, units="px");
hist(
  dataNeta$Global_active_power, col = 'red', 
  main = 'Global Active Power', 
  xlab = 'Global Active Power (kilowatts)'
)
dev.off()

