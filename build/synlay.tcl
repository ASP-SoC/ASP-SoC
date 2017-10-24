# Load Quartus Prime Tcl Project package
package require ::quartus::project

load_package flow

# open project
project_open ../libASP/grpPlatform/unitPlatformHps/synlayQuartus/PlatformHps

# start
execute_flow -compile