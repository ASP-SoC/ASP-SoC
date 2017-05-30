onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i2stoavalonst_tb/inReset
add wave -noupdate /i2stoavalonst_tb/iClk
add wave -noupdate /i2stoavalonst_tb/iDAT
add wave -noupdate /i2stoavalonst_tb/iLRC
add wave -noupdate /i2stoavalonst_tb/iBCLK
add wave -noupdate /i2stoavalonst_tb/oLeftData
add wave -noupdate /i2stoavalonst_tb/oLeftValid
add wave -noupdate /i2stoavalonst_tb/oRightData
add wave -noupdate /i2stoavalonst_tb/oRightValid
add wave -noupdate -childformat {{/i2stoavalonst_tb/DUT/R.BitIdx -radix unsigned}} -expand -subitemconfig {/i2stoavalonst_tb/DUT/R.BitIdx {-height 15 -radix unsigned}} /i2stoavalonst_tb/DUT/R
add wave -noupdate /i2stoavalonst_tb/DUT/NxR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {595588235 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1260 us}
