# 
# FirFilter "FirFilter: Finite Impulse Response Filter" v1.0
# Franz Steinbacher 2018.01.24.12:22:01
# FIR Filter with MM interface for coeffs
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module FirFilter
# 
set_module_property DESCRIPTION "FIR Filter with MM interface for coeffs"
set_module_property NAME FirFilter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "ASP-SoC IP/Filter"
set_module_property AUTHOR "Franz Steinbacher"
set_module_property DISPLAY_NAME "FirFilter: Finite Impulse Response Filter"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false

set_module_property ELABORATION_CALLBACK elaborate


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL FirFilter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file FirFilter-Rtl-a.vhd VHDL PATH ../hdl/FirFilter-Rtl-a.vhd
add_fileset_file FirFilter-e.vhd VHDL PATH ../hdl/FirFilter-e.vhd TOP_LEVEL_FILE
add_fileset_file Global-p.vhd VHDL PATH ../../../grpPackages/pkgGlobal/src/Global-p.vhd
add_fileset_file fixed_float_types_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
add_fileset_file fixed_pkg_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl


# 
# parameters
# 
add_parameter data_width_g NATURAL 24
set_parameter_property data_width_g DEFAULT_VALUE 24
set_parameter_property data_width_g DISPLAY_NAME "Data Width"
set_parameter_property data_width_g TYPE NATURAL
set_parameter_property data_width_g UNITS bits
set_parameter_property data_width_g ALLOWED_RANGES {16 20 24 32}
set_parameter_property data_width_g HDL_PARAMETER true

add_parameter coeff_num_g NATURAL 16
set_parameter_property coeff_num_g DEFAULT_VALUE 16
set_parameter_property coeff_num_g DISPLAY_NAME "Number of Coeffs"
set_parameter_property coeff_num_g TYPE NATURAL
set_parameter_property coeff_num_g UNITS none
set_parameter_property coeff_num_g ALLOWED_RANGES {2 4 8 16 32 64 128 256 512 1024 2048 4096}
set_parameter_property coeff_num_g HDL_PARAMETER true

add_parameter coeff_addr_width_g NATURAL 4
set_parameter_property coeff_addr_width_g DEFAULT_VALUE 4
set_parameter_property coeff_addr_width_g DISPLAY_NAME "Address Width"
set_parameter_property coeff_addr_width_g TYPE NATURAL
set_parameter_property coeff_addr_width_g ENABLED false
set_parameter_property coeff_addr_width_g UNITS bits
set_parameter_property coeff_addr_width_g HDL_PARAMETER true
set_parameter_property coeff_addr_width_g DERIVED true

# calculate nr of bits needed to represent a number
proc NrBitsNeeded {x} {expr int(ceil(log($x)/log(2)))}

proc elaborate {} {
    set num_coeffs [ get_parameter_value "coeff_num_g" ]
    #get number of bits needed
    set numOfBits [NrBitsNeeded $num_coeffs]
    set_parameter_value coeff_addr_width_g $numOfBits
}

# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock csi_clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rsi_reset_n reset_n Input 1


# 
# connection point sink
# 
add_interface sink avalon_streaming end
set_interface_property sink associatedClock clock
set_interface_property sink associatedReset reset
set_interface_property sink dataBitsPerSymbol 8
set_interface_property sink errorDescriptor ""
set_interface_property sink firstSymbolInHighOrderBits true
set_interface_property sink maxChannel 0
set_interface_property sink readyLatency 0
set_interface_property sink ENABLED true
set_interface_property sink EXPORT_OF ""
set_interface_property sink PORT_NAME_MAP ""
set_interface_property sink CMSIS_SVD_VARIABLES ""
set_interface_property sink SVD_ADDRESS_GROUP ""

add_interface_port sink asi_valid valid Input 1
add_interface_port sink asi_data data Input data_width_g


