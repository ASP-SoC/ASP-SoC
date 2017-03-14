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
#Setting Pathes for tools and files
set PathLocalSimDir .
set PathUnitToRoot ../../../..
set PathGlobalSimDir ${PathUnitToRoot}/flw/[file tail [pwd]]

#searching for config.tcl on group level
if [file exists ${PathUnitToRoot}/Config.tcl] then {
    set DoingSynthesis 0
    do ${PathUnitToRoot}/Config.tcl
}
#searching for config.tcl on unit level
if [file exists ../../../Config.tcl] then {
    do ../../../Config.tcl
}
#doing config.tcl in unit
do ${PathLocalSimDir}/../../Config.tcl

#look for testbench
if [info exists tbUnits] then {
	puts "Starting Compile!"
	
	do ${PathGlobalSimDir}/CompileVhdlSource.do
	do ${PathGlobalSimDir}/UnsetVariables.tcl

	# signalize configuration is ok
	set ConfigError 0
} else {
    # look if shell or gui is used
    if [info exists Shell] then {
        puts "Set tbUnits in Config.tcl at least to {}! Configuration Error!"
    } else {
        tk_messageBox -message "Set tbUnits in Config.tcl at least to {}!" -title "Configuration Error" -icon error
    }

	# signalize configuration error
	set ConfigError 1
}
