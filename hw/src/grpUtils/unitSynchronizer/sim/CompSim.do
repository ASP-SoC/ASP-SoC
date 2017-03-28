#----------------------------------*-tcl-*-
if {[info exists ::env(TEMP)]} {
  set worklibdir $env(TEMP)
} else {
  set worklibdir ../../../..
}
vlib      ${worklibdir}/work
vmap work ${worklibdir}/work

set unit Synchronizer

vcom -work work ../../../grpPackages/pkgGlobal/src/Global-p.vhd
vcom -work work ../../../grpUtils/unit${unit}/src/${unit}-e.vhd
vcom -work work ../../../grpUtils/unit${unit}/src/${unit}-Rtl-a.vhd
vcom -work work ../../../grpUtils/unit${unit}/src/tb${unit}-Bhv-ea.vhd

vsim -voptargs=+acc work.tb${unit}(Bhv)

onerror {resume}
catch {do wave-default.do}
catch {do wave.do}
add wave -r /*
log -r /*

run 2000 ns
WaveRestoreZoom {0 us} $now
