## Reads the data.
house <- read.table("household_power_consumption.txt", sep=";", skip = 1)

## The first column is reformatted as Date.
house[,1] <- as.Date(strptime(house[,1], "%d/%m/%Y"))

## Subsets the data.
subdat <- subset(house, (V1==as.Date("2007-02-01") | V1 ==as.Date("2007-02-02")))

## Renames the variables.
names(subdat) <- c("date", "time", "glactpow", "glreacpow", "voltage", "glintensity",
                   "submet1", "submet2", "submet3")

## The class of the global active power column is changed to numeric.
subdat[,3] <- as.numeric(as.character(subdat[,3]))

## Adds a POSIXct column with the date and time info.
timedat <- mutate(subdat, extime=as.POSIXct(paste(date, time)))

## The class of the sub_metering cols are changed to numeric.
timedat$submet1 <- as.numeric(as.character(timedat$submet1))
timedat$submet2 <- as.numeric(as.character(timedat$submet2))
timedat$submet3 <- as.numeric(as.character(timedat$submet3))

## Generates the plot.                  

plot(timedat$extime,timedat$submet1,xlab="", ylab="Energy sub metering",type="l",)
lines(timedat$extime,timedat$submet2,col="red")
lines(timedat$extime,timedat$submet3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", 
                  "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

## Saves the file.
dev.copy(png,"plot3.png",width=480, height=480)
dev.off()