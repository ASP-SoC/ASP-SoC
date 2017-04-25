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

echo ## unitStrobeGen
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-e.vhd
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-Rtl-a.vhd

echo ## unitFileReader
myvcom ${Root}/grpUtils/unitFileReader/src/FileReader-e.vhd
myvcom ${Root}/grpUtils/unitFileReader/src/FileReader-Bhv-a.vhd

echo ## unitFileWriter
myvcom ${Root}/grpUtils/unitFileWriter/src/FileWriter-e.vhd
myvcom ${Root}/grpUtils/unitFileWriter/src/FileWriter-Bhv-a.vhd

echo ## unitFileWriter Testbench
myvcom ${Root}/grpUtils/unitFileWriter/src/tbFileWriter-Bhv-ea.vhd
