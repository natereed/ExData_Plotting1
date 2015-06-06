source("plotfunctions.R");

household_power <- read_data();
png(filename="plot3.png", height=480, width=480)
plot_sub_metering_vs_date_time();
dev.off();
