##The following two properties should be set for every design
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_n]
set_property PACKAGE_PIN H19 [get_ports clk_p]
set_property PACKAGE_PIN G18 [get_ports clk_n]

set_property PACKAGE_PIN AB8  [get_ports diff_clock_rtl_0_clk_p]  ; # PCIE_clk_P
set_property PACKAGE_PIN AB7  [get_ports diff_clock_rtl_0_clk_n]  ; # PCIE_clk_N

#set_input_delay -clock CLKIN -max 10.0 [get_ports reset_rtl_0]
#set_output_delay -clock CLKIN -max 10.0 [get_ports user_lnk_up_0]

#set_property IOSTANDARD DIFF_SSTL15 [get_ports diff_clock_rtl_0_clk_p]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports diff_clock_rtl_0_clk_n]
#set_property PACKAGE_PIN H19 [get_ports diff_clock_rtl_0_clk_p]
#set_property PACKAGE_PIN G18 [get_ports diff_clock_rtl_0_clk_n]


set_property -dict {PACKAGE_PIN AR37 IOSTANDARD LVCMOS18} [get_ports user_lnk_up_0]

set_property -dict {PACKAGE_PIN AV35 IOSTANDARD LVCMOS18} [get_ports reset_rtl_0]

#set_property -dict {PACKAGE_PIN AV30 IOSTANDARD LVCMOS18} [get_ports control_source]

# ============================================================================
# PCIe Lane 0 (通道0) - Quad 115
# ============================================================================
# 接收通道0 (PCIE_RX0)
set_property PACKAGE_PIN Y4  [get_ports {pcie_7x_mgt_rtl_0_rxp[0]}]  ; # PCIE_RX0_P
set_property PACKAGE_PIN Y3  [get_ports {pcie_7x_mgt_rtl_0_rxn[0]}]  ; # PCIE_RX0_N

# 发送通道0 (PCIE_TX0)
set_property PACKAGE_PIN W2  [get_ports {pcie_7x_mgt_rtl_0_txp[0]}]  ; # PCIE_TX0_P
set_property PACKAGE_PIN W1  [get_ports {pcie_7x_mgt_rtl_0_txn[0]}]  ; # PCIE_TX0_N

# ============================================================================
# PCIe Lane 1 (通道1) - Quad 115
# ============================================================================
# 接收通道1 (PCIE_RX1)
set_property PACKAGE_PIN AA6 [get_ports {pcie_7x_mgt_rtl_0_rxp[1]}]  ; # PCIE_RX1_P
set_property PACKAGE_PIN AA5 [get_ports {pcie_7x_mgt_rtl_0_rxn[1]}]  ; # PCIE_RX1_N

# 发送通道1 (PCIE_TX1)
set_property PACKAGE_PIN AA2 [get_ports {pcie_7x_mgt_rtl_0_txp[1]}]  ; # PCIE_TX1_P
set_property PACKAGE_PIN AA1 [get_ports {pcie_7x_mgt_rtl_0_txn[1]}]  ; # PCIE_TX1_N

# ============================================================================
# PCIe Lane 2 (通道2) - Quad 115
# ============================================================================
# 接收通道2 (PCIE_RX2)
set_property PACKAGE_PIN AB4 [get_ports {pcie_7x_mgt_rtl_0_rxp[2]}]  ; # PCIE_RX2_P
set_property PACKAGE_PIN AB3 [get_ports {pcie_7x_mgt_rtl_0_rxn[2]}]  ; # PCIE_RX2_N

# 发送通道2 (PCIE_TX2)
set_property PACKAGE_PIN AC2 [get_ports {pcie_7x_mgt_rtl_0_txp[2]}]  ; # PCIE_TX2_P
set_property PACKAGE_PIN AC1 [get_ports {pcie_7x_mgt_rtl_0_txn[2]}]  ; # PCIE_TX2_N

