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

echo ## StrobGen
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-e.vhd
myvcom ${Root}/grpStrobesAndClocks/unitStrobeGen/src/StrobeGen-Rtl-a.vhd

echo ## PwmGen Pack
myvcom ${Root}/grpPwmGen/pkgPwmGenPack/src/PwmGenPack-p.vhd

echo ## PwmGen Datapath
myvcom ${Root}/grpPwmGen/unitPwmGenDatapath/src/PwmGenDatapath-e.vhd
myvcom ${Root}/grpPwmGen/unitPwmGenDatapath/src/PwmGenDatapath-Rtl-a.vhd

echo ## PwmGen Ctrlpath
myvcom ${Root}/grpPwmGen/unitPwmGenCtrlpath/src/PwmGenCtrlpath-e.vhd
myvcom ${Root}/grpPwmGen/unitPwmGenCtrlpath/src/PwmGenCtrlpath-Bhv-a.vhd
myvcom ${Root}/grpPwmGen/unitPwmGenCtrlpath/src/PwmGenCtrlpath-Mealy-a.vhd
myvcom ${Root}/grpPwmGen/unitPwmGenCtrlpath/src/PwmGenCtrlpath-Moore-a.vhd

echo ## PwmGen
myvcom ${Root}/grpPwmGen/unitPwmGen/src/PwmGen-e.vhd
myvcom ${Root}/grpPwmGen/unitPwmGen/src/PwmGen-Rtl-a.vhd

echo ## PwnGen Testbench
myvcom ${Root}/grpPwmGen/unitPwmGen/src/tbPwmGen-Bhv-ea.vhd
