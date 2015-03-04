
dataset <- "household_power_consumption.txt"

# Read dataset into R ----------------------------------------------------------

data <- read.table(dataset,
                   header = TRUE,
                   sep = ";",
                   na.strings = "?")

# Convert Date and Time variables ----------------------------------------------

data$Date <- as.Date(data$Date, "%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$Time <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")

# Subset dates from 2007-02-01 to 2007-02-02 -----------------------------------

startDate <- as.Date("01/02/2007", "%d/%m/%Y")
endDate <- as.Date("02/02/2007", "%d/%m/%Y")

dataSubset <- data[data$Date >= startDate & data$Date <= endDate, ]

# Generate sub metering plots --------------------------------------------------

with(dataSubset, plot(Time,
                      Sub_metering_1,
                      col = "black",
                      type = "n",
                      ylab = "Energy submetering",
                      xlab = ""))

with(dataSubset, lines(Time, Sub_metering_1, col = "black"))
with(dataSubset, lines(Time, Sub_metering_2, col = "red"))
with(dataSubset, lines(Time, Sub_metering_3, col = "blue"))

legend("topright",
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save plot to a PNG -----------------------------------------------------------

dev.copy(png,
         file = "plot3.png",
         width = 480,
         height = 480)
dev.off()

#-------------------------------------------------------------------------------
