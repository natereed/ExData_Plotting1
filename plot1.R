source("plotfunctions.R");

household_power <- read_data();

# Disable scientific notation
options(scipen=999)

png(filename="plot1.png", width=480, height=480)
plot_global_active_power_hist(household_power);
dev.off();
