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
    vcom -93 -novopt -quiet ${filename}
  } else {
    puts "## WARNING: File not found: ${filename}"
  }
}

#-------------------------------------------
echo ## pkgGlobal
myvcom ${Root}/grpPackages/pkgGlobal/src/Global-p.vhd

echo ## unitShiftReg
myvcom ${Root}/grpUtils/unitShiftReg/src/ShiftReg-e.vhd
myvcom ${Root}/grpUtils/unitShiftReg/src/ShiftReg-Rtl-a.vhd

echo ## unitStrobeGen
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-e.vhd
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-Rtl-a.vhd

echo ## unitFileReader
myvcom ${Root}/grpUtils/unitFileReader/src/FileReader-e.vhd
myvcom ${Root}/grpUtils/unitFileReader/src/FileReader-Bhv-a.vhd

echo ## unitFIRAverage
myvcom ${Root}/grpFilter/unitFIRAverage/src/FIRAverage-e.vhd
myvcom ${Root}/grpFilter/unitFIRAverage/src/FIRAverage-Rtl-a.vhd

echo ## unitFIRAverage Testbench
myvcom ${Root}/grpFilter/unitFIRAverage/src/tbFIRAverage-Bhv-ea.vhd
