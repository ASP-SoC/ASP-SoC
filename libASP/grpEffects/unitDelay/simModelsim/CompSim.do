vlib work

vcom -2008 ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom -2008 ../hdl/Delay-e.vhd
vcom -2008 ../hdl/Delay-Rtl-a.vhd
vcom -2008 ../hdl/Delay_tb.vhd

vsim Delay_tb


do wave.do

run 100 ms
