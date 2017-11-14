onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /delay_tb/csi_clk
add wave -noupdate /delay_tb/rsi_reset_n
add wave -noupdate /delay_tb/avs_s0_write
add wave -noupdate /delay_tb/avs_s0_writedata
add wave -noupdate /delay_tb/asi_data
add wave -noupdate /delay_tb/asi_valid
add wave -noupdate /delay_tb/aso_data
add wave -noupdate /delay_tb/aso_valid
add wave -noupdate /delay_tb/DUT/Offset
add wave -noupdate /delay_tb/DUT/Address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
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
WaveRestoreZoom {0 ps} {746901 ps}
