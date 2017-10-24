:: generate qsys
%MY_QUARTUS_PATH%/../sopc_builder/bin/qsys-generate ../libASP/grpPlatform/unitPlatformHps/synlayQuartus/Platform.qsys -syn=VHDL -od=./Platform -sp=../libASP/**/*,$

:: create project
quartus_sh -t PlatformHps.tcl

:: start synlay
quartus_sh -t synlay.tcl

pause