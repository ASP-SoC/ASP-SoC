#-----------------------------------------------------------------------------------
#Copyright (C) 2005 Christian Kitzler, Simon Lasselsberger, Markus Pfaff
# christian.kitzler@fh-hagenberg.at
# simon.lasselsberger@fh-hagenberg.at
# markus.pfaff@fh-hagenberg.at
#
#This file is part of the fhlow - scripting environment Library.
#
#The fhlow - scripting environment Library is free software; you can redistribute it
#and/or modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2 of the
#License, or (at your option) any later version.
#
#fhlow - scripting environment is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with fhlow - scripting environment; if not, write to the Free Software
#Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#-----------------------------------------------------------------------------------

puts "Begin script for Modelsim."
#setting the paths for files and tools
set PathLocalSimDir .
set PathUnitToRoot ../../../..
set PathGlobalSimDir ${PathUnitToRoot}/flw/[file tail [pwd]]

# compile
do ${PathGlobalSimDir}/Comp.do

# look if we had an error on compiling with current configuration
if [expr $ConfigError] then {
	do ${PathGlobalSimDir}/UnsetVariables.tcl
} else {
# compiling was fine
	do ${PathLocalSimDir}/../../Config.tcl		
	if [expr $tbSuccess] then {
        if [expr ! [info exists UnitName]] then {
            set UnitName IdoNotExist
        }
        if [file exists ${PathLocalSimDir}/${UnitName}.sdf] then {
            do ${PathLocalSimDir}/PlSim.do
        } else {
            ## simulate either with custom Wave.do 
            ## or with default Wave.do	        
            if [file exists ${PathLocalSimDir}/Wave.do] then {
                vsim work.tb${tbName}
                    do ${PathLocalSimDir}/Wave.do
                set DurationBegin [clock seconds]
                do ${PathGlobalSimDir}/RunSim.do
            } else {
                vsim work.tb${tbName}
                do ${PathGlobalSimDir}/Wave.do
                set DurationBegin [clock seconds]
                do ${PathGlobalSimDir}/RunSim.do
            }	       	
            set DurationEnd [clock seconds]
            set Duration [expr ${DurationEnd} - ${DurationBegin}]
            if [info exists Shell] then {
            puts "Duration of Simulation: ${Duration} sec"
            } else {		
                # Display Simulation Duration in a MessageBox
                tk_messageBox -message "${Duration} sec                                     " \
                    -title "Duration of Simulation" 
            }			
        }	
    } else {
        # tell user that something went wrong with his testbench
        puts ""
        puts "No Testbench was specified!"
        puts "Check Config.tcl!"
        puts "Can't simulate!"
        puts ""
        if [info exists Shell] then {
        puts "Specified Testbench was not found!"
        puts "Check Config.tcl!" 
        puts "Can't Simulate!"
        } else {
            tk_messageBox -message "Specified Testbench was not found!\nCheck Config.tcl!\nCan't Simulate!" \
                -title "Testbench Warning" -icon warning
        }
    }
    # unset tcl variables
    do $PathGlobalSimDir/UnsetVariables.tcl
}


