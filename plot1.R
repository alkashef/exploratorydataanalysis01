
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

# Generate Global active power histogram ---------------------------------------

with(dataSubset, hist(Global_active_power,
                      col = "red",
                      xlab = "Global Active Power (kilowatts)",
                      main = "Global Active Power Histogram"))

with(dataSubset, rug(Global_active_power))

# Save plot to a PNG -----------------------------------------------------------

dev.copy(png,
         file = "plot1.png",
         width = 480,
         height = 480)
dev.off()

#-------------------------------------------------------------------------------
