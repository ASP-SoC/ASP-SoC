# Copyright (C) 2016  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Intel and sold by Intel or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: PlatformHps.tcl
# Generated on: Tue Oct 24 13:05:23 2017

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "PlatformHps"]} {
		puts "Project PlatformHps is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists PlatformHps]} {
		project_open -revision PlatformHps PlatformHps
	} else {
		project_new -revision PlatformHps PlatformHps
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSEMA5F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 16.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:43:21  JUNE 07, 2017"
	set_global_assignment -name LAST_QUARTUS_VERSION "16.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name QIP_FILE Platform/synthesis/Platform.qip
	set_global_assignment -name VHDL_FILE "../libASP/grpPlatform/unitPlatformHps/hdl/PlatformHps-Struct-a.vhd"
	set_global_assignment -name VHDL_FILE "../libASP/grpPlatform/unitPlatformHps/hdl/PlatformHps-e.vhd"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name USE_DLL_FREQUENCY_FOR_DQS_DELAY_CHAIN ON
	set_global_assignment -name UNIPHY_SEQUENCER_DQS_CONFIG_ENABLE ON
	set_global_assignment -name OPTIMIZE_MULTI_CORNER_TIMING ON
	set_global_assignment -name ECO_REGENERATE_REPORT ON
	set_location_assignment PIN_AJ4 -to ADC_CS_N
	set_location_assignment PIN_AK4 -to ADC_DIN
	set_location_assignment PIN_AK3 -to ADC_DOUT
	set_location_assignment PIN_AK2 -to ADC_SCLK
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_CS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_DIN -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_DOUT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SCLK -entity DE1_SoC
	set_location_assignment PIN_K7 -to AUD_ADCDAT
	set_location_assignment PIN_K8 -to AUD_ADCLRCK
	set_location_assignment PIN_H7 -to AUD_BCLK
	set_location_assignment PIN_J7 -to AUD_DACDAT
	set_location_assignment PIN_H8 -to AUD_DACLRCK
	set_location_assignment PIN_G7 -to AUD_XCK
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCDAT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCLRCK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_BCLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACDAT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACLRCK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_XCK -entity DE1_SoC
	set_location_assignment PIN_AF14 -to CLOCK_50
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50 -entity DE1_SoC
	set_location_assignment PIN_AA16 -to CLOCK2_50
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK2_50 -entity DE1_SoC
	set_location_assignment PIN_Y26 -to CLOCK3_50
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK3_50 -entity DE1_SoC
	set_location_assignment PIN_K14 -to CLOCK4_50
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK4_50 -entity DE1_SoC
	set_location_assignment PIN_AK14 -to DRAM_ADDR[0]
	set_location_assignment PIN_AH14 -to DRAM_ADDR[1]
	set_location_assignment PIN_AG15 -to DRAM_ADDR[2]
	set_location_assignment PIN_AE14 -to DRAM_ADDR[3]
	set_location_assignment PIN_AB15 -to DRAM_ADDR[4]
	set_location_assignment PIN_AC14 -to DRAM_ADDR[5]
	set_location_assignment PIN_AD14 -to DRAM_ADDR[6]
	set_location_assignment PIN_AF15 -to DRAM_ADDR[7]
	set_location_assignment PIN_AH15 -to DRAM_ADDR[8]
	set_location_assignment PIN_AG13 -to DRAM_ADDR[9]
	set_location_assignment PIN_AG12 -to DRAM_ADDR[10]
	set_location_assignment PIN_AH13 -to DRAM_ADDR[11]
	set_location_assignment PIN_AJ14 -to DRAM_ADDR[12]
	set_location_assignment PIN_AF13 -to DRAM_BA[0]
	set_location_assignment PIN_AJ12 -to DRAM_BA[1]
	set_location_assignment PIN_AF11 -to DRAM_CAS_N
	set_location_assignment PIN_AK13 -to DRAM_CKE
	set_location_assignment PIN_AH12 -to DRAM_CLK
	set_location_assignment PIN_AG11 -to DRAM_CS_N
	set_location_assignment PIN_AK6 -to DRAM_DQ[0]
	set_location_assignment PIN_AJ7 -to DRAM_DQ[1]
	set_location_assignment PIN_AK7 -to DRAM_DQ[2]
	set_location_assignment PIN_AK8 -to DRAM_DQ[3]
	set_location_assignment PIN_AK9 -to DRAM_DQ[4]
	set_location_assignment PIN_AG10 -to DRAM_DQ[5]
	set_location_assignment PIN_AK11 -to DRAM_DQ[6]
	set_location_assignment PIN_AJ11 -to DRAM_DQ[7]
	set_location_assignment PIN_AH10 -to DRAM_DQ[8]
	set_location_assignment PIN_AJ10 -to DRAM_DQ[9]
	set_location_assignment PIN_AJ9 -to DRAM_DQ[10]
	set_location_assignment PIN_AH9 -to DRAM_DQ[11]
	set_location_assignment PIN_AH8 -to DRAM_DQ[12]
	set_location_assignment PIN_AH7 -to DRAM_DQ[13]
	set_location_assignment PIN_AJ6 -to DRAM_DQ[14]
	set_location_assignment PIN_AJ5 -to DRAM_DQ[15]
	set_location_assignment PIN_AB13 -to DRAM_LDQM
	set_location_assignment PIN_AE13 -to DRAM_RAS_N
	set_location_assignment PIN_AK12 -to DRAM_UDQM
	set_location_assignment PIN_AA13 -to DRAM_WE_N
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[9] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CAS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CKE -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[9] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[13] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[14] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[15] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_LDQM -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_RAS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_UDQM -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_WE_N -entity DE1_SoC
	set_location_assignment PIN_AA12 -to FAN_CTRL
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FAN_CTRL -entity DE1_SoC
	set_location_assignment PIN_J12 -to FPGA_I2C_SCLK
	set_location_assignment PIN_K12 -to FPGA_I2C_SDAT
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_I2C_SCLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FPGA_I2C_SDAT -entity DE1_SoC
	set_location_assignment PIN_AC18 -to GPIO_0[0]
	set_location_assignment PIN_AH18 -to GPIO_0[10]
	set_location_assignment PIN_AH17 -to GPIO_0[11]
	set_location_assignment PIN_AG16 -to GPIO_0[12]
	set_location_assignment PIN_AE16 -to GPIO_0[13]
	set_location_assignment PIN_AF16 -to GPIO_0[14]
	set_location_assignment PIN_AG17 -to GPIO_0[15]
	set_location_assignment PIN_AA18 -to GPIO_0[16]
	set_location_assignment PIN_AA19 -to GPIO_0[17]
	set_location_assignment PIN_AE17 -to GPIO_0[18]
	set_location_assignment PIN_AC20 -to GPIO_0[19]
	set_location_assignment PIN_Y17 -to GPIO_0[1]
	set_location_assignment PIN_AH19 -to GPIO_0[20]
	set_location_assignment PIN_AJ20 -to GPIO_0[21]
	set_location_assignment PIN_AH20 -to GPIO_0[22]
	set_location_assignment PIN_AK21 -to GPIO_0[23]
	set_location_assignment PIN_AD19 -to GPIO_0[24]
	set_location_assignment PIN_AD20 -to GPIO_0[25]
	set_location_assignment PIN_AE18 -to GPIO_0[26]
	set_location_assignment PIN_AE19 -to GPIO_0[27]
	set_location_assignment PIN_AF20 -to GPIO_0[28]
	set_location_assignment PIN_AF21 -to GPIO_0[29]
	set_location_assignment PIN_AD17 -to GPIO_0[2]
	set_location_assignment PIN_AF19 -to GPIO_0[30]
	set_location_assignment PIN_AG21 -to GPIO_0[31]
	set_location_assignment PIN_AF18 -to GPIO_0[32]
	set_location_assignment PIN_AG20 -to GPIO_0[33]
	set_location_assignment PIN_AG18 -to GPIO_0[34]
	set_location_assignment PIN_AJ21 -to GPIO_0[35]
	set_location_assignment PIN_Y18 -to GPIO_0[3]
	set_location_assignment PIN_AK16 -to GPIO_0[4]
	set_location_assignment PIN_AK18 -to GPIO_0[5]
	set_location_assignment PIN_AK19 -to GPIO_0[6]
	set_location_assignment PIN_AJ19 -to GPIO_0[7]
	set_location_assignment PIN_AJ17 -to GPIO_0[8]
	set_location_assignment PIN_AJ16 -to GPIO_0[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[13] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[14] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[15] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[16] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[17] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[18] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[19] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[20] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[21] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[22] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[23] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[24] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[25] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[26] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[27] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[28] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[29] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[30] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[31] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[32] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[33] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[34] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[35] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_0[9] -entity DE1_SoC
	set_location_assignment PIN_AB17 -to GPIO_1[0]
	set_location_assignment PIN_AG26 -to GPIO_1[10]
	set_location_assignment PIN_AH24 -to GPIO_1[11]
	set_location_assignment PIN_AH27 -to GPIO_1[12]
	set_location_assignment PIN_AJ27 -to GPIO_1[13]
	set_location_assignment PIN_AK29 -to GPIO_1[14]
	set_location_assignment PIN_AK28 -to GPIO_1[15]
	set_location_assignment PIN_AK27 -to GPIO_1[16]
	set_location_assignment PIN_AJ26 -to GPIO_1[17]
	set_location_assignment PIN_AK26 -to GPIO_1[18]
	set_location_assignment PIN_AH25 -to GPIO_1[19]
	set_location_assignment PIN_AA21 -to GPIO_1[1]
	set_location_assignment PIN_AJ25 -to GPIO_1[20]
	set_location_assignment PIN_AJ24 -to GPIO_1[21]
	set_location_assignment PIN_AK24 -to GPIO_1[22]
	set_location_assignment PIN_AG23 -to GPIO_1[23]
	set_location_assignment PIN_AK23 -to GPIO_1[24]
	set_location_assignment PIN_AH23 -to GPIO_1[25]
	set_location_assignment PIN_AK22 -to GPIO_1[26]
	set_location_assignment PIN_AJ22 -to GPIO_1[27]
	set_location_assignment PIN_AH22 -to GPIO_1[28]
	set_location_assignment PIN_AG22 -to GPIO_1[29]
	set_location_assignment PIN_AB21 -to GPIO_1[2]
	set_location_assignment PIN_AF24 -to GPIO_1[30]
	set_location_assignment PIN_AF23 -to GPIO_1[31]
	set_location_assignment PIN_AE22 -to GPIO_1[32]
	set_location_assignment PIN_AD21 -to GPIO_1[33]
	set_location_assignment PIN_AA20 -to GPIO_1[34]
	set_location_assignment PIN_AC22 -to GPIO_1[35]
	set_location_assignment PIN_AC23 -to GPIO_1[3]
	set_location_assignment PIN_AD24 -to GPIO_1[4]
	set_location_assignment PIN_AE23 -to GPIO_1[5]
	set_location_assignment PIN_AE24 -to GPIO_1[6]
	set_location_assignment PIN_AF25 -to GPIO_1[7]
	set_location_assignment PIN_AF26 -to GPIO_1[8]
	set_location_assignment PIN_AG25 -to GPIO_1[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[13] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[14] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[15] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[16] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[17] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[18] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[19] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[20] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[21] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[22] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[23] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[24] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[25] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[26] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[27] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[28] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[29] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[30] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[31] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[32] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[33] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[34] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[35] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_1[9] -entity DE1_SoC
	set_location_assignment PIN_AE26 -to HEX0[0]
	set_location_assignment PIN_AE27 -to HEX0[1]
	set_location_assignment PIN_AE28 -to HEX0[2]
	set_location_assignment PIN_AG27 -to HEX0[3]
	set_location_assignment PIN_AF28 -to HEX0[4]
	set_location_assignment PIN_AG28 -to HEX0[5]
	set_location_assignment PIN_AH28 -to HEX0[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[6] -entity DE1_SoC
	set_location_assignment PIN_AJ29 -to HEX1[0]
	set_location_assignment PIN_AH29 -to HEX1[1]
	set_location_assignment PIN_AH30 -to HEX1[2]
	set_location_assignment PIN_AG30 -to HEX1[3]
	set_location_assignment PIN_AF29 -to HEX1[4]
	set_location_assignment PIN_AF30 -to HEX1[5]
	set_location_assignment PIN_AD27 -to HEX1[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[6] -entity DE1_SoC
	set_location_assignment PIN_AB23 -to HEX2[0]
	set_location_assignment PIN_AE29 -to HEX2[1]
	set_location_assignment PIN_AD29 -to HEX2[2]
	set_location_assignment PIN_AC28 -to HEX2[3]
	set_location_assignment PIN_AD30 -to HEX2[4]
	set_location_assignment PIN_AC29 -to HEX2[5]
	set_location_assignment PIN_AC30 -to HEX2[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[6] -entity DE1_SoC
	set_location_assignment PIN_AD26 -to HEX3[0]
	set_location_assignment PIN_AC27 -to HEX3[1]
	set_location_assignment PIN_AD25 -to HEX3[2]
	set_location_assignment PIN_AC25 -to HEX3[3]
	set_location_assignment PIN_AB28 -to HEX3[4]
	set_location_assignment PIN_AB25 -to HEX3[5]
	set_location_assignment PIN_AB22 -to HEX3[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[6] -entity DE1_SoC
	set_location_assignment PIN_AA24 -to HEX4[0]
	set_location_assignment PIN_Y23 -to HEX4[1]
	set_location_assignment PIN_Y24 -to HEX4[2]
	set_location_assignment PIN_W22 -to HEX4[3]
	set_location_assignment PIN_W24 -to HEX4[4]
	set_location_assignment PIN_V23 -to HEX4[5]
	set_location_assignment PIN_W25 -to HEX4[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[6] -entity DE1_SoC
	set_location_assignment PIN_V25 -to HEX5[0]
	set_location_assignment PIN_AA28 -to HEX5[1]
	set_location_assignment PIN_Y27 -to HEX5[2]
	set_location_assignment PIN_AB27 -to HEX5[3]
	set_location_assignment PIN_AB26 -to HEX5[4]
	set_location_assignment PIN_AA26 -to HEX5[5]
	set_location_assignment PIN_AA25 -to HEX5[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[6] -entity DE1_SoC
	set_location_assignment PIN_AA30 -to IRDA_RXD
	set_location_assignment PIN_AB30 -to IRDA_TXD
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IRDA_RXD -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IRDA_TXD -entity DE1_SoC
	set_location_assignment PIN_AA14 -to KEY[0]
	set_location_assignment PIN_AA15 -to KEY[1]
	set_location_assignment PIN_W15 -to KEY[2]
	set_location_assignment PIN_Y16 -to KEY[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[3] -entity DE1_SoC
	set_location_assignment PIN_V16 -to LEDR[0]
	set_location_assignment PIN_W16 -to LEDR[1]
	set_location_assignment PIN_V17 -to LEDR[2]
	set_location_assignment PIN_V18 -to LEDR[3]
	set_location_assignment PIN_W17 -to LEDR[4]
	set_location_assignment PIN_W19 -to LEDR[5]
	set_location_assignment PIN_Y19 -to LEDR[6]
	set_location_assignment PIN_W20 -to LEDR[7]
	set_location_assignment PIN_W21 -to LEDR[8]
	set_location_assignment PIN_Y21 -to LEDR[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9] -entity DE1_SoC
	set_location_assignment PIN_AD7 -to PS2_CLK
	set_location_assignment PIN_AE7 -to PS2_DAT
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_DAT -entity DE1_SoC
	set_location_assignment PIN_AD9 -to PS2_CLK2
	set_location_assignment PIN_AE9 -to PS2_DAT2
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_CLK2 -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_DAT2 -entity DE1_SoC
	set_location_assignment PIN_AB12 -to SW[0]
	set_location_assignment PIN_AC12 -to SW[1]
	set_location_assignment PIN_AF9 -to SW[2]
	set_location_assignment PIN_AF10 -to SW[3]
	set_location_assignment PIN_AD11 -to SW[4]
	set_location_assignment PIN_AD12 -to SW[5]
	set_location_assignment PIN_AE11 -to SW[6]
	set_location_assignment PIN_AC9 -to SW[7]
	set_location_assignment PIN_AD10 -to SW[8]
	set_location_assignment PIN_AE12 -to SW[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9] -entity DE1_SoC
	set_location_assignment PIN_H15 -to TD_CLK27
	set_location_assignment PIN_D2 -to TD_DATA[0]
	set_location_assignment PIN_B1 -to TD_DATA[1]
	set_location_assignment PIN_E2 -to TD_DATA[2]
	set_location_assignment PIN_B2 -to TD_DATA[3]
	set_location_assignment PIN_D1 -to TD_DATA[4]
	set_location_assignment PIN_E1 -to TD_DATA[5]
	set_location_assignment PIN_C2 -to TD_DATA[6]
	set_location_assignment PIN_B3 -to TD_DATA[7]
	set_location_assignment PIN_A5 -to TD_HS
	set_location_assignment PIN_F6 -to TD_RESET_N
	set_location_assignment PIN_A3 -to TD_VS
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_CLK27 -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_HS -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_RESET_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_VS -entity DE1_SoC
	set_location_assignment PIN_AF4 -to USB_B2_CLK
	set_location_assignment PIN_AH4 -to USB_B2_DATA[0]
	set_location_assignment PIN_AH3 -to USB_B2_DATA[1]
	set_location_assignment PIN_AJ2 -to USB_B2_DATA[2]
	set_location_assignment PIN_AJ1 -to USB_B2_DATA[3]
	set_location_assignment PIN_AH2 -to USB_B2_DATA[4]
	set_location_assignment PIN_AG3 -to USB_B2_DATA[5]
	set_location_assignment PIN_AG2 -to USB_B2_DATA[6]
	set_location_assignment PIN_AG1 -to USB_B2_DATA[7]
	set_location_assignment PIN_AF5 -to USB_EMPTY
	set_location_assignment PIN_AG5 -to USB_FULL
	set_location_assignment PIN_AF6 -to USB_OE_N
	set_location_assignment PIN_AG6 -to USB_RD_N
	set_location_assignment PIN_AG7 -to USB_RESET_N
	set_location_assignment PIN_AG8 -to USB_SCL
	set_location_assignment PIN_AF8 -to USB_SDA
	set_location_assignment PIN_AH5 -to USB_WR_N
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_B2_DATA[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_EMPTY -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_FULL -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_OE_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_RD_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_RESET_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_SCL -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_SDA -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to USB_WR_N -entity DE1_SoC
	set_location_assignment PIN_B13 -to VGA_B[0]
	set_location_assignment PIN_G13 -to VGA_B[1]
	set_location_assignment PIN_H13 -to VGA_B[2]
	set_location_assignment PIN_F14 -to VGA_B[3]
	set_location_assignment PIN_H14 -to VGA_B[4]
	set_location_assignment PIN_F15 -to VGA_B[5]
	set_location_assignment PIN_G15 -to VGA_B[6]
	set_location_assignment PIN_J14 -to VGA_B[7]
	set_location_assignment PIN_F10 -to VGA_BLANK_N
	set_location_assignment PIN_A11 -to VGA_CLK
	set_location_assignment PIN_J9 -to VGA_G[0]
	set_location_assignment PIN_J10 -to VGA_G[1]
	set_location_assignment PIN_H12 -to VGA_G[2]
	set_location_assignment PIN_G10 -to VGA_G[3]
	set_location_assignment PIN_G11 -to VGA_G[4]
	set_location_assignment PIN_G12 -to VGA_G[5]
	set_location_assignment PIN_F11 -to VGA_G[6]
	set_location_assignment PIN_E11 -to VGA_G[7]
	set_location_assignment PIN_B11 -to VGA_HS
	set_location_assignment PIN_A13 -to VGA_R[0]
	set_location_assignment PIN_C13 -to VGA_R[1]
	set_location_assignment PIN_E13 -to VGA_R[2]
	set_location_assignment PIN_B12 -to VGA_R[3]
	set_location_assignment PIN_C12 -to VGA_R[4]
	set_location_assignment PIN_D12 -to VGA_R[5]
	set_location_assignment PIN_E12 -to VGA_R[6]
	set_location_assignment PIN_F13 -to VGA_R[7]
	set_location_assignment PIN_C10 -to VGA_SYNC_N
	set_location_assignment PIN_D11 -to VGA_VS
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_BLANK_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_HS -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_SYNC_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_VS -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_CONV_USB_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[9] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[13] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[14] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CAS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CKE -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_P -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[8] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[9] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[10] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[11] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[12] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[13] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[14] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[15] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[16] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[17] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[18] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[19] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[20] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[21] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[22] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[23] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[24] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[25] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[26] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[27] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[28] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[29] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[30] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[31] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ODT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RAS_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RESET_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RZQ -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_WE_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_GTX_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_INT_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDC -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_MDIO -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_RX_DV -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_ENET_TX_EN -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_DCLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_FLASH_NCSO -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GSENSOR_INT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SCLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C1_SDAT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C2_SCLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C2_SDAT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_I2C_CONTROL -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_KEY -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_LED -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_LTC_GPIO -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_CMD -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SD_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_CLK -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MISO -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_MOSI -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_SPIM_SS -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_RX -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_UART_TX -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_CLKOUT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[1] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[2] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[3] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[4] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[5] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[6] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DATA[7] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_DIR -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_NXT -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_USB_STP -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO[0] -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HPS_GPIO[1] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[0] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[10] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[11] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[12] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[13] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[14] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[1] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[2] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[3] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[4] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[5] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[6] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[7] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[8] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[9] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[0] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[1] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[2] -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CAS_N -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CKE -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CS_N -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ODT -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_RAS_N -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_WE_N -entity DE1_SoC
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_RESET_N -entity DE1_SoC
	set_instance_assignment -name D5_DELAY 2 -to HPS_DDR3_CK_P -entity DE1_SoC
	set_instance_assignment -name D5_DELAY 2 -to HPS_DDR3_CK_N -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[0] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[1] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[2] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[3] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[4] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[5] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[6] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[7] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[8] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[9] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[10] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[11] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[12] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[13] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[14] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[15] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[16] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[17] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[18] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[19] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[20] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[21] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[22] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[23] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[24] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[25] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[26] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[27] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[28] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[29] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[30] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[31] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[0] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[1] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[2] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[3] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[0] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[1] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[2] -entity DE1_SoC
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[3] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[0] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[1] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[2] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[3] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[4] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[5] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[6] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[7] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[8] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[9] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[10] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[11] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[12] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[13] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[14] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[15] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[16] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[17] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[18] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[19] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[20] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[21] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[22] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[23] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[24] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[25] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[26] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[27] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[28] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[29] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[30] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[31] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[0] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[1] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[2] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[3] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[0] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[1] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[2] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[3] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to HPS_DDR3_CK_P -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to HPS_DDR3_CK_N -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[0] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[1] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[2] -entity DE1_SoC
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[4] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[5] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[6] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[7] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[8] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[9] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[10] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[11] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[12] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[13] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[14] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[15] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[16] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[17] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[18] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[19] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[20] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[21] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[22] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[23] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[24] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[25] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[26] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[27] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[28] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[29] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[30] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[31] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[10] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[11] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[12] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[13] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[14] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[3] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[4] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[5] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[6] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[7] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[8] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[9] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[0] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[1] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[2] -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CAS_N -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CKE -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CS_N -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ODT -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_RAS_N -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_WE_N -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_RESET_N -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CK_P -entity DE1_SoC
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CK_N -entity DE1_SoC
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RZQ -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[0] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[0] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[1] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[1] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[2] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[2] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[3] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[3] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[3] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[4] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[4] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[4] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[5] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[5] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[5] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[6] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[6] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[6] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[7] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[7] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[7] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[8] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[8] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[8] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[9] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[9] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[9] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[10] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[10] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[10] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[11] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[11] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[11] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[12] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[12] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[12] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[13] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[13] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[13] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[14] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[14] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[14] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[15] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[15] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[15] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[16] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[16] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[16] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[17] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[17] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[17] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[18] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[18] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[18] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[19] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[19] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[19] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[20] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[20] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[20] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[21] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[21] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[21] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[22] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[22] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[22] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[23] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[23] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[23] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[24] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[24] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[24] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[25] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[25] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[25] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[26] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[26] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[26] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[27] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[27] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[27] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[28] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[28] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[28] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[29] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[29] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[29] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[30] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[30] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[30] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DQ[31] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[31] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQ[31] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
	set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_P -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to HPS_DDR3_CK_P -tag __hps_sdram_p0
	set_instance_assignment -name D5_DELAY 2 -to HPS_DDR3_CK_P -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to HPS_DDR3_CK_N -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to HPS_DDR3_CK_N -tag __hps_sdram_p0
	set_instance_assignment -name D5_DELAY 2 -to HPS_DDR3_CK_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[0] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[1] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_BA[2] -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_BA[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CAS_N -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CAS_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CKE -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CKE -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_CS_N -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_CS_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_ODT -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_ODT -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RAS_N -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_RAS_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_WE_N -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_WE_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_RESET_N -tag __hps_sdram_p0
	set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to HPS_DDR3_RESET_N -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[0] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[0] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[1] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[1] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[2] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[2] -tag __hps_sdram_p0
	set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to HPS_DDR3_DM[3] -tag __hps_sdram_p0
	set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to HPS_DDR3_DM[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[4] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[5] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[6] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[7] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[8] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[9] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[10] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[11] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[12] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[13] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[14] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[15] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[16] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[17] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[18] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[19] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[20] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[21] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[22] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[23] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[24] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[25] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[26] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[27] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[28] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[29] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[30] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQ[31] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DM[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_P[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_DQS_N[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[10] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[11] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[12] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[13] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[14] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[3] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[4] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[5] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[6] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[7] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[8] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ADDR[9] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[0] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[1] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_BA[2] -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CAS_N -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CKE -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CS_N -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_ODT -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_RAS_N -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_WE_N -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_RESET_N -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CK_P -tag __hps_sdram_p0
	set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to HPS_DDR3_CK_N -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_mem_stable_n -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_n -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[0].read_capture_clk_buffer -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[0] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[0] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[1].read_capture_clk_buffer -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[1] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[1] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[2].read_capture_clk_buffer -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[2] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[2] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[3].read_capture_clk_buffer -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[3] -tag __hps_sdram_p0
	set_instance_assignment -name GLOBAL_SIGNAL OFF -to u0|hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[3] -tag __hps_sdram_p0
	set_instance_assignment -name ENABLE_BENEFICIAL_SKEW_OPTIMIZATION_FOR_NON_GLOBAL_CLOCKS ON -to u0|hps_0|hps_io|border|hps_sdram_inst -tag __hps_sdram_p0
	set_instance_assignment -name PLL_COMPENSATION_MODE DIRECT -to u0|hps_0|hps_io|border|hps_sdram_inst|pll0|fbout -tag __hps_sdram_p0
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
