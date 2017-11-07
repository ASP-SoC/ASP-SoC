# Load Quartus Prime Tcl Project package
package require ::quartus::project

load_package flow

# open project
project_open PlatformHps

# start
execute_flow -compile