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

echo ## ShiftReg
myvcom ${Root}/grpAudioFlanging/unitShiftReg/src/ShiftReg-e.vhd
myvcom ${Root}/grpAudioFlanging/unitShiftReg/src/ShiftReg-Rtl-a.vhd

echo ## ShiftReg Testbench
myvcom ${Root}/grpAudioFlanging/unitShiftReg/src/ShiftReg_tb.vhd