# 
# connection point source
# 
add_interface source avalon_streaming start
set_interface_property source associatedClock clock
set_interface_property source associatedReset reset
set_interface_property source dataBitsPerSymbol 8
set_interface_property source errorDescriptor ""
set_interface_property source firstSymbolInHighOrderBits true
set_interface_property source maxChannel 0
set_interface_property source readyLatency 0
set_interface_property source ENABLED true
set_interface_property source EXPORT_OF ""
set_interface_property source PORT_NAME_MAP ""
set_interface_property source CMSIS_SVD_VARIABLES ""
set_interface_property source SVD_ADDRESS_GROUP ""

add_interface_port source aso_valid valid Output 1
add_interface_port source aso_data data Output data_width_g


# 
# connection point s1_enable
# 
add_interface s1_enable avalon end
set_interface_property s1_enable addressUnits WORDS
set_interface_property s1_enable associatedClock clock
set_interface_property s1_enable associatedReset reset
set_interface_property s1_enable bitsPerSymbol 8
set_interface_property s1_enable burstOnBurstBoundariesOnly false
set_interface_property s1_enable burstcountUnits WORDS
set_interface_property s1_enable explicitAddressSpan 0
set_interface_property s1_enable holdTime 0
set_interface_property s1_enable linewrapBursts false
set_interface_property s1_enable maximumPendingReadTransactions 0
set_interface_property s1_enable maximumPendingWriteTransactions 0
set_interface_property s1_enable readLatency 0
set_interface_property s1_enable readWaitTime 1
set_interface_property s1_enable setupTime 0
set_interface_property s1_enable timingUnits Cycles
set_interface_property s1_enable writeWaitTime 0
set_interface_property s1_enable ENABLED true
set_interface_property s1_enable EXPORT_OF ""
set_interface_property s1_enable PORT_NAME_MAP ""
set_interface_property s1_enable CMSIS_SVD_VARIABLES ""
set_interface_property s1_enable SVD_ADDRESS_GROUP ""

add_interface_port s1_enable avs_s1_write write Input 1
add_interface_port s1_enable avs_s1_writedata writedata Input 32
set_interface_assignment s1_enable embeddedsw.configuration.isFlash 0
set_interface_assignment s1_enable embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1_enable embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1_enable embeddedsw.configuration.isPrintableDevice 0


# 
# connection point s0_coeffs
# 
add_interface s0_coeffs avalon end
set_interface_property s0_coeffs addressUnits WORDS
set_interface_property s0_coeffs associatedClock clock
set_interface_property s0_coeffs associatedReset reset
set_interface_property s0_coeffs bitsPerSymbol 8
set_interface_property s0_coeffs burstOnBurstBoundariesOnly false
set_interface_property s0_coeffs burstcountUnits WORDS
set_interface_property s0_coeffs explicitAddressSpan 0
set_interface_property s0_coeffs holdTime 0
set_interface_property s0_coeffs linewrapBursts false
set_interface_property s0_coeffs maximumPendingReadTransactions 0
set_interface_property s0_coeffs maximumPendingWriteTransactions 0
set_interface_property s0_coeffs readLatency 0
set_interface_property s0_coeffs readWaitTime 1
set_interface_property s0_coeffs setupTime 0
set_interface_property s0_coeffs timingUnits Cycles
set_interface_property s0_coeffs writeWaitTime 0
set_interface_property s0_coeffs ENABLED true
set_interface_property s0_coeffs EXPORT_OF ""
set_interface_property s0_coeffs PORT_NAME_MAP ""
set_interface_property s0_coeffs CMSIS_SVD_VARIABLES ""
set_interface_property s0_coeffs SVD_ADDRESS_GROUP ""

add_interface_port s0_coeffs avs_s0_write write Input 1
add_interface_port s0_coeffs avs_s0_address address Input coeff_addr_width_g
add_interface_port s0_coeffs avs_s0_writedata writedata Input 32
set_interface_assignment s0_coeffs embeddedsw.configuration.isFlash 0
set_interface_assignment s0_coeffs embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0_coeffs embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0_coeffs embeddedsw.configuration.isPrintableDevice 0

