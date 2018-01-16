# 
# Dds "Dds: Direct Digital Synthesis" v1.0
# Franz Steinbacher 2017.12.11.19:16:06
# Direct Digital Synthesis with MM interface
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module Dds
# 
set_module_property DESCRIPTION "Direct Digital Synthesis with MM interface"
set_module_property NAME Dds
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "ASP-SoC IP/Dsp"
set_module_property AUTHOR "Franz Steinbacher"
set_module_property DISPLAY_NAME "DDS: Direct Digital Synthesis"
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL Dds
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file Dds-Rtl-a.vhd VHDL PATH ../hdl/Dds-Rtl-a.vhd
add_fileset_file Dds-e.vhd VHDL PATH ../hdl/Dds-e.vhd TOP_LEVEL_FILE
add_fileset_file sin_4096-p.vhd VHDL PATH ../../../grpPackages/pkgSin/sin_4096-p.vhd
add_fileset_file fixed_pkg_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_pkg_c.vhdl
add_fileset_file fixed_float_types_c.vhdl VHDL PATH ../../../grpPackages/pkgFixed/src/fixed_float_types_c.vhdl
add_fileset_file Global-p.vhd VHDL PATH ../../../grpPackages/pkgGlobal/src/Global-p.vhd


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

add_parameter phase_bits_g NATURAL 20
set_parameter_property phase_bits_g DEFAULT_VALUE 20
set_parameter_property phase_bits_g DISPLAY_NAME "Phase"
set_parameter_property phase_bits_g TYPE NATURAL
set_parameter_property phase_bits_g UNITS bits
set_parameter_property phase_bits_g HDL_PARAMETER true

add_parameter phase_dither_g NATURAL 8
set_parameter_property phase_dither_g DEFAULT_VALUE 8
set_parameter_property phase_dither_g DISPLAY_NAME "Phase Dither"
set_parameter_property phase_dither_g TYPE NATURAL
set_parameter_property phase_dither_g UNITS bits
set_parameter_property phase_dither_g HDL_PARAMETER true

add_parameter wave_table_width_g NATURAL 14
set_parameter_property wave_table_width_g DEFAULT_VALUE 14
set_parameter_property wave_table_width_g DISPLAY_NAME "Wave Table Entry Width"
set_parameter_property wave_table_width_g TYPE NATURAL
set_parameter_property wave_table_width_g UNITS bits
set_parameter_property wave_table_width_g HDL_PARAMETER true

add_parameter wave_table_len_g NATURAL 4096
set_parameter_property wave_table_len_g DEFAULT_VALUE 4096
set_parameter_property wave_table_len_g DISPLAY_NAME "Wave Table Entries"
set_parameter_property wave_table_len_g DESCRIPTION "2^(Phase - Dither)"
set_parameter_property wave_table_len_g TYPE NATURAL
set_parameter_property wave_table_len_g ENABLED false
set_parameter_property wave_table_len_g UNITS bits
set_parameter_property wave_table_len_g HDL_PARAMETER true
set_parameter_property wave_table_len_g DERIVED true

add_parameter wave_table_addr_bits_g NATURAL 12
set_parameter_property wave_table_addr_bits_g DEFAULT_VALUE 12
set_parameter_property wave_table_addr_bits_g DISPLAY_NAME "Wave Table Address Width"
set_parameter_property wave_table_len_g DESCRIPTION "Phase - Dither" 
set_parameter_property wave_table_addr_bits_g TYPE NATURAL
set_parameter_property wave_table_addr_bits_g ENABLED false
set_parameter_property wave_table_addr_bits_g UNITS bits
set_parameter_property wave_table_addr_bits_g HDL_PARAMETER true
set_parameter_property wave_table_addr_bits_g DERIVED true

