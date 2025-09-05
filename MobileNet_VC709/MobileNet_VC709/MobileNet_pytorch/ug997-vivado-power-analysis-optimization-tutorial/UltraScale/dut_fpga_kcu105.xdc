#
# Constraints for the FPGA.
# KCU105  - Based on: http://xinc/sites/hwcp/board_files/Shared%20Documents/UltraScale/HW-U1-KCU105/REVB/0381556_HW-U1-KCU105_REVB_SCHEMATIC_12092013.PDF

# Inputs:
# Clock input FPGA on SYSCLK_300_P/N.
#
# MMCM locked, pass, to LEDs
#

# ---------- Inputs ----------

# Oscillator clock inputs
#
create_clock -period 3.333 -name sys_clk_in_p -add [get_ports sys_clk_in_p]
set_property IOSTANDARD LVDS [get_ports sys_clk_in_p]
set_property IOSTANDARD LVDS [get_ports sys_clk_in_n]
set_property PACKAGE_PIN AK16 [get_ports sys_clk_in_n]
set_property PACKAGE_PIN AK17 [get_ports sys_clk_in_p]

# ---------- Outputs ----------
# Pass output
#
set_property IOSTANDARD LVCMOS18 [get_ports gpio_out_pass]
set_property PACKAGE_PIN H27 [get_ports gpio_out_pass]

# leds
#
set_property IOSTANDARD LVCMOS18 [get_ports led]
set_property PACKAGE_PIN P25 [get_ports led]


#--------------------------------------------------------
# FMC outputs
#--------------------------------------------------------
set_property PACKAGE_PIN V26 [get_ports {fmc_out[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {fmc_out[0]}]

set_property PACKAGE_PIN W26 [get_ports {fmc_out[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {fmc_out[1]}]
