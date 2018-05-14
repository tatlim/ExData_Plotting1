# download and unzip the data file
if (!file.exists("household_power_consumption.txt")) {
  fileUrl <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "household_power_consumption.zip")
  unzip(zipfile = "household_power_consumption.zip")
}

# read in data file
hpc_all <-
  read.table(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?",
    stringsAsFactors = FALSE
  )

# subset to dates: 2007-02-01 and 2007-02-02
hpc <- subset(hpc_all, Date == "1/2/2007" | Date == "2/2/2007")

# convert date and time
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# open PNG graphical device
png(filename = "plot3.png", type = "quartz")

# plot submetering vs. datetime
with(hpc, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
lines(x = hpc$datetime, y = hpc$Sub_metering_1, type = "l", col = "black")
lines(x = hpc$datetime, y = hpc$Sub_metering_2, type = "l", col = "red")
lines(x = hpc$datetime, y = hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close graphics device
dev.off()