onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mmtost_tb/csi_clk
add wave -noupdate /mmtost_tb/rsi_reset_n
add wave -noupdate /mmtost_tb/irs_irq
add wave -noupdate -divider MM
add wave -noupdate /mmtost_tb/avs_s0_chipselect
add wave -noupdate /mmtost_tb/avs_s0_write
add wave -noupdate /mmtost_tb/avs_s0_read
add wave -noupdate /mmtost_tb/avs_s0_address
add wave -noupdate /mmtost_tb/avs_s0_writedata
add wave -noupdate /mmtost_tb/avs_s0_readdata
add wave -noupdate -divider ST
add wave -noupdate /mmtost_tb/asi_left_valid
add wave -noupdate /mmtost_tb/asi_left_data
add wave -noupdate /mmtost_tb/asi_right_valid
add wave -noupdate /mmtost_tb/asi_right_data
add wave -noupdate /mmtost_tb/aso_left_valid
add wave -noupdate /mmtost_tb/aso_left_data
add wave -noupdate /mmtost_tb/aso_right_valid
add wave -noupdate /mmtost_tb/aso_right_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {4490083500 ps}
