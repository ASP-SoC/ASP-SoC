vlib ieee_proposed
vmap ieee_proposed ieee_proposed
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

vlib work
vcom ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom ../hdl/SinGen-Bhv-ea.vhd
vcom ../hdl/SinGen_tb.vhd
vsim work.SinGen_tb
catch {do wave.do}
run -all
wave zoom full
