#----------------------------------*-tcl-*-
catch {do InitLib.do}

# set Root as relativ path ./src/grp<aGROUP>/unit<aUNIT>/sim/
if {![info exists Root]} {
  set Root ../../..
}

#-------------------------------------------
proc myvcom {filename} {
  if {[file exists ${filename}] == 1} {
    puts "## vcom $filename"
    vcom -2008 -novopt -quiet ${filename}
  } else {
    puts "## WARNING: File not found: ${filename}"
  }
}

#-------------------------------------------
echo ## ieee_proposed
vcom -work ieee_proposed ${Root}/grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
vcom -work ieee_proposed ${Root}/grpPackages/pkgFixed/src/fixed_pkg_c.vhdl

echo ## pkgGlobal
myvcom ${Root}/grpPackages/pkgGlobal/src/Global-p.vhd

#echo ## StrobGen
#myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-e.vhd
#myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-Rtl-a.vhd

echo ## SineGen
myvcom ${Root}/grpFilter/unitFIR/hdl/unitSineGen.vhd

echo ## FIR
myvcom ${Root}/grpFilter/unitFIR/hdl/pkgFIR.vhd
myvcom ${Root}/grpFilter/unitFIR/hdl/unitFIR-e.vhd
myvcom ${Root}/grpFilter/unitFIR/hdl/unitFIR-Rtl-a.vhd

echo ## FIR Testbench
myvcom ${Root}/grpFilter/unitFIR/hdl/tbFIR-Bhv-ea.vhd
