library(chron)
library(dplyr)
library(lubridate)

fileroute<-"C:/Users/jorge/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt"
EPC<-read.table(fileroute, header = TRUE, sep = ";", dec = ".")
EPC_Data<-tbl_df(EPC)
wrong_format<-select(EPC_Data,-(1:2))
DT<-select(EPC_Data,(1:2))
DT<-mutate(DT,FULL_DATE=paste(Date,Time))
wrong_format<-lapply(wrong_format, as.numeric)
EPC_bind<-cbind(DT,wrong_format)
EPC_bind$Date<-as.Date(strptime(EPC$Date,"%d/%m/%Y"))
EPC_bind$FULL_DATE<-strptime(EPC_bind$FULL_DATE,"%d/%m/%Y %H:%M:%S")
EPC_bind$Time<-times(EPC$Time)
final_Data<-filter(EPC_bind, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))

png(
  "plot1.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

with(final_Data, hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))

dev.off()