vlib work
vcom ../../../grpPackages/pkgToString/src/tostring_pkg.vhd
vcom ../hdl/ChannelMux-e.vhd
vcom ../hdl/ChannelMux-Rtl-a.vhd
vcom ../hdl/tbChannelMux-Bhv-ea.vhd
vsim work.tbchannelmux
do wave.do
run -all
