onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/add_cnt
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/addr
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/BPS_CNT
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/BPS_CNT9
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/bram
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/clk
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/CLK_FREQ
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/cnt_9b
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/current_state
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/dout
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/key_down
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/rst_n
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/send_data
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/send_en
add wave -noupdate /tb_uart_send_output_1000/u_uart_send1/sw2
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/recv_data
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/recv_done
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/recv_done_d0
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/recv_done_d1
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/recv_done_flag
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/send_data
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/send_en
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/sys_clk
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/sys_rst_n
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/tx_busy
add wave -noupdate /tb_uart_send_output_1000/u_uart_loop/tx_ready
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/clk_cnt
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/CLK_FREQ
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/en_flag
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/sys_clk
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/sys_rst_n
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/tx_cnt
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/tx_data
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/tx_flag
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/UART_BPS
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_din
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_en
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_en_d0
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_en_d1
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_tx_busy
add wave -noupdate /tb_uart_send_output_1000/u_uart_send2/uart_txd
add wave -noupdate /tb_uart_send_output_1000/rx_data
add wave -noupdate /tb_uart_send_output_1000/rx_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69505 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3649536 ns} {3833856 ns}