proc elaborate {} {
    set phase [ get_parameter_value "phase_bits_g" ]
    set dither [ get_parameter_value "phase_dither_g" ]
    set addr_width [ expr $phase - $dither ]
    set_parameter_value wave_table_addr_bits_g $addr_width

    set table_len [ expr 2**$addr_width ]
    set_parameter_value wave_table_len_g $table_len
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

add_interface_port source aso_data data Output data_width_g
add_interface_port source aso_valid valid Output 1


# 
# connection point strobe
# 
add_interface strobe conduit end
set_interface_property strobe associatedClock clock
set_interface_property strobe associatedReset reset
set_interface_property strobe ENABLED true
set_interface_property strobe EXPORT_OF ""
set_interface_property strobe PORT_NAME_MAP ""
set_interface_property strobe CMSIS_SVD_VARIABLES ""
set_interface_property strobe SVD_ADDRESS_GROUP ""

add_interface_port strobe coe_sample_strobe export Input 1


# 
# connection point s0_table
# 
add_interface s0_table avalon end
set_interface_property s0_table addressUnits WORDS
set_interface_property s0_table associatedClock clock
set_interface_property s0_table associatedReset reset
set_interface_property s0_table bitsPerSymbol 8
set_interface_property s0_table burstOnBurstBoundariesOnly false
set_interface_property s0_table burstcountUnits WORDS
set_interface_property s0_table explicitAddressSpan 0
set_interface_property s0_table holdTime 0
set_interface_property s0_table linewrapBursts false
set_interface_property s0_table maximumPendingReadTransactions 0
set_interface_property s0_table maximumPendingWriteTransactions 0
set_interface_property s0_table readLatency 0
set_interface_property s0_table readWaitTime 1
set_interface_property s0_table setupTime 0
set_interface_property s0_table timingUnits Cycles
set_interface_property s0_table writeWaitTime 0
set_interface_property s0_table ENABLED true
set_interface_property s0_table EXPORT_OF ""
set_interface_property s0_table PORT_NAME_MAP ""
set_interface_property s0_table CMSIS_SVD_VARIABLES ""
set_interface_property s0_table SVD_ADDRESS_GROUP ""

add_interface_port s0_table avs_s0_write write Input 1
add_interface_port s0_table avs_s0_address address Input wave_table_addr_bits_g
add_interface_port s0_table avs_s0_writedata writedata Input 32
set_interface_assignment s0_table embeddedsw.configuration.isFlash 0
set_interface_assignment s0_table embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0_table embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0_table embeddedsw.configuration.isPrintableDevice 0


# 
# connection point s1_config
# 
add_interface s1_config avalon end
set_interface_property s1_config addressUnits WORDS
set_interface_property s1_config associatedClock clock
set_interface_property s1_config associatedReset reset
set_interface_property s1_config bitsPerSymbol 8
set_interface_property s1_config burstOnBurstBoundariesOnly false
set_interface_property s1_config burstcountUnits WORDS
set_interface_property s1_config explicitAddressSpan 0
set_interface_property s1_config holdTime 0
set_interface_property s1_config linewrapBursts false
set_interface_property s1_config maximumPendingReadTransactions 0
set_interface_property s1_config maximumPendingWriteTransactions 0
set_interface_property s1_config readLatency 0
set_interface_property s1_config readWaitTime 1
set_interface_property s1_config setupTime 0
set_interface_property s1_config timingUnits Cycles
set_interface_property s1_config writeWaitTime 0
set_interface_property s1_config ENABLED true
set_interface_property s1_config EXPORT_OF ""
set_interface_property s1_config PORT_NAME_MAP ""
set_interface_property s1_config CMSIS_SVD_VARIABLES ""
set_interface_property s1_config SVD_ADDRESS_GROUP ""

add_interface_port s1_config avs_s1_write write Input 1
add_interface_port s1_config avs_s1_address address Input 1
add_interface_port s1_config avs_s1_writedata writedata Input 32
set_interface_assignment s1_config embeddedsw.configuration.isFlash 0
set_interface_assignment s1_config embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1_config embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1_config embeddedsw.configuration.isPrintableDevice 0

