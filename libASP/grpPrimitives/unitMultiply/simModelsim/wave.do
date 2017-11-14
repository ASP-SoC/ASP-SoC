onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbmultiply/csi_clk
add wave -noupdate /tbmultiply/rsi_reset_n
add wave -noupdate /tbmultiply/avs_s0_write
add wave -noupdate /tbmultiply/avs_s0_address
add wave -noupdate /tbmultiply/avs_s0_writedata
add wave -noupdate /tbmultiply/asi_left_data
add wave -noupdate /tbmultiply/asi_left_valid
add wave -noupdate /tbmultiply/asi_right_data
add wave -noupdate /tbmultiply/asi_right_valid
add wave -noupdate /tbmultiply/aso_left_data
add wave -noupdate /tbmultiply/aso_left_valid
add wave -noupdate /tbmultiply/aso_right_data
add wave -noupdate /tbmultiply/aso_right_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
