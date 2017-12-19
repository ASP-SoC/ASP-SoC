vlib ieee_proposed
vmap ieee_proposed ieee_proposed
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

vlib work
vcom ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl
vcom ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom ../../../grpPackages/pkgSin/sin_4096-p.vhd
vcom ../hdl/Dds-e.vhd
vcom ../hdl/Dds-Rtl-a.vhd
vcom ../hdl/Dds_tb.vhd
vsim work.dds_tb
do wave.do
run -all
wave zoom full