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

echo ## ShiftRegRam
myvcom ${Root}/grpUtils/unitShiftRegRam/src/ShiftRegRam-e.vhd
myvcom ${Root}/grpUtils/unitShiftRegRam/src/ShiftRegRam-Rtl-a.vhd

echo ## ShiftRegRam Testbench
myvcom ${Root}/grpUtils/unitShiftRegRam/src/tbShiftRegRam.vhd

