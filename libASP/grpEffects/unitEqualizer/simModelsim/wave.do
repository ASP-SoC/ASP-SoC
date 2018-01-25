delete wave *
add wave -noupdate /tbequalizer/*
#add wave -noupdate -expand /tbequalizer/DUT/R

if {$argc < 1} {puts "#### Simulation end time must be given as a parameter to wave.do" }

WaveRestoreZoom {0 ps} $1
