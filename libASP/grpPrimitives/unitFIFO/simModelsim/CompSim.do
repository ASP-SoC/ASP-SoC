vlib ieee_proposed
vmap ieee_proposed ieee_proposed
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

vlib work
vcom ../hdl/FIFO-ea.vhd
vcom ../hdl/FIFO_tb.vhd
vsim work.FIFO_tb
catch {do wave.do}
run -all
wave zoom full
