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



## Delete the complete library: We do not want to simulate wrong versions and
## the simulator should notify us if we forgot some package or a unit.
file delete -force ${PathGlobalSimDir}/work
vlib ${PathGlobalSimDir}/work
vmap work ${PathGlobalSimDir}/work

# compiling packages
if [info exists Packages] then {
    # Analyze all packages.
    foreach {Package} $Packages {
        set GrpName [lindex ${Package} 0]
        set PackageName [lindex ${Package} 1]
        puts "Compiling package for grp$GrpName, pkg$PackageName."
        vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/pkg${PackageName}/src/${PackageName}-p.vhd
    }
}

# compiling entities and architectures
if [info exists Units] then {    
     
    # Analyze all entities before analyzing the architectures allows any
    # ordering of units in the unit list $Units.
    foreach {Unit} $Units {
        set GrpName [lindex ${Unit} 0]
        set UnitName [lindex ${Unit} 1]
        set EntityName $UnitName
    	# compiling interface packages for unit if it exists
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/If${EntityName}-p.vhd] then {
            puts "Compiling interface package for grp$GrpName, unit$UnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/If${EntityName}-p.vhd
        }
	    # compiling entity if exists
    	if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-e.vhd] then {
	    	puts "Compiling entity for grp$GrpName, unit$UnitName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-e.vhd
	    } 		
    }
    # Analyze all architectures after all entities are analyzed.
    foreach {Unit} $Units {
        set GrpName [lindex ${Unit} 0]
        set UnitName [lindex ${Unit} 1]
        set EntityName [lindex ${Unit} 1]
        set ArchitectureName [lindex ${Unit} 2]
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-${ArchitectureName}-ea.vhd] then {
            # if file for entity and architecture exists, compile it
            puts "Compiling entity-architecture for grp$GrpName, unit$UnitName, $ArchitectureName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-${ArchitectureName}-ea.vhd
        } elseif [file exists ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-${ArchitectureName}-eac.vhd] then {
            # if entity architecture configuration exists, compile it
            puts "Compiling entity-architecture for grp$GrpName, unit$UnitName, $ArchitectureName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-${ArchitectureName}-eac.vhd
        } else {
            # compile architecture
            puts "Compiling architecture $ArchitectureName for grp$GrpName, unit$UnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/${EntityName}-${ArchitectureName}-a.vhd
        }
    }
    # Analyze all configurations - if they exist - after all architectures are analyzed.
    foreach {Unit} $Units {
        set GrpName [lindex ${Unit} 0]
        set UnitName [lindex ${Unit} 1]
        set EntityName $UnitName
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/If${EntityName}-c.vhd] then {
            puts "Compiling configuration $ArchitectureName for grp$GrpName, unit$UnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${UnitName}/src/If${EntityName}-${ArchitectureName}-c.vhd
        }
    }	
}

# compile behavioral units
if [info exists BhvUnits] then {
    # Testbenches
    # Analyze all entities before analyzing the architectures allows any
    # ordering of units in the unit list $BhvUnits.
    foreach {BhvUnit} $BhvUnits {
        set GrpName [lindex ${BhvUnit} 0]
        set BhvUnitName [lindex ${BhvUnit} 1]
        set BhvEntityName $BhvUnitName
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/If${BhvEntityName}-p.vhd] then {
            puts "Compiling interface package for grp$GrpName, unit$BhvUnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/If${BhvEntityName}-p.vhd
        }
	    if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-e.vhd] then {
        	puts "Compiling entity $BhvEntityName of behave for grp$GrpName, unit$BhvUnitName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-e.vhd
    	}
        set BhvName $BhvUnitName
    }
    # Analyze all architectures after all entities are analyzed.
    foreach {BhvUnit} $BhvUnits {
        set GrpName [lindex ${BhvUnit} 0]
        set BhvUnitName [lindex ${BhvUnit} 1]
        set BhvEntityName [lindex ${BhvUnit} 1]
        set BhvArchitectureName [lindex ${BhvUnit} 2]

	    if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-${BhvArchitectureName}-ea.vhd] then {
		    puts "Compiling entity-architecture for grp$GrpName, unit$BhvUnitName, $BhvArchitectureName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-${BhvArchitectureName}-ea.vhd
	    } elseif [file exists ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-${BhvArchitectureName}-eac.vhd] then {
		    puts "Compiling entity-architecture for grp$GrpName, unit$BhvUnitName, $BhvArchitectureName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-${BhvArchitectureName}-eac.vhd
	    } else {
        	puts "Compiling architecture $BhvArchitectureName for grp$GrpName, unit$BhvUnitName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/${BhvEntityName}-${BhvArchitectureName}-a.vhd
	    }
    }
    # Analyze all configurations - if they exist - after all architectures are analyzed.
    foreach {BhvUnit} $BhvUnits {
        set GrpName [lindex ${BhvUnit} 0]
        set BhvUnitName [lindex ${BhvUnit} 1]
        set BhvEntityName $BhvUnitName
        set BhvArchitectureName [lindex ${BhvUnit} 2]
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/If${BhvEntityName}-c.vhd] then {
            puts "Compiling configuration $BhvArchitectureName of behave for grp$GrpName, unit$BhvUnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${BhvUnitName}/src/If${BhvEntityName}-${BhvArchitectureName}-c.vhd
        }
    }
}

