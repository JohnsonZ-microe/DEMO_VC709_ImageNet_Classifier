##The following two properties should be set for every design
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_in_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_in_n]
set_property PACKAGE_PIN H19 [get_ports clk_in_p]
set_property PACKAGE_PIN G18 [get_ports clk_in_n]

## SW5
set_property PACKAGE_PIN AP40 [get_ports rstp_sys]
set_property IOSTANDARD LVCMOS18 [get_ports rstp_sys]

## SW2 - 16 - 1
set_property PACKAGE_PIN AV30 [get_ports enable]
set_property IOSTANDARD LVCMOS18 [get_ports enable]
