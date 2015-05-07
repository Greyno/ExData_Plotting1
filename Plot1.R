getwd()
#To read in a large file, can read in a few rows, but then will need to assign the column names by reading the first row of the file (column names) and assigning to the columns in the new file:
#> read.table("df.dat", skip = 5, nrow = 6, col.names = colnames(read.table("df.dat", nrow = 1, header = TRUE)))

#Read in the data file
#Use ";" for the separator; set header=TRUE to use the column names in the file
#The date column is a factor and by using na.strings=?, the numericals are not factors #but "num"
#The file's Date column has the format of day, month, year
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?") 

#Convert the data column into dates
data$Date<-as.Date(data$Date,format="%d/%m/%Y") 
#str(data) The Date column is now a date and not a factor

#Leave the time column unchanged for now

#See http://www.r-bloggers.com/date-formats-in-r/ for more on dates

#Only use row data from the dates 2007-02-01 and 2007-02-02 (2880 rows)
subset_data<-data[data$Date>="2007-02-01" & data$Date<="2007-02-02",] #Rows 66637-69516

#Need to remove the larger data file from here: use rm <filename>
rm(data)

##Plot graph #1 to a file - set the size to 480x480 pixels
png(file="plot1.png", width=480, height=480)
#Set up the x-axis label, main title and histogram colour
hist(subset_data$Global_active_power, main=paste("Global Active Power"), col="Red", xlab="Global Active Power (kilowatts)", ylim=c(0,1200), yaxp=c(0, 1200,3))
#Set the y-axis ticks marks and spacings with the axis parameter. (see ?par and ?axis)
axis(side=2, at=seq(0,1200,200))
dev.off()