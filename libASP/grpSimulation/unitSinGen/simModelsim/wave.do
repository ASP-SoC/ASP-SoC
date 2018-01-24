onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /singen_tb/data_valid_o
add wave -noupdate -format Analog-Step -height 74 -max 8388606.9999999981 -min -8388608.0 -radix sfixed /singen_tb/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11095180000 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {20819106 ns}
