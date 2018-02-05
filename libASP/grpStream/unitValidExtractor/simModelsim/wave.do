onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /validextractor_tb/csi_clk
add wave -noupdate /validextractor_tb/rsi_reset_n
add wave -noupdate /validextractor_tb/asi_valid
add wave -noupdate /validextractor_tb/asi_data
add wave -noupdate /validextractor_tb/aso_valid
add wave -noupdate /validextractor_tb/aso_data
add wave -noupdate /validextractor_tb/coe_sample_strobe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
