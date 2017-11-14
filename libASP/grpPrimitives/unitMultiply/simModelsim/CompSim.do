vlib work
vcom ../hdl/Multiply-e.vhd
vcom ../hdl/Multiply-Rtl-a.vhd
vcom ../hdl/tbMultiply-Bhv-ea.vhd
vsim work.tbmultiply
do wave.do
run -all
wave zoom full