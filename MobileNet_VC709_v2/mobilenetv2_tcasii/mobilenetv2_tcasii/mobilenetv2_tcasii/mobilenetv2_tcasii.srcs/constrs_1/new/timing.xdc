create_clock -period 5.000 -name clk [get_ports sys_clk_p]

create_waiver -type METHODOLOGY -id {SYNTH-9} -user "11351" -desc "small size multiplier" -objects [get_cells { BRAM_DMA0/bram_base_vert_block_addr_00__1_i_1 }] -strings { "8x2" } -timestamp "Mon Nov 15 07:01:52 GMT 2021"
create_waiver -type METHODOLOGY -id {SYNTH-9} -user "11351" -desc "small size multiplier" -objects [get_cells { BRAM_DMA0/bram_base_vert_block_addr_00__1_i_2 }] -strings { "8x2" } -timestamp "Mon Nov 15 07:01:52 GMT 2021"
create_waiver -type METHODOLOGY -id {SYNTH-9} -user "11351" -desc "small size multiplier" -objects [get_cells { BRAM_DMA0/bram_base_vert_block_addr_00__1_i_3 }] -strings { "8x2" } -timestamp "Mon Nov 15 07:01:52 GMT 2021"
