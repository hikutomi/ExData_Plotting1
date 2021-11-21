## Exploratory Data Analysis Week1 plot4
library(data.table)
library(dplyr)

## Common to plot1, 2, 3, and 4
## To read, store, transform and subset the data
setwd("C:/Users/User/Documents/coursera/JHU_ExploratoryDataAnalysis/wk1/")
myData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
t1 <- as.Date("2007-02-01")
t2 <- as.Date("2007-02-02")
myData2 <- myData %>% 
  mutate(myDate = as.Date(Date, "%d/%m/%Y")) %>%
  subset(myDate == t1 | myDate == t2) %>%
  
  mutate(myDate2 = paste(Date, Time, sep = " "), 
         myDate3 = strptime(myDate2, "%d/%m/%Y %H:%M:%S"),
         GAP = as.numeric(Global_active_power),
         GRAP = as.numeric(Global_reactive_power),
         VOL = as.numeric(Voltage),
         SM1 = as.numeric(Sub_metering_1),
         SM2 = as.numeric(Sub_metering_2),
         SM3 = as.numeric(Sub_metering_3)) %>%
  select(myDate3, GAP, GRAP, VOL, SM1, SM2, SM3)
## End of common code

## To make plot4
png(file="plot4.png",width=480,height=480)
par(mfrow = c(2, 2), mar = c(5, 4, 3, 2))
## graph1(topLeft)
with(myData2, plot(myDate3, GAP,
                   type = "l", col = "black",
                   ylab = "Global Active Power (kilowatts)",
                   ylim = c(0,8), yaxp = c(0, 6, 3),
                   xlab = ""))

## graph2(topRight)
with(myData2, plot(myDate3, VOL,
                   type = "l", col = "black",
                   ylab = "Voltage",
                   ylim = c(233,247), yaxp = c(234, 246, 6),
                   xlab = "datetime"))

## graph3(bottomLeft)
 with(myData2, plot(myDate3, SM1,
                    type = "l", col = "black",
                    ylab = "Energy sub metering",
                    ylim = c(0,40), yaxp = c(0, 30, 3),
                    xlab = ""))
 par(new = TRUE)
 with(myData2, plot(myDate3, SM2,
                    type = "l", col = "red",
                    ylab = "",
                    ylim = c(0,40), yaxp = c(0, 30, 3),
                    xlab = ""))
 par(new = TRUE)
 with(myData2, plot(myDate3, SM3,
                    type = "l", col = "blue",
                    ylab = "",
                    ylim = c(0,40), yaxp = c(0, 30, 3),
                    xlab = ""))
legend("topright",
       bty = "n",
       cex = 0.9,
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## graph4(bottomRight)
with(myData2, plot(myDate3, GRAP,
                   type = "l",
                   col = "black",
                   ylab = "Global_reactive_power",
                   ylim = c(0.0,0.5), yaxp = c(0.0, 0.5, 5),
                   xlab = "datetime"))

dev.off()