vlib work
vcom ../hdl/ValidExtractor-ea.vhd
vcom ../hdl/ValidExtractor_tb.vhd
vsim work.ValidExtractor_tb
do wave.do
run -all
wave zoom full