# ============================================================================
# PCIe Lane 3 (通道3) - Quad 115
# ============================================================================
# 接收通道3 (PCIE_RX3)
set_property PACKAGE_PIN AC6 [get_ports {pcie_7x_mgt_rtl_0_rxp[3]}]  ; # PCIE_RX3_P
set_property PACKAGE_PIN AC5 [get_ports {pcie_7x_mgt_rtl_0_rxn[3]}]  ; # PCIE_RX3_N

# 发送通道3 (PCIE_TX3)
set_property PACKAGE_PIN AE2 [get_ports {pcie_7x_mgt_rtl_0_txp[3]}]  ; # PCIE_TX3_P
set_property PACKAGE_PIN AE1 [get_ports {pcie_7x_mgt_rtl_0_txn[3]}]  ; # PCIE_TX3_N

## ============================================================================
## PCIe Lane 4 (通道4) - Quad 114
## ============================================================================
## 接收通道4 (PCIE_RX4)
#set_property PACKAGE_PIN AD4 [get_ports {pcie_7x_mgt_rtl_0_rxp[4]}]  ; # PCIE_RX4_P
#set_property PACKAGE_PIN AD3 [get_ports {pcie_7x_mgt_rtl_0_rxn[4]}]  ; # PCIE_RX4_N
#
## 发送通道4 (PCIE_TX4)
#set_property PACKAGE_PIN AG2 [get_ports {pcie_7x_mgt_rtl_0_txp[4]}]  ; # PCIE_TX4_P
#set_property PACKAGE_PIN AG1 [get_ports {pcie_7x_mgt_rtl_0_txn[4]}]  ; # PCIE_TX4_N
#
## ============================================================================
## PCIe Lane 5 (通道5) - Quad 114
## ============================================================================
## 接收通道5 (PCIE_RX5)
#set_property PACKAGE_PIN AE6 [get_ports {pcie_7x_mgt_rtl_0_rxp[5]}]  ; # PCIE_RX5_P
#set_property PACKAGE_PIN AE5 [get_ports {pcie_7x_mgt_rtl_0_rxn[5]}]  ; # PCIE_RX5_N
#
## 发送通道5 (PCIE_TX5)
#set_property PACKAGE_PIN AH4 [get_ports {pcie_7x_mgt_rtl_0_txp[5]}]  ; # PCIE_TX5_P
#set_property PACKAGE_PIN AH3 [get_ports {pcie_7x_mgt_rtl_0_txn[5]}]  ; # PCIE_TX5_N
#
## ============================================================================
## PCIe Lane 6 (通道6) - Quad 114
## ============================================================================
## 接收通道6 (PCIE_RX6)
#set_property PACKAGE_PIN AF4 [get_ports {pcie_7x_mgt_rtl_0_rxp[6]}]  ; # PCIE_RX6_P
#set_property PACKAGE_PIN AF3 [get_ports {pcie_7x_mgt_rtl_0_rxn[6]}]  ; # PCIE_RX6_N
#
## 发送通道6 (PCIE_TX6)
#set_property PACKAGE_PIN AJ2 [get_ports {pcie_7x_mgt_rtl_0_txp[6]}]  ; # PCIE_TX6_P
#set_property PACKAGE_PIN AJ1 [get_ports {pcie_7x_mgt_rtl_0_txn[6]}]  ; # PCIE_TX6_N
#
## ============================================================================
## PCIe Lane 7 (通道7) - Quad 114
## ============================================================================
## 接收通道7 (PCIE_RX7)
#set_property PACKAGE_PIN AG6 [get_ports {pcie_7x_mgt_rtl_0_rxp[7]}]  ; # PCIE_RX7_P
#set_property PACKAGE_PIN AG5 [get_ports {pcie_7x_mgt_rtl_0_rxn[7]}]  ; # PCIE_RX7_N
#
## 发送通道7 (PCIE_TX7)
#set_property PACKAGE_PIN AK4 [get_ports {pcie_7x_mgt_rtl_0_txp[7]}]  ; # PCIE_TX7_P
#set_property PACKAGE_PIN AK3 [get_ports {pcie_7x_mgt_rtl_0_txn[7]}]  ; # PCIE_TX7_N