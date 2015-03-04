
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

# Set plots layout -------------------------------------------------------------

par(mfrow = c(2, 2))

# Generate plot 1 --------------------------------------------------------------

with(dataSubset, plot(Time,
                      Global_active_power,
                      type = "l",
                      ylab = "Global Active Power",
                      xlab = ""))

# Generate plot 2 --------------------------------------------------------------

with(dataSubset, plot(Time,
                      Voltage,
                      type = "l"))

# Generate plot 3 --------------------------------------------------------------

with(dataSubset, plot(Time,
                      Sub_metering_1,
                      col = "black",
                      type = "n",
                      ylab = "Energy sub metering",
                      xlab = ""))


with(dataSubset, {
    lines(Time, Sub_metering_1, col = "black")
    lines(Time, Sub_metering_2, col = "red")
    lines(Time, Sub_metering_3, col = "blue")
})

legend("top",
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       cex = 0.7)

# Generate plot 4 --------------------------------------------------------------

with(dataSubset, plot(Time,
                      Global_reactive_power,
                      type = "l"))

# Save plot to a PNG -----------------------------------------------------------

dev.copy(png,
         file = "plot4.png",
         width = 480,
         height = 480)
dev.off()

#-------------------------------------------------------------------------------
