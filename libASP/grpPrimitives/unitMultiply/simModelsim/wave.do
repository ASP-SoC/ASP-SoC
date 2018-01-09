onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbmultiply/csi_clk
add wave -noupdate /tbmultiply/rsi_reset_n
add wave -noupdate /tbmultiply/avs_s0_write
add wave -noupdate /tbmultiply/avs_s0_address
add wave -noupdate /tbmultiply/avs_s0_writedata
add wave -noupdate -max 4194370.0 -min 4194300.0 -radix sfixed /tbmultiply/DUT/left_fact
add wave -noupdate -max 2097220.0 -min 2097150.0 -radix sfixed /tbmultiply/DUT/right_fact
add wave -noupdate -format Analog-Step -height 74 -max 8388606.0 -min -8388606.0 -radix sfixed /tbmultiply/audio_data
add wave -noupdate -format Analog-Step -height 74 -max 4194303.0 -min -4194303.0 -radix sfixed /tbmultiply/left_data
add wave -noupdate -format Analog-Step -height 74 -max 1048576.0 -radix sfixed /tbmultiply/right_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {876020000 ps} 0}
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
WaveRestoreZoom {872816725 ps} {879223275 ps}
