if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name default_emulate_libset_max\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sc9_cln65lp_base_rvt_ss_typical_max_0p90v_125c.lib\
    ${::IMEX::libVar}/mmmc/sc9_cln65lp_base_lvt_ss_typical_max_0p90v_125c.lib\
    ${::IMEX::libVar}/mmmc/sc9_cln65lp_base_hvt_ss_typical_max_0p90v_125c.lib\
    ${::IMEX::libVar}/mmmc/sp_hde_32768_m32_ss_1p08v_1p08v_125c.lib\
    ${::IMEX::libVar}/mmmc/sp_hde_16384_m32_ss_1p08v_1p08v_125c.lib\
    ${::IMEX::libVar}/mmmc/tpdn65lpnv2od3wc.lib]
create_opcond -name default_emulate_opcond -process 1 -voltage 0.899999 -temperature 125
create_timing_condition -name default_emulate_timing_cond_max\
   -library_sets [list default_emulate_libset_max]\
   -opcond default_emulate_opcond
create_rc_corner -name default_emulate_rc_corner\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -temperature 125
create_delay_corner -name default_emulate_delay_corner\
   -early_timing_condition {default_emulate_timing_cond_max}\
   -late_timing_condition {default_emulate_timing_cond_max}\
   -rc_corner default_emulate_rc_corner
create_constraint_mode -name default_emulate_constraint_mode\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name default_emulate_view -constraint_mode default_emulate_constraint_mode -delay_corner default_emulate_delay_corner
set_analysis_view -setup [list default_emulate_view] -hold [list default_emulate_view]