# compile testbenches
if [info exists tbUnits] then {
    # Testbenches
    # Analyze all entities before analyzing the architectures allows any
    # ordering of units in the unit list $tbUnits.
    foreach {tbUnit} $tbUnits {
        set GrpName [lindex ${tbUnit} 0]
        set tbUnitName [lindex ${tbUnit} 1]
        set tbEntityName $tbUnitName
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-e.vhd] then {
           puts "Compiling entity $tbEntityName of testbench for grp$GrpName, unit$tbUnitName."
           vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-e.vhd
        } 
	    set tbName $tbUnitName
    }
    # Analyze all architectures after all entities are analyzed.
    foreach {tbUnit} $tbUnits {
        set GrpName [lindex ${tbUnit} 0]
        set tbUnitName [lindex ${tbUnit} 1]
        set tbEntityName [lindex ${tbUnit} 1]
        set tbArchitectureName [lindex ${tbUnit} 2]

    	set tbSuccess 0
        
	    if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-ea.vhd] then {
		    puts "Compiling entity-architecture for grp$GrpName, unit$tbUnitName, $tbArchitectureName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-ea.vhd
		    set tbSuccess 1
	    } elseif [file exists ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-eac.vhd] then {
		    puts "Compiling entity-architecture for grp$GrpName, unit$tbUnitName, $tbArchitectureName."
        	vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-eac.vhd
		    set tbSuccess 1
	    } else {
		    if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-a.vhd] then {
           		puts "Compiling architecture $tbArchitectureName of testbench for grp$GrpName, unit$tbUnitName."
          		vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/tb${tbEntityName}-${tbArchitectureName}-a.vhd
			    set tbSuccess 1
        	} else {
    			# signalize user that testbench was not found
	    		if [info exists Shell] then {
	   	    		puts ""
	   		    	puts "Specified Testbench was not found!"
	   			    puts "Check Config.tcl!"
    	   			puts ""
	    			set tbSuccess 0	
		    	} else {
			    	puts ""
	   			    puts "Specified Testbench was not found!"
    	   			puts "Check Config.tcl!"
	       			puts ""
		    		tk_messageBox -message "No Architecture found for your testbench!\nCheck Config.tcl!" \
			    		-title "Testbench Warning" -icon warning
				    set tbSuccess 0	
			    }
           	}
        }
    }
    # Analyze all configurations - if they exist - after all architectures are analyzed.
    foreach {tbUnit} $tbUnits {
        set GrpName [lindex ${tbUnit} 0]
        set tbUnitName [lindex ${tbUnit} 1]
        set tbEntityName $tbUnitName
        set tbArchitectureName [lindex ${tbUnit} 2]
        if [file exists ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/Iftb${tbEntityName}-c.vhd] then {
            puts "Compiling configuration $tbArchitectureName of testbench for grp$GrpName, unit$tbUnitName."
            vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/unit${tbUnitName}/src/Iftb${tbEntityName}-${tbArchitectureName}-c.vhd
        }
    }
}

if [info exists tbPkgs] then {
    # Testbenches for packages
    # Analyze all entities before analyzing the architectures allows any
    # ordering of units in the unit list $tbUnits.
    foreach {tbPkg} $tbPkgs {
        set GrpName [lindex ${tbPkg} 0]
        set tbPkgName [lindex ${tbPkg} 1]
        set tbEntityName $tbPkgName
        puts "Compiling entity of testbench for grp$GrpName, pkg$tbPkgName."
        vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/pkg${tbPkgName}/src/tb${tbEntityName}-e.vhd
        set tbName $tbPkgName
    }
    # Analyze all architectures after all entities are analyzed.
    foreach {tbPkg} $tbPkgs {
        set GrpName [lindex ${tbPkg} 0]
        set tbPkgName [lindex ${tbPkg} 1]
        set tbEntityName [lindex ${tbPkg} 1]
        set tbArchitectureName [lindex ${tbPkg} 2]
        puts "Compiling architecture $tbArchitectureName of testbench for grp$GrpName, pkg$tbPkgName."
        vcom -93 -work work ${PathUnitToRoot}/grp${GrpName}/pkg${tbPkgName}/src/tb${tbEntityName}-${tbArchitectureName}-a.vhd
    }
}

