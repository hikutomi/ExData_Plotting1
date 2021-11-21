## Exploratory Data Analysis Week1 plot2
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

## To make plot2
png(file="plot2.png",width=480,height=480)
with(myData2, plot(myDate3, GAP,
                   type = "l", col = "black",
                   ylab = "Global Active Power (kilowatts)",
                   ylim = c(0,8), yaxp = c(0, 6, 3),
                   xlab = ""))
dev.off()