onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /addchannels_tb/DUT/config
add wave -noupdate -format Analog-Step -height 74 -max 4194304.0 -radix sfixed /addchannels_tb/DUT/ch_a
add wave -noupdate -format Analog-Step -height 74 -max 8388606.0 -min -8388606.0 -radix sfixed /addchannels_tb/DUT/ch_b
add wave -noupdate -format Analog-Step -height 74 -max 6291454.9999999991 -min -8388606.0 -radix sfixed /addchannels_tb/result
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
WaveRestoreZoom {0 ps} {6479844 ns}
