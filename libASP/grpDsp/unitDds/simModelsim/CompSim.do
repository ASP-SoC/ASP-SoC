vlib work
vcom ../hdl/Dds-Rtl-ea.vhd
vcom ../hdl/Dds_tb.vhd
vsim work.dds_tb
do wave.do
run -all
wave zoom full