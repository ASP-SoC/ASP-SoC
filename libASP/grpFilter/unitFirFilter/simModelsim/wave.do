onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /firfilter_tb/DUT/enable
add wave -noupdate -format Analog-Step -height 74 -max 8388610.0 -min -8381680.0 -radix sfixed /firfilter_tb/data_in
add wave -noupdate -format Analog-Step -height 74 -max 8388610.0 -min -8381680.0 -radix sfixed /firfilter_tb/data_out
add wave -noupdate -radix sfixed -childformat {{/firfilter_tb/DUT/CoeffRam(0) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(1) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(2) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(3) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(4) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(5) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(6) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(7) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(8) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(9) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(10) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(11) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(12) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(13) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(14) -radix sfixed} {/firfilter_tb/DUT/CoeffRam(15) -radix sfixed}} -expand -subitemconfig {/firfilter_tb/DUT/CoeffRam(0) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(1) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(2) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(3) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(4) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(5) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(6) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(7) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(8) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(9) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(10) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(11) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(12) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(13) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(14) {-radix sfixed} /firfilter_tb/DUT/CoeffRam(15) {-radix sfixed}} /firfilter_tb/DUT/CoeffRam
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {347698 ps} 0}
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
WaveRestoreZoom {0 ps} {4100628 ns}
