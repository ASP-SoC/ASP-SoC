onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /shiftreg_tb/nResetAsync
add wave -noupdate /shiftreg_tb/Clk
add wave -noupdate -radix unsigned /shiftreg_tb/InputData
add wave -noupdate -itemcolor Red -radix unsigned /shiftreg_tb/SelOutReg
add wave -noupdate -itemcolor Gold -radix unsigned /shiftreg_tb/OutputData
add wave -noupdate /shiftreg_tb/cRegLength
add wave -noupdate /shiftreg_tb/cShiftRegLength
add wave -noupdate /shiftreg_tb/DUT/gRegLength
add wave -noupdate /shiftreg_tb/DUT/gShiftRegLength
add wave -noupdate /shiftreg_tb/DUT/inResetAsync
add wave -noupdate /shiftreg_tb/DUT/iClk
add wave -noupdate -radix unsigned /shiftreg_tb/DUT/iData
add wave -noupdate -radix unsigned /shiftreg_tb/DUT/iSelOutReg
add wave -noupdate -radix unsigned /shiftreg_tb/DUT/oData
add wave -noupdate -divider {Shift Register}
add wave -noupdate -radix unsigned -childformat {{/shiftreg_tb/DUT/ShiftReg(0) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(1) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(2) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(3) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(4) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(5) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(6) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(7) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(8) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(9) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(10) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(11) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(12) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(13) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(14) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(15) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(16) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(17) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(18) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(19) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(20) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(21) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(22) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(23) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(24) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(25) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(26) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(27) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(28) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(29) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(30) -radix unsigned} {/shiftreg_tb/DUT/ShiftReg(31) -radix unsigned}} -expand -subitemconfig {/shiftreg_tb/DUT/ShiftReg(0) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(1) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(2) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(3) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(4) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(5) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(6) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(7) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(8) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(9) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(10) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(11) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(12) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(13) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(14) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(15) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(16) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(17) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(18) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(19) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(20) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(21) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(22) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(23) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(24) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(25) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(26) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(27) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(28) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(29) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(30) {-radix unsigned} /shiftreg_tb/DUT/ShiftReg(31) {-radix unsigned}} /shiftreg_tb/DUT/ShiftReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
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
WaveRestoreZoom {0 ps} {574880 ps}
