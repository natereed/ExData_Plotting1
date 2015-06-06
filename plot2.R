source("plotfunctions.R");

household_power <- read_data(add_date_time=TRUE);  
png(filename="plot2.png", height=480, width=480)
plot_global_active_power_vs_date_time(show_units=TRUE);
dev.off();