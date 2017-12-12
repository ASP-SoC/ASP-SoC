onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbfir/reset
add wave -noupdate /tbfir/DataClk
add wave -noupdate /tbfir/FIR/csi_clk
add wave -noupdate -format Analog-Step -height 74 -max 8388606.9999999981 -min -8388608.0 -radix sfixed /tbfir/asi_data
add wave -noupdate /tbfir/FIR/asi_valid
add wave -noupdate /tbfir/FIR/aso_valid
add wave -noupdate -format Analog-Step -height 74 -max 2097152.0 -min -2097152.0 -radix sfixed /tbfir/aso_data
add wave -noupdate /tbfir/avs_writedata
add wave -noupdate /tbfir/avs_write
add wave -noupdate /tbfir/FIR/avs_s0_write
add wave -noupdate -radix sfixed /tbfir/FIR/Coeff
add wave -noupdate -childformat {{/tbfir/FIR/R.LastFiltered -radix sfixed}} -expand -subitemconfig {/tbfir/FIR/R.LastFiltered {-height 15 -radix sfixed}} /tbfir/FIR/R
add wave -noupdate /tbfir/address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7473420 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 166
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {19723183 ns}
