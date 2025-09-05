#
# Constraints for the FPGA.
# KC705 Rev 1.1   - Based on:  http://xinc/sites/hwcp/board_files/Shared%20Documents/Kintex-7/KC705/Rev1.1/KC705_Rev1_1_dut.ucf
# Inputs:
# Clock input FPGA on SYS_CLK_P/N.
#
# MMCM locked, pass, to LEDs
#

# ---------- Inputs ----------

# Oscillator clock inputs
#
create_clock -period 5.000 -name sys_clk_in_p -add [get_ports sys_clk_in_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_in_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_in_n]
set_property PACKAGE_PIN AD11 [get_ports sys_clk_in_n]
set_property PACKAGE_PIN AD12 [get_ports sys_clk_in_p]


# ---------- Outputs ----------

# Pass output
#
set_property IOSTANDARD LVCMOS33 [get_ports gpio_out_pass]
set_property PACKAGE_PIN Y23 [get_ports gpio_out_pass]

# leds
#

set_property IOSTANDARD LVCMOS15 [get_ports led]
set_property PACKAGE_PIN AB8 [get_ports led]


#--------------------------------------------------------
# FMC outputs
#--------------------------------------------------------
set_property PACKAGE_PIN AA20 [get_ports {fmc_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[0]}]

set_property PACKAGE_PIN AB20 [get_ports {fmc_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[1]}]

set_property PACKAGE_PIN AB24 [get_ports {fmc_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[2]}]

set_property PACKAGE_PIN AC25 [get_ports {fmc_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[3]}]

set_property PACKAGE_PIN AC22 [get_ports {fmc_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[4]}]

set_property PACKAGE_PIN AD22 [get_ports {fmc_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[5]}]

set_property PACKAGE_PIN AC24 [get_ports {fmc_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[6]}]

set_property PACKAGE_PIN AD24 [get_ports {fmc_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[7]}]

set_property PACKAGE_PIN AD21 [get_ports {fmc_out[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[8]}]

set_property PACKAGE_PIN AE21 [get_ports {fmc_out[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fmc_out[9]}]
