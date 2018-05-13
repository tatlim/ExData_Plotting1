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

# plot submetering vs. datetime
with(hpc, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
lines(x = hpc$datetime, y = hpc$Sub_metering_1, type = "l", col = "black")
lines(x = hpc$datetime, y = hpc$Sub_metering_2, type = "l", col = "red")
lines(x = hpc$datetime, y = hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# copy from screen device to png file
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()
