#----------------------------------*-tcl-*-
onerror {resume}

echo "# WaveRestore"
#WaveRestoreCursors {{start}     {21000 ns} 1} \
#                   {{PwmWidth1} {23000 ns} 1} \
#                   {{InterPwm1} {41000 ns} 1} \
#                   {{PwmWidth2} {44000 ns} 1} \
#                   {{Cursor   } {60500 ns} 0}
WaveRestoreZoom {0 us} $now
