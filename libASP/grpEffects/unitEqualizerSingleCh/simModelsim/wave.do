delete wave *
add wave -noupdate /tbEqCh/*
add wave -noupdate -expand /tbEqCh/DUT/R

if {$argc < 1} {puts "#### Simulation end time must be given as a parameter to wave.do" }

WaveRestoreZoom {0 ps} $1
