# 
# Multiply "Multiply: Multiply Channels" v1.0
# Franz Steinbacher 2018.01.16.12:01:53
# Multiply left and right channel
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module Multiply
# 
set_module_property DESCRIPTION "Multiply left and right channel"
set_module_property NAME Multiply
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "ASP-SoC IP/Primitives"
set_module_property AUTHOR "Franz Steinbacher"
set_module_property DISPLAY_NAME "Multiply: Multiply Channels"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Multiply
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fixed_float_types_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
add_fileset_file fixed_pkg_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl
add_fileset_file Multiply-Rtl-a.vhd VHDL PATH ../hdl/Multiply-Rtl-a.vhd
add_fileset_file Multiply-e.vhd VHDL PATH ../hdl/Multiply-e.vhd TOP_LEVEL_FILE


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
# connection point s0
# 
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 maximumPendingWriteTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_address address Input 1
add_interface_port s0 avs_s0_writedata writedata Input 32
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point left_sink
# 
add_interface left_sink avalon_streaming end
set_interface_property left_sink associatedClock clock
set_interface_property left_sink associatedReset reset
set_interface_property left_sink dataBitsPerSymbol 8
set_interface_property left_sink errorDescriptor ""
set_interface_property left_sink firstSymbolInHighOrderBits true
set_interface_property left_sink maxChannel 0
set_interface_property left_sink readyLatency 0
set_interface_property left_sink ENABLED true
set_interface_property left_sink EXPORT_OF ""
set_interface_property left_sink PORT_NAME_MAP ""
set_interface_property left_sink CMSIS_SVD_VARIABLES ""
set_interface_property left_sink SVD_ADDRESS_GROUP ""

add_interface_port left_sink asi_left_data data Input data_width_g
add_interface_port left_sink asi_left_valid valid Input 1


# 
# connection point left_source
# 
add_interface left_source avalon_streaming start
set_interface_property left_source associatedClock clock
set_interface_property left_source associatedReset reset
set_interface_property left_source dataBitsPerSymbol 8
set_interface_property left_source errorDescriptor ""
set_interface_property left_source firstSymbolInHighOrderBits true
set_interface_property left_source maxChannel 0
set_interface_property left_source readyLatency 0
set_interface_property left_source ENABLED true
set_interface_property left_source EXPORT_OF ""
set_interface_property left_source PORT_NAME_MAP ""
set_interface_property left_source CMSIS_SVD_VARIABLES ""
set_interface_property left_source SVD_ADDRESS_GROUP ""

add_interface_port left_source aso_left_data data Output data_width_g
add_interface_port left_source aso_left_valid valid Output 1


# 
# connection point right_sink
# 
add_interface right_sink avalon_streaming end
set_interface_property right_sink associatedClock clock
set_interface_property right_sink associatedReset reset
set_interface_property right_sink dataBitsPerSymbol 8
set_interface_property right_sink errorDescriptor ""
set_interface_property right_sink firstSymbolInHighOrderBits true
set_interface_property right_sink maxChannel 0
set_interface_property right_sink readyLatency 0
set_interface_property right_sink ENABLED true
set_interface_property right_sink EXPORT_OF ""
set_interface_property right_sink PORT_NAME_MAP ""
set_interface_property right_sink CMSIS_SVD_VARIABLES ""
set_interface_property right_sink SVD_ADDRESS_GROUP ""

add_interface_port right_sink asi_right_data data Input data_width_g
add_interface_port right_sink asi_right_valid valid Input 1


# 
# connection point right_source
# 
add_interface right_source avalon_streaming start
set_interface_property right_source associatedClock clock
set_interface_property right_source associatedReset reset
set_interface_property right_source dataBitsPerSymbol 8
set_interface_property right_source errorDescriptor ""
set_interface_property right_source firstSymbolInHighOrderBits true
set_interface_property right_source maxChannel 0
set_interface_property right_source readyLatency 0
set_interface_property right_source ENABLED true
set_interface_property right_source EXPORT_OF ""
set_interface_property right_source PORT_NAME_MAP ""
set_interface_property right_source CMSIS_SVD_VARIABLES ""
set_interface_property right_source SVD_ADDRESS_GROUP ""

add_interface_port right_source aso_right_data data Output data_width_g
add_interface_port right_source aso_right_valid valid Output 1

