onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbflanger/nResetAsync
add wave -noupdate /tbflanger/Clk
add wave -noupdate /tbflanger/Strobe
add wave -noupdate -radix unsigned /tbflanger/SelFlangeLen
add wave -noupdate -color Red -format Analog-Interpolated -height 140 -itemcolor Red -max 4717939.9999999991 -min -8388610.0 -radix sfixed /tbflanger/data_in
add wave -noupdate -color Gold -format Analog-Interpolated -height 140 -itemcolor Gold -max -8742740.0000000056 -min -23185400.0 -radix sfixed /tbflanger/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4243220000 ps} 0}
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
WaveRestoreZoom {0 ps} {12673500 ns}
