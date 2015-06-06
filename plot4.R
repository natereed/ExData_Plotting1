source("plotfunctions.R");

png(filename="plot4.png", height=480, width=480)
par(mfrow=c(2,2))
household_power <- read_data();
plot_global_active_power_vs_date_time(show_units=FALSE);
plot_voltage_vs_date_time();
plot_sub_metering_vs_date_time(show_box=FALSE);
plot_global_reactive_power_vs_date_time();
dev.off();

