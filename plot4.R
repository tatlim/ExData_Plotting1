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

# set parameters
par(mfrow = c(2, 2))

# plot global active power vs. time
with(hpc, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

# plot voltage vs. time
with(hpc, plot(datetime, Voltage, ylab = "Voltage", type = "l"))

# plot sub_metering vs. time
with(hpc, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
lines(x = hpc$datetime, y = hpc$Sub_metering_1, type = "l", col = "black")
lines(x = hpc$datetime, y = hpc$Sub_metering_2, type = "l", col = "red")
lines(x = hpc$datetime, y = hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot global reactive power vs. time
with(hpc, plot(datetime, Global_reactive_power, type = "l"))

# copy from screen device to png file
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
