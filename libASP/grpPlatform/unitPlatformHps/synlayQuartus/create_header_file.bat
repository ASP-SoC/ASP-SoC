if not exist "./header" mkdir "./header"
%MY_QUARTUS_PATH%/../sopc_builder/bin/sopcinfo2swinfo --input=Platform.sopcinfo --output=./header/Platform.swinfo
%MY_QUARTUS_PATH%/../sopc_builder/bin/swinfo2header --swinfo ./header/Platform.swinfo --output-dir ./header
pause