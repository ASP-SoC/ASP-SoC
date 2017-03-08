onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbflanger/nRstAsync
add wave -noupdate /tbflanger/Strobe
add wave -noupdate -format Analog-Step -height 84 -max 4717940.0000000009 -min -8388610.0 -radix sfixed /tbflanger/data_in
add wave -noupdate -format Analog-Step -height 84 -max 4713410.0000000009 -min -3620520.0 -radix sfixed /tbflanger/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
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
WaveRestoreZoom {0 ps} {20145933014 ps}
