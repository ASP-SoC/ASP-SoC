onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /whitenoise_tb/coe_sample_strobe
add wave -noupdate /whitenoise_tb/avs_s0_write
add wave -noupdate /whitenoise_tb/avs_s0_writedata
add wave -noupdate /whitenoise_tb/aso_data
add wave -noupdate /whitenoise_tb/aso_valid
add wave -noupdate -format Analog-Step -height 74 -max 16777090.0 -radix unsigned /whitenoise_tb/DUT/lfsr_state
add wave -noupdate -format Analog-Step -height 74 -max 8388545.0000000019 -min -8387696.0 -radix sfixed /whitenoise_tb/DUT/white_noise
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
WaveRestoreZoom {0 ps} {5605992 ns}
