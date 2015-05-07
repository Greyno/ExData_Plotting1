getwd()
#To read in a large file, can read in a few rows, but then will need to assign the column named by reading the firs row of the file (column names) and assigning to the columns in the new file
#> read.table("df.dat", skip = 5, nrow = 6, col.names = colnames(read.table("df.dat", nrow = 1, header = TRUE)))

#Read in the data file
#Use ";" for the separator; set header=TRUE to use the column names in the file
#The date column is a factor and by using na.strings=?, the numericals are not factors #but "num"
#The file's Date column has the format of day, month, year
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?") 

#Convert the data column into dates
data$Date<-as.Date(data$Date,format="%d/%m/%Y") 

#str(data) #The Date column is now a date and not a factor
#See http://www.r-bloggers.com/date-formats-in-r/ for more on dates

#Only use row data from the dates 2007-02-01 and 2007-02-02 (2880 rows)
subset_data<-data[data$Date>="2007-02-01" & data$Date<="2007-02-02",] #Rows 66637-69516

#Convert the time column from a factors variable to a Time variable
#Create a chr variable with the information from the Date and Time columns
create_time_and_date <-paste((subset_data$Date), subset_data$Time)

#Convert these chrs into a POSIXct format (time and date) and add back to the original #dataset
subset_data$Datetime<-as.POSIXct(create_time_and_date)
#str(subset_data) #Extra column added to the data

#Need to remove the larger data file from here: use rm <filename>
rm(data)

##Print to the screen device
#plot(subset_data$Datetime, subset_data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

##Plot graph #2 to a file - set the size to 480x480 pixels
png(file="plot2.png", width=480, height=480)
#Plot x vs y, with line symbol, set up x- and y-axis label
plot(subset_data$Datetime, subset_data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()