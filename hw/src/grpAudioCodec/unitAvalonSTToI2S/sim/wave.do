onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /avalonsttoi2s_tb/iClk
add wave -noupdate /avalonsttoi2s_tb/inReset
add wave -noupdate /avalonsttoi2s_tb/iLRC
add wave -noupdate /avalonsttoi2s_tb/iBCLK
add wave -noupdate /avalonsttoi2s_tb/oDAT
add wave -noupdate /avalonsttoi2s_tb/iLeftData
add wave -noupdate /avalonsttoi2s_tb/iLeftValid
add wave -noupdate /avalonsttoi2s_tb/iRightData
add wave -noupdate /avalonsttoi2s_tb/iRightValid
add wave -noupdate -childformat {{/avalonsttoi2s_tb/DUT/R.BitIdx -radix unsigned}} -expand -subitemconfig {/avalonsttoi2s_tb/DUT/R.BitIdx {-height 15 -radix unsigned}} /avalonsttoi2s_tb/DUT/R
add wave -noupdate /avalonsttoi2s_tb/DUT/NxR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {800060000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
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
WaveRestoreZoom {0 ps} {1680 us}
