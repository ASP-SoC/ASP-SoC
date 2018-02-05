onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_tb/Clk
add wave -noupdate /fifo_tb/rst_i
add wave -noupdate /fifo_tb/wr_i
add wave -noupdate /fifo_tb/rd_i
add wave -noupdate -radix binary /fifo_tb/wr_data_i
add wave -noupdate -radix binary /fifo_tb/rd_data_o
add wave -noupdate /fifo_tb/clear_i
add wave -noupdate -radix unsigned /fifo_tb/space_o
add wave -noupdate -expand /fifo_tb/DUT/memory
add wave -noupdate -radix unsigned /fifo_tb/DUT/rd_ptr
add wave -noupdate -radix unsigned /fifo_tb/DUT/wr_ptr
add wave -noupdate /fifo_tb/empty_o
add wave -noupdate /fifo_tb/full_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {88247498 ps}
