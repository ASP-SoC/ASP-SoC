QUARTUS=quartus_sh
QUARTUS_FLAGS=-t

QSYS_PROJECT_PATH=../libASP/grpPlatform/unitPlatformHps/synlayQuartus/Platform.qsys
QSYS_GEN=$(MY_QUARTUS_PATH)../sopc_builder/bin/qsys-generate
QSYS_FLAGS=-syn=VHDL -od=./Platform -sp=../libASP/**/*,$$

SynLayQuartus: PlatformHps.qsf
	$(QUARTUS) $(QUARTUS_FLAGS) PlatformHps.tcl
	$(QUARTUS) $(QUARTUS_FLAGS) synlay.tcl

PlatformHps.qsf:
	$(QSYS_GEN) $(QSYS_PROJECT_PATH) $(QSYS_FLAGS)

.PHONY: clean
clean:
	rm -rf Platform/ output_files/ db/ hps_isw_handoff/ incremental_db/ c5_pin_model_dump.txt hps_sdram_p0_summary.csv PlatformHps.qpf PlatformHps.qsf

