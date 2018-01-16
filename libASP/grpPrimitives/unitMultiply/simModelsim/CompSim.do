vlib ieee_proposed
vmap ieee_proposed ieee_proposed
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

vlib work
vcom ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl
vcom ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom ../../../grpPackages/pkgSin/sin_4096-p.vhd
vcom ../hdl/Multiply-e.vhd
vcom ../hdl/Multiply-Rtl-a.vhd
vcom ../hdl/tbMultiply-Bhv-ea.vhd
vsim work.tbmultiply
do wave.do
run -all
wave zoom full