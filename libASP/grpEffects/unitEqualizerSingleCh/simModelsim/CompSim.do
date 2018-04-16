
vlib ieee_proposed
vmap ieee_proposed ieee_proposed
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -93 -work ieee_proposed ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

###### COMPILE #################
vlib work
vcom -2008 ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom -2008 ../../../grpPackages/pkgEqualizer/src/Equalizer-p.vhd
vcom -2008 ../hdl/EqualizerSingleCh-e.vhd
vcom -2008 ../hdl/EqualizerSingleCh-Rtl-a.vhd
vcom -2008 ../hdl/tbEqualizerSingleCh-Bhv-ea.vhd

###### START SIMULATION ########

set simEndTime "2 ms"

vsim tbEqCh
do fastsim_hack.do
do wave.do $simEndTime

run $simEndTime
