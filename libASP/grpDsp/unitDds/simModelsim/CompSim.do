vlib work
vcom ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom ../../../grpPackages/pkgSin/sin_4096-p.vhd
vcom ../hdl/Dds-e.vhd
vcom ../hdl/Dds-Rtl-a.vhd
vcom ../hdl/Dds_tb.vhd
vsim work.dds_tb
do wave.do
run -all
wave zoom full