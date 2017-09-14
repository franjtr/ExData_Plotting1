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

## Generates the plot.                  
plot(timedat$extime,timedat$glactpow,xlab="", ylab="Global Active Power (kilowatts)",type="l")

## Saves the file.
dev.copy(png,"plot2.png",width=480, height=480)
dev.off()

