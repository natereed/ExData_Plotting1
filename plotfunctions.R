library(dplyr);
library(lubridate);

read_data <- function(add_date_time=TRUE) {
  household_power <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
  household_power <- filter(household_power, Date=='1/2/2007' | Date=='2/2/2007');
  
  if (add_date_time) {
    # Convert dates / times into continuous numeric values
    household_power$date_time <- as.numeric(as.POSIXct(strptime(paste(household_power$Date, household_power$Time), 
                                                                format="%d/%m/%Y %H:%M:%S",
                                                                tz="GMT")));
  }
  return(household_power);
}

label_axis_with_days <- function() {
  # Use labels Thursday, Friday, Saturday
  points <- as.POSIXlt(as.Date(c("2007-02-01", "2007-02-02", "2007-02-03"),format="%Y-%m-%d"))
  day_labels <- as.vector(wday(points, label=TRUE))
  axis(1, at=as.numeric(points), labels=day_labels)
}

# Plot 1: Global Active Power Histogram
plot_global_active_power_hist <- function(household_power) {
  hist(as.numeric(household_power$Global_active_power), col='RED', xlab='Global Active Power (kilowatts)', main="Global Active Power")
}

# Plot2: Global Active Power vs. Date/Time
plot_global_active_power_vs_date_time <- function(household_power, show_units=FALSE) {
  if (show_units) {
    label = "Global Active Power (kilowatts)"
  } else {
    label = "Global Active Power";
  }
  plot(household_power$date_time, household_power$Global_active_power, type="l", xaxt="n", xlab="", ylab=label);
  label_axis_with_days();
}

# Plot 3: Plot Sub-Metering vs. Date/Time
plot_sub_metering_vs_date_time <- function(household_power, show_box=TRUE) {
  plot(household_power$date_time, as.numeric(household_power$Sub_metering_1), type="l", xaxt="n", xlab="", ylab="Energy sub metering")
  lines(household_power$date_time, as.numeric(household_power$Sub_metering_2), type="l", col="red")
  lines(household_power$date_time, as.numeric(household_power$Sub_metering_3), type="l", col="blue")
  
  label_axis_with_days();
  
  if (show_box) {
    legend("topright", c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"), lty=c(1,1,1), col=c("black", "red", "blue"))
  }
  else {
    legend("topright", c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"), lty=c(1,1,1), col=c("black", "red", "blue"), bty="n");
  }
}

# Plot: Voltage vs. Date/Time
plot_voltage_vs_date_time <- function(household_power) {
  plot(household_power$date_time, as.numeric(household_power$Voltage), 
       type="l", xaxt="n", xlab="datetime", ylab="Voltage");
  label_axis_with_days();
}

# Plot: Global Reactive Power vs. Date/Time
plot_global_reactive_power_vs_date_time <- function(household_power) {
  plot(household_power$date_time, household_power$Global_reactive_power, type="l", xaxt="n", xlab="datetime", ylab="Global_reactive_power");
  label_axis_with_days();
}
