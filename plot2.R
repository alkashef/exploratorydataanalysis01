
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

# Generate Global active power plot vs dateTime --------------------------------

par(mfrow = c(1, 1)) # reset plot layout

with(dataSubset, plot(Time,
                      Global_active_power,
                      type = "l",
                      ylab = "Global Active Power (kilowatts)",
                      xlab = "",
                      main = "Global Active Power over Time"))

# Save plot to a PNG -----------------------------------------------------------

dev.copy(png,
         file = "plot2.png",
         width = 480,
         height = 480)
dev.off()

#-------------------------------------------------------------------------------
