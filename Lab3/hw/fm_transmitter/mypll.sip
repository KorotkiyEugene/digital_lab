set_global_assignment -entity "mypll" -library "lib_mypll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "mypll" -library "lib_mypll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "mypll" -library "lib_mypll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_mypll" -name SPD_FILE [file join $::quartus(sip_path) "mypll.spd"]

set_global_assignment -library "lib_mypll" -name MISC_FILE [file join $::quartus(sip_path) "mypll_sim/mypll.vo"]
