delete wave *
add wave -noupdate /tbequalizersinglech/*
add wave -noupdate -expand /tbequalizersinglech/DUT/R

if {$argc < 1} {puts "#### Simulation end time must be given as a parameter to wave.do" }

WaveRestoreZoom {0 ps} $1
