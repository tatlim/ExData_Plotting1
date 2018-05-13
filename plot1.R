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

# plot the histogram of "Global Active Power"
hist(
  hpc$Global_active_power,
  col = "red",
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power"
)

# copy from screen device to png file
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()