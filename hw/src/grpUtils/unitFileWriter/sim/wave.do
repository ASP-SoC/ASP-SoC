onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbfilewriter/Clk
add wave -noupdate /tbfilewriter/Strobe
add wave -noupdate /tbfilewriter/nReset
add wave -noupdate -format Analog-Step -height 85 -max 20.0 /tbfilewriter/DataRead
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor   } {210000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 175
configure wave -valuecolwidth 102
configure wave -justifyvalue right
configure wave -signalnamewidth 2
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
WaveRestoreZoom {0 ps} {11830 ns}
