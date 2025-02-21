#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Jan 28 14:01:38 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.15-s110_1 (64bit) 09/23/2022 13:08 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.15-s110_1 NR220912-2004/21_15-UB (database version 18.20.592) {superthreading v2.17}
#@(#)CDS: AAE 21.15-s039 (64bit) 09/23/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.15-s038_1 () Sep 20 2022 11:42:13 ( )
#@(#)CDS: SYNTECH 21.15-s012_1 () Sep  5 2022 10:25:51 ( )
#@(#)CDS: CPE v21.15-s076
#@(#)CDS: IQuantus/TQuantus 21.1.1-s867 (64bit) Sun Jun 26 22:12:54 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

set design(TOPLEVEL) "lp_riscv_top"
set runtype "pnr"
set debug_file "debug.txt"
source ../scripts/procedures.tcl -quiet
enics_start_stage "start"
source ../inputs/$design(TOPLEVEL).defines -quiet
source $design(libraries_dir)/libraries.$TECHNOLOGY.tcl -quiet
source $design(libraries_dir)/libraries.$SC_TECHNOLOGY.tcl -quiet
source $design(libraries_dir)/libraries.$SRAM_TECHNOLOGY.tcl -quiet
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    source $design(libraries_dir)/libraries.$IO_TECHNOLOGY.tcl -quiet
}
set_library_unit -time 1ns -cap 1pf
set var_list {runtype}
set dic_list {paths tech tech_files design}
enics_print_debug_data w $debug_file "after everything was loaded" $var_list $dic_list
enable_metrics -on
enics_start_stage "init_design"
set_db init_ground_nets $design(all_ground_nets)
set_db init_power_nets $design(all_power_nets)
gui_select -point {0.05900 0.04400}
gui_select -point {0.08300 0.06800}
enics_message "Suppressing the following messages that are reported due to the LIB definitions:" 
enics_message "$tech(LIB_SUPPRESS_MESSAGES_INNOVUS)"
set_message -suppress -id $tech(LIB_SUPPRESS_MESSAGES_INNOVUS) 
enics_message "Reading MMMC File" medium
read_mmmc $design(mmmc_view_file) 
#@ Begin verbose source (pre): 
create_constraint_mode \
	-name functional_mode \
	-sdc_files $design(functional_sdc)
if {$runtype=="synthesis"} {...
} else {
set_message -suppress -id ENCEXT-6202 ;
}
create_rc_corner \
	-name bc_rc_corner \
	-temperature $tech(TEMPERATURE_BC) \
    -qrc_tech $tech_files(QRCTECH_FILE_BC)
create_rc_corner \
	-name tc_rc_corner \
	-temperature $tech(TEMPERATURE_TC) \
	-qrc_tech $tech_files(QRCTECH_FILE_TC)
create_rc_corner \
	-name wc_rc_corner \
	-temperature $tech(TEMPERATURE_WC) \
    -qrc_tech $tech_files(QRCTECH_FILE_WC)
create_library_set \
	-name bc_libset \
	-timing $tech_files(ALL_BC_LIBS)  
create_library_set \
	-name tc_libset \
	-timing $tech_files(ALL_TC_LIBS)  
create_library_set \
	-name wc_libset \
	-timing $tech_files(ALL_WC_LIBS)  
create_timing_condition \
   -name         bc_timing_condition \
   -library_sets bc_libset
create_timing_condition \
   -name         tc_timing_condition \
   -library_sets tc_libset
create_timing_condition \
   -name         wc_timing_condition \
   -library_sets wc_libset
create_delay_corner \
	-name bc_dly_corner \
	-timing_condition bc_timing_condition \
	-rc_corner bc_rc_corner
create_delay_corner \
	-name tc_dly_corner \
	-timing_condition tc_timing_condition \
	-rc_corner tc_rc_corner
create_delay_corner \
	-name wc_dly_corner \
	-timing_condition wc_timing_condition \
	-rc_corner wc_rc_corner
create_analysis_view \
	-name bc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner bc_dly_corner
create_analysis_view \
    -name tc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner tc_dly_corner
create_analysis_view \
	-name wc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner wc_dly_corner
set_analysis_view \
	-setup $design(selected_setup_analysis_views) \
	-hold  $design(selected_hold_analysis_views)
#@ End verbose source: /data/project/tsmc65/users/saridav/ws/DVD25/hw7/workspace/../inputs/lp_riscv_top.mmmc
enics_message "Suppressing the following messages that are reported due to the LEF definitions:" 
enics_message "$tech(LEF_SUPPRESS_MESSAGES_INNOVUS)"
set_message -suppress -id $tech(LEF_SUPPRESS_MESSAGES_INNOVUS) 
enics_message "Reading LEF abstracts"
read_physical -lef $tech_files(ALL_LEFS)
enics_message "Reading the Post Synthesis netlist at $design(postsyn_netlist)" medium
read_netlist $design(postsyn_netlist)
enics_message "Running init_design command" medium
init_design
gui_select -point {1528.91300 215.93450}
gui_select -point {1840.13000 190.21400}
gui_select -point {1580.35400 131.05700}
gui_select -point {1464.61200 239.08300}
gui_select -point {2804.64600 210.79050}
gui_select -point {2233.65300 195.35800}
gui_select -point {2827.79450 218.50650}
gui_select -point {1616.36250 303.38400}
gui_select -point {150.29750 1267.90050}
gui_select -rect {1107.09850 658.32600 1652.37200 185.06950}
gui_select -point {268.61150 1149.58650}
gui_select -point {1768.11400 118.19650}
gui_select -point {2012.45800 -5.26150}
gui_select -point {1994.45400 -5.26150}
gui_select -point {2012.45800 -2.68950}
gui_select -rect {-40.03350 1375.92650 278.90000 1157.30250}
gui_select -point {-122.33900 1370.78250}
gui_select -rect {201.73850 1370.78250 67.99200 1208.74350}
gui_select -point {-155.77550 1303.90900}
gui_select -rect {224.88700 1298.76500 183.73400 1324.48550}
gui_select -rect {163.15800 1324.48550 -510.71800 1530.24900}
gui_select -point {145.69900 1339.05600}
gui_select -point {112.08750 1357.15450}
gui_select -point {145.37600 1304.15150}
gui_select -point {221.97150 1275.71100}
gui_select -point {154.74850 1274.41850}
gui_select -point {308.26300 1282.49800}
gui_select -point {397.30100 1256.31950}
gui_select -point {163.47450 1269.57050}
gui_select -point {-832.10750 528.14350}
gui_select -point {-835.96450 789.80300}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {7.7165 5.1445 127.7165 125.1445}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {1232.008 1221.72 1352.008 1341.72}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f20e0 -rects {1201.144 10.2885 1321.144 130.2885}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2070 -rects {7.7165 1219.148 127.7165 1339.148}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {1497.4835 671.955 1617.4835 791.955}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {751.5915 908.583 871.5915 1028.583}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {-4.589 -32.7845 115.411 87.2155}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {5.699 0.652 125.699 120.652}
gui_select -point {49.98900 74.47200}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {1216.5755 10.288 1336.5755 130.288}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2000 -rects {1214.004 1221.72 1334.004 1341.72}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {13.4155 -10.288 133.4155 109.712}
update_floorplan_obj -obj 0x7f17dc2f2150 -rects {8.271 5.144 128.271 125.144}
gui_deselect -all
gui_select -point {67.99350 51.32400}
gui_select -point {1263.99300 77.04450}
gui_select -point {870.47050 408.83750}
gui_select -point {1554.63350 828.08050}
gui_select -point {1510.90900 1131.58150}
gui_select -point {1263.99300 1183.02250}
gui_select -point {1292.28550 1103.28900}
gui_select -point {1292.28550 1126.43750}
gui_select -point {873.04250 61.61200}
gui_select -point {55.13300 846.08500}
gui_select -point {47.41700 861.51700}
gui_select -point {57.70500 1175.30600}
gui_select -point {57.70500 1121.29350}
gui_select -point {52.56100 1044.13200}
gui_select -point {52.56100 977.25900}
gui_select -point {26.84050 565.73250}
gui_select -point {73.13750 612.02900}
gui_select -point {70.56550 658.32600}
gui_select -point {52.56100 756.06350}
gui_select -point {52.56100 804.93200}
gui_select -point {57.70500 861.51700}
gui_select -point {62.84950 941.25050}
gui_select -point {62.84950 1002.97950}
gui_select -point {49.98900 1062.13650}
gui_select -point {49.98900 1136.72550}
gui_select -point {67.99350 462.85050}
gui_select -point {60.27750 393.40550}
gui_select -point {62.84950 388.26150}
gui_select -point {52.56100 416.55400}
gui_select -point {52.56100 336.82050}
gui_select -point {52.56100 287.95150}
gui_select -point {65.42150 236.51100}
gui_select -point {85.99750 156.77750}
gui_select -point {55.13300 884.66550}
gui_select -point {1665.23150 1406.79000}
gui_select -point {1297.42950 1069.85250}
gui_select -point {1281.99700 1105.86100}
gui_select -point {1300.00150 1201.02650}
gui_select -point {1284.56950 1000.40750}
gui_select -point {1287.14150 918.10200}
gui_select -point {1287.14150 1185.59450}
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {3.127 485.637 123.127 535.637}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2b60 -rects {1208.86 1155.9765 1328.86 1205.9765}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {2.5725 580.8005 122.5725 630.8005}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ab0 -rects {3.127 495.7215 123.127 545.7215}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2bd0 -rects {1214.004 649.673 1334.004 699.673}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ab0 -rects {0.0 637.182 120.0 687.182}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f24d0 -rects {1288.91 360.738 1338.91 480.738}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3b90 -rects {530.3955 1264.808 650.3955 1314.808}
gui_select -point {34.55700 594.02450}
gui_select -point {1701.24000 627.46150}
source ../scripts/settings.tcl -quiet
enics_default_cost_groups
enics_message "Connecting Global Nets" medium
connect_global_net $design(digital_gnd) -pin $tech(STANDARD_CELL_GND) -all -verbose
connect_global_net $design(digital_vdd) -pin $tech(STANDARD_CELL_VDD) -all -verbose
connect_global_net $design(digital_vdd) -type tiehi -all -verbose 
connect_global_net $design(digital_gnd) -type tielo -all -verbose 
connect_global_net $design(digital_vdd) -pin $tech(SRAM_VDDCORE_PIN)      -all -verbose 
connect_global_net $design(digital_vdd) -pin $tech(SRAM_VDDPERIPHERY_PIN) -all -verbose 
connect_global_net $design(digital_gnd) -pin $tech(SRAM_GND_PIN)          -all -verbose 
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    # Connect pads to IO and CORE voltages
    #    -netlist_override is needed, since GENUS connects these pins to UNCONNECTED during synthesis
    connect_global_net $design(io_vdd)      -pin $tech(IO_VDDIO)   -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(io_gnd)      -pin $tech(IO_GNDIO)   -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(digital_vdd) -pin $tech(IO_VDDCORE) -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(digital_gnd) -pin $tech(IO_GNDCORE) -hinst i_${design(IO_MODULE)} -netlist_override -verbose
}
enics_create_stage_reports -save_db no -report_timing no -pop_snapshot yes
gui_select -point {2168.06600 241.65500}
gui_select -point {187.59350 1255.03950}
gui_select -point {197.88150 1262.75550}
gui_select -point {167.01700 1278.18800}
gui_select -point {1481.33050 249.37100}
gui_select -point {2991.11950 95.04850}
gui_select -point {2240.08300 105.33700}
gui_select -point {149.01300 1260.18350}
gui_select -point {1568.78000 161.92150}
gui_select -point {2705.62250 285.37950}
gui_select -point {2286.38000 105.33700}
gui_select -point {159.30100 1252.46750}
gui_select -point {1316.72000 666.04200}
gui_select -point {1278.13950 735.48700}
gui_select -point {1285.85550 1121.29350}
gui_select -point {1288.42750 1085.28500}
gui_select -point {1283.28350 1002.97950}
gui_select -point {1288.42750 930.96200}
gui_select -point {1293.57150 861.51700}
gui_select -point {1272.99500 776.63950}
gui_select -point {1272.99500 730.34300}
gui_select -point {1285.85550 1167.59000}
gui_select -point {1278.13950 1170.16200}
gui_select -point {-79.89900 750.91950}
gui_select -rect {-683.04300 689.19050 -541.58050 807.50400}
gui_select -point {-510.71600 756.06350}
gui_select -point {1307.71750 30.74750}
gui_select -point {1253.70500 1296.19200}
gui_select -point {1207.40800 1291.04800}
gui_select -point {1135.39100 1273.04400}
gui_select -point {-294.66450 789.50000}
gui_select -point {168.30300 547.72800}
gui_select -point {93.71400 532.29550}
gui_select -point {85.99750 596.59700}
gui_select -point {70.56550 663.47000}
gui_select -point {67.99350 743.20300}
gui_select -point {62.84950 802.36000}
gui_select -point {75.70950 861.51700}
gui_select -point {65.42150 1008.12350}
gui_select -point {78.28150 1049.27600}
gui_select -point {67.99350 1005.55150}
gui_select -point {88.56950 1098.14500}
gui_select -point {88.56950 1126.43750}
gui_select -point {85.99750 1177.87850}
gui_select -point {-112.04950 586.30850}
gui_select -point {753.44250 529.72350}
gui_select -point {-95.33100 776.63950}
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {122.239 110.598 1224.292 1210.619}
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {119.628 113.572 1221.628 1213.372}
gui_select -point {694.28600 59.04000}
gui_select -point {619.69650 51.32400}
gui_select -point {249.32250 889.80950}
gui_select -point {35.84300 540.01200}
gui_select -point {64.13550 504.00350}
gui_select -point {82.14000 534.86800}
gui_select -point {76.99550 401.12150}
gui_select -point {64.13550 344.53650}
gui_select -point {46.13100 298.24000}
gui_select -point {33.27100 192.78600}
gui_select -point {53.84750 177.35400}
gui_select -point {69.27950 223.65050}
gui_select -point {58.99150 930.96200}
gui_select -point {241.60650 1306.48050}
gui_select -point {318.76750 1288.47600}
gui_select -point {583.68800 1280.76000}
gui_select -point {761.15900 1270.47200}
gui_select -point {1198.40600 1280.76000}
gui_select -point {748.29850 82.18850}
gui_select -point {683.99750 74.47200}
gui_select -point {599.12000 53.89600}
gui_select -point {552.82350 43.60750}
gui_select -point {496.23850 41.03550}
gui_select -point {444.79750 43.60750}
gui_select -point {437.08150 43.60750}
gui_select -point {40.98700 599.16900}
gui_select -point {286.08700 977.41050}
gui_select -point {2340.69500 220.92750}
update_floorplan_obj -obj 0x7f17dc305f60 -rects {1360.431 -9.0775 2570.261 306.2875}
gui_select -point {2334.64300 169.48650}
gui_select -point {2310.43550 226.97900}
gui_select -point {2325.56550 190.66800}
gui_select -point {2370.95450 166.46050}
gui_select -point {2897.46650 124.09750}
gui_select -point {1684.06750 148.30500}
gui_select -point {2948.90750 145.27900}
gui_select -point {313.32050 723.23200}
gui_select -point {-175.36750 699.02450}
gui_select -point {2094.08150 136.20100}
enics_start_stage "floorplan"
source ../inputs/$design(TOPLEVEL).floorplan.defines -quiet
create_floorplan \
    -core_size [list 2500.0 1500.0 150.0 150.0 150.0 150.0] \
    -core_margins_by die \
    -flip s \
    -match_to_site
gui_select -rect {2403.82200 227.90600 2358.90050 431.78000}
gui_fit
gui_select -point {1740.36650 1115.96850}
gui_select -point {2092.82750 1008.84800}
gui_select -point {-284.55500 1357.85350}
gui_select -point {1571.04700 376.49200}
gui_select -point {-567.90550 1157.43450}
gui_select -point {492.93200 556.17800}
gui_select -point {1781.83250 652.93200}
gui_select -point {3036.17800 338.48150}
gui_select -point {3008.53400 227.90600}
gui_select -point {3005.07850 234.81700}
gui_fit
gui_select -rect {1837.12050 189.89550 223.40300 1178.16750}
gui_select -rect {309.79050 1019.21450 375.44500 1050.31400}
gui_select -point {-308.74350 1316.38750}
gui_select -point {368.53400 1029.58100}
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {789.9665 347.7735 1891.9665 1447.5735}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc305f60 -rects {-211.8215 543.7995 998.0085 859.1645}
flip_or_rotate_obj -rotate R90
update_floorplan_obj -obj 0x7f17dc305f60 -rects {171.7405 443.5905 487.1055 1653.4205}
update_floorplan_obj -obj 0x7f17dc305f60 -rects {154.4625 436.679 469.8275 1646.509}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc305ef0 -rects {650.6805 1292.356 1860.5105 1607.721}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {786.5445 171.7695 1888.5445 1271.5695}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc305f60 -rects {192.4705 388.303 507.8355 1598.133}
gui_deselect -all
gui_deselect -all
flip_or_rotate_obj -flip MX
flip_or_rotate_obj -flip MX
flip_or_rotate_obj -flip MY
update_floorplan_obj -obj 0x7f17dc305f60 -rects {1001.0565 422.86 1316.4215 1632.69}
update_floorplan_obj -obj 0x7f17dc305f60 -rects {-833.813 930.4725 -518.448 2140.3025}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc305ef0 -rects {567.748 687.6425 1777.578 1003.0075}
gui_select -point {1101.09950 825.36150}
gui_select -point {2089.37200 821.90600}
gui_select -point {838.48200 1461.17300}
gui_select -point {368.53400 1205.81150}
gui_select -point {1204.76450 1423.50800}
gui_select -point {1173.66500 1485.70700}
gui_select -point {313.24600 1185.07850}
gui_select -rect {292.51300 1067.59150 316.70150 967.38200}
gui_select -point {316.70150 967.38200}
gui_select -point {358.16750 1098.69100}
update_floorplan_obj -obj 0x7f17dc305f60 -rects {216.6585 364.1165 532.0235 1573.9465}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc305ef0 -rects {685.235 1313.088 1895.065 1628.453}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {765.867 188.8775 1867.867 1288.6775}
gui_select -point {1184.03150 1496.07350}
gui_select -point {950.24250 1322.68350}
gui_select -point {264.86900 842.98450}
gui_select -point {316.70150 1174.71200}
gui_select -point {320.15700 929.37150}
gui_select -rect {178.48200 1741.41350 64.45050 1620.47100}
gui_select -point {-167.06800 1475.34050}
gui_select -point {171.57100 1727.59150}
gui_select -point {-229.26700 1361.30900}
gui_select -point {271.78000 1368.22000}
gui_select -point {195.75900 1731.04700}
gui_select -point {392.72250 1354.39800}
gui_select -point {990.52350 974.29300}
gui_select -rect {185.39300 1717.22500 161.20450 1686.12550}
gui_select -point {185.39300 1734.50250}
gui_select -rect {123.19400 1872.72250 223.40300 1651.57050}
gui_select -point {-160.15700 1468.42950}
gui_select -point {949.05750 72.40850}
gui_select -point {821.20450 55.13100}
gui_select -point {81.72800 1122.87950}
gui_select -point {81.72800 1160.89000}
gui_select -point {178.48200 1713.76950}
gui_select -point {261.41350 1779.42400}
gui_select -point {375.44500 1706.85850}
gui_select -point {2759.73850 1112.51300}
gui_select -point {2739.00550 1053.76950}
gui_select -point {2749.37200 1095.23550}
gui_select -point {2745.91650 1157.43450}
gui_select -point {2742.46100 1233.45550}
gui_select -point {2732.09450 1333.66500}
gui_select -point {2728.63900 1406.23050}
gui_select -point {2742.46100 1319.84300}
gui_select -point {181.93750 1769.05750}
update_floorplan_obj -obj 0x7f17dc5f24a0 -rects {-1342.0535 338.1865 -240.0535 1437.9865}
gui_select -point {-422.77500 2000.57550}
gui_select -point {399.63350 981.20400}
gui_select -point {1170.20950 1430.41850}
gui_select -point {420.36650 846.43950}
gui_select -point {952.51300 1451.15150}
gui_select -point {309.79050 756.59650}
gui_select -point {1412.09450 1375.13050}
gui_select -point {403.08900 811.88450}
gui_select -point {1142.56550 2045.49700}
gui_select -point {181.93750 1706.85850}
gui_select -point {178.38350 1764.34100}
gui_select -point {163.80450 1762.52150}
update_floorplan_obj -obj 0x7f17dc2f22a0 -rects {1494.8685 1680.0 1544.8685 1800.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3d50 -rects {1707.151 1749.314 1827.151 1799.314}
update_floorplan_obj -obj 0x7f17dc2f3d50 -rects {1715.8365 1680.0 1765.8365 1800.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ce0 -rects {0.6115 1062.2995 120.6115 1112.2995}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {0.0 1526.5035 120.0 1576.5035}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2d90 -rects {2.773 1332.03 122.773 1382.03}
update_floorplan_obj -obj 0x7f17dc2f2d90 -rects {1.703 1332.03 121.703 1382.03}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {-1.7035 1528.208 118.2965 1578.208}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3b20 -rects {1121.942 3.6955 1241.942 53.6955}
update_floorplan_obj -obj 0x7f17dc2f3b20 -rects {1149.191 0.0 1199.191 120.0}
gui_deselect -all
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3b90 -rects {2680.0 731.8375 2800.0 781.8375}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3c00 -rects {2678.297 856.94 2798.297 906.94}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f39d0 -rects {2678.297 945.302 2798.297 995.302}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3c70 -rects {2681.7035 1237.5125 2801.7035 1287.5125}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2b60 -rects {2680.0 1140.6465 2800.0 1190.6465}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f39d0 -rects {1159.2415 1749.195 1279.2415 1799.195}
update_floorplan_obj -obj 0x7f17dc2f39d0 -rects {1219.285 1680.217 1269.285 1800.217}
gui_select -point {1255.73350 1444.13700}
gui_select -point {843.20000 1741.16100}
gui_select -point {411.80800 1092.89450}
gui_select -point {447.16800 918.45200}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3b20 -rects {1298.3015 1.775 1348.3015 121.775}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3420 -rects {1638.373 0.0 1688.373 120.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3960 -rects {1653.9715 5.82 1773.9715 55.82}
update_floorplan_obj -obj 0x7f17dc2f3960 -rects {1714.3245 -1.775 1764.3245 118.225}
update_floorplan_obj -obj 0x7f17dc2f3960 -rects {1732.076 1.775 1782.076 121.775}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3b90 -rects {2680.0 767.3375 2800.0 817.3375}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f38f0 -rects {-1.876 589.0005 118.124 639.0005}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2af0 -rects {1831.763 -4.555 1951.763 45.445}
update_floorplan_obj -obj 0x7f17dc2f2af0 -rects {2004.1285 -1.004 2124.1285 48.996}
update_floorplan_obj -obj 0x7f17dc2f2af0 -rects {1885.1945 0.7705 2005.1945 50.7705}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2bd0 -rects {-3.55 622.0675 116.45 672.0675}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2c40 -rects {3.55 585.086 123.55 635.086}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2cb0 -rects {-1.775 720.2925 118.225 770.2925}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2d90 -rects {1989.9275 1.5655 2109.9275 51.5655}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3500 -rects {1456.187 0.0 1506.187 120.0}
gui_deselect -all
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f38f0 -rects {2678.225 936.04 2798.225 986.04}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3880 -rects {2665.799 565.086 2785.799 615.086}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2d20 -rects {1.7755 1359.638 121.7755 1409.638}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2cb0 -rects {-1.775 1236.857 118.225 1286.857}
update_floorplan_obj -obj 0x7f17dc2f2cb0 -rects {-1.775 1252.8335 118.225 1302.8335}
update_floorplan_obj -obj 0x7f17dc2f2cb0 -rects {0.0 1254.6085 120.0 1304.6085}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {-1.7755 806.6875 118.2245 856.6875}
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {0.0 764.084 120.0 814.084}
gui_select -point {59.74300 668.20200}
gui_select -point {2729.19250 945.12350}
update_floorplan_obj -obj 0x7f17dc2f38f0 -rects {0.0765 836.6325 120.0765 886.6325}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3c70 -rects {2682.457 1335.7875 2802.457 1385.7875}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2b60 -rects {3050.997 1290.518 3170.997 1340.518}
update_floorplan_obj -obj 0x7f17dc2f2b60 -rects {2680.0 1231.5515 2800.0 1281.5515}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3a40 -rects {2680.0 964.059 2800.0 1014.059}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3c70 -rects {2680.0 1070.436 2800.0 1120.436}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ab0 -rects {1262.3485 1751.7495 1382.3485 1801.7495}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f39d0 -rects {1261.053 1675.086 1311.053 1795.086}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ab0 -rects {935.5775 1677.543 985.5775 1797.543}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3880 -rects {2680.0 686.2765 2800.0 736.2765}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3810 -rects {2674.363 603.918 2794.363 653.918}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f37a0 -rects {2680.0 533.9845 2800.0 583.9845}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2b60 -rects {2680.0 1141.3605 2800.0 1191.3605}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2a80 -rects {2680.3115 455.9535 2800.3115 505.9535}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2a10 -rects {2680.311 385.992 2800.311 435.992}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f29a0 -rects {2680.311 321.667 2800.311 371.667}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2930 -rects {2674.6745 260.161 2794.6745 310.161}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3730 -rects {2682.8185 1306.7565 2802.8185 1356.7565}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f28c0 -rects {2680.311 198.6545 2800.311 248.6545}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2850 -rects {2685.9475 537.3625 2805.9475 587.3625}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f37a0 -rects {2680.0 911.952 2800.0 961.952}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2f50 -rects {1118.628 3.101 1238.628 53.101}
update_floorplan_obj -obj 0x7f17dc2f2f50 -rects {1161.988 0.0 1211.988 120.0}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2c40 -rects {0.0 319.158 120.0 369.158}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2bd0 -rects {0.0 441.2375 120.0 491.2375}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3e30 -rects {2.8905 550.187 122.8905 600.187}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f38f0 -rects {0.0 631.404 120.0 681.404}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2e00 -rects {0.0 775.0625 120.0 825.0625}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2e70 -rects {0.0 868.42 120.0 918.42}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2ee0 -rects {0.0 961.778 120.0 1011.778}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3ce0 -rects {2.8905 1157.6865 122.8905 1207.6865}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f24d0 -rects {2047.063 1680.0 2097.063 1800.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3570 -rects {1.489 176.3215 51.489 296.3215}
update_floorplan_obj -obj 0x7f17dc2f3570 -rects {2.8905 693.7215 122.8905 743.7215}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f35e0 -rects {1424.095 1679.387 1474.095 1799.387}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3650 -rects {2751.314 1173.5475 2801.314 1293.5475}
update_floorplan_obj -obj 0x7f17dc2f3650 -rects {2677.1095 1228.4645 2797.1095 1278.4645}
gui_deselect -all
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3650 -rects {991.942 5.779 1111.942 55.779}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3180 -rects {855.7005 2.8905 905.7005 122.8905}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3110 -rects {664.4525 2.8905 714.4525 122.8905}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f31f0 -rects {772.3505 -2.8905 822.3505 117.1095}
update_floorplan_obj -obj 0x7f17dc2f31f0 -rects {769.46 5.781 819.46 125.781}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f30a0 -rects {557.029 0.0 607.029 120.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f3030 -rects {469.839 0.0 519.839 120.0}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2fc0 -rects {365.3065 2.8905 415.3065 122.8905}
gui_deselect -all
update_floorplan_obj -obj 0x7f17dc2f2310 -rects {646.163 1682.8905 696.163 1802.8905}
gui_select -point {852.24800 1748.36500}
gui_select -point {2034.46700 545.91250}
write_io_file -locations ../inputs/ioring.io
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
enics_message "Defining IO Ring" medium
# Reload the IO file after resizing the floorplan
read_io_file $design(io_file)
# Add IO Fillers
add_io_fillers -cells $tech(IO_FILLERS) -prefix IOFILLER
# Connect Pad Rings
#route_special -connect {pad_ring} \
#-nets "$design(digital_gnd) $design(digital_vdd) $design(io_gnd) $design(io_vdd)"
} elseif {$design(FULLCHIP_OR_MACRO)=="MACRO"} {
enics_message "Spreading Pins around Macro" medium
    # Spread pins
set pins_to_spread  [get_db ports .name] ;#[get_object_name [get_ports]]
#edit_pin -fix_overlap 1 -spread_direction clockwise -side Bottom -layer 4 -spread_type side 
edit_pin -spread_type start -start {0 0} -spread_direction clockwise -layer {3 4}  \
        -pin $pins_to_spread -fix_overlap 1 -spacing 6

}
gui_select -point {2890.05800 956.36500}
gui_select -point {1887.05100 2040.30650}
gui_select -point {-191.22650 1771.48900}
gui_select -point {3138.64200 794.49650}
check_legacy_design -all -out_dir $design(reports_dir)/$this_run(stage)
delete_relative_floorplan -all
set imem0_name [get_db [get_db insts $design(imem0)] .name]
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $imem0_name \
    -horizontal_edge_separate {0  25  0} \
    -vertical_edge_separate {1  25  1} -orient MX
set imem1_name [get_db [get_db insts $design(imem1)] .name]
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $imem1_name \
         -horizontal_edge_separate { 1 -25 1 } \
         -vertical_edge_separate { 1 25 1 } -orient R0
set dmem0_name [get_db [get_db insts $design(dmem0)] .name]
set dmem1_name [get_db [get_db insts $design(dmem1)] .name]
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $dmem0_name \
    -horizontal_edge_separate {0  25  0} \
    -vertical_edge_separate {2  -25  2} -orient MX
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $dmem1_name \
    -horizontal_edge_separate {1  -25  1} \
    -vertical_edge_separate {2  -25  2} -orient R0
gui_select -point {1383.16950 488.74750}
gui_select -point {646.45350 1080.32550}
gui_select -point {419.55350 335.13850}
gui_select -point {581.96650 1445.75400}
gui_select -point {1105.03000 865.36800}
gui_select -point {1162.35250 1464.86150}
gui_select -point {331.18200 1302.44850}
gui_select -point {219.74900 1831.29500}
gui_select -point {227.93700 1766.35500}
gui_select -point {249.67750 1784.14300}
gui_select -point {249.96000 1691.53350}
gui_select -point {268.87700 1772.84900}
gui_select -point {225.96050 1776.51950}
gui_select -point {245.44250 1777.64900}
gui_select -point {289.20600 1754.21450}
gui_select -point {242.33650 1728.80300}
gui_select -point {331.27550 1760.70850}
gui_select -point {312.92300 1758.73200}
gui_select -point {308.40550 1757.32000}
gui_select -point {289.77050 1752.80250}
gui_select -point {249.97600 1839.84300}
edit_move_routes -dx -24.556 -dy -10.464
gui_deselect -all
edit_move_routes -dx 10.528 -dy -1.8715
gui_deselect -all
edit_move_routes -dx -18.716 -dy -46.5565
gui_select -rect {214.66100 1810.64850 320.58200 1675.56350}
set_layer_preference violation -is_visible 1
gui_select -point {263.14750 1812.42000}
gui_select -rect {202.20750 1835.06650 343.12450 1648.76950}
gui_select -point {252.53650 1750.20500}
gui_select -point {277.28900 1762.36450}
gui_select -point {248.19400 1743.54650}
select_obj IO inst i_ioring/i_CLOCK_EN
update_floorplan_obj -obj 0x7f1807a68200 -rects {645.142 1679.505 695.142 1799.505}
update_floorplan_obj -obj 0x7f17dc2f2310 -rects {645.142 1679.505 695.142 1799.505}
edit_move_routes -dx 412.32 -dy 0.0
update_floorplan_obj -obj 0x7f1807a68200 -rects {645.975 1680.0 695.975 1800.0}
update_floorplan_obj -obj 0x7f17dc2f2310 -rects {645.975 1680.0 695.975 1800.0}
edit_move_routes -dx 0.835 -dy 0.0
set dmem0_name [get_db [get_db insts $design(dmem0)] .name]
set dmem1_name [get_db [get_db insts $design(dmem1)] .name]
gui_select -point {1023.82400 1436.20000}
gui_select -point {388.50450 1204.52350}
gui_select -point {1045.31950 1457.69600}
gui_select -point {426.71900 819.98800}
gui_select -point {1511.06150 1522.18350}
gui_select -point {352.67800 1008.67300}
gui_select -point {304.90950 951.35100}
gui_select -point {1367.75650 1548.45600}
gui_select -point {364.62000 1230.79600}
gui_select -point {1090.69950 1488.74550}
gui_select -point {433.88400 1302.44850}
gui_select -point {1546.88800 1483.96850}
gui_select -point {1119.36050 1421.86950}
gui_select -point {419.55350 1257.06900}
gui_select -point {1109.80700 1381.26650}
gui_select -point {1009.49350 1481.58000}
gui_select -point {400.44650 1190.19300}
gui_select -point {1140.85650 1409.92750}
gui_select -point {402.83500 970.45850}
gui_select -point {1181.45950 1460.08450}
gui_select -point {925.89850 1448.14250}
gui_select -point {355.06650 1097.04450}
gui_select -point {1303.26900 1421.86950}
gui_select -point {980.83250 1467.24950}
gui_select -point {402.83500 1190.19300}
gui_select -append -point {400.44650 1235.57300}
gui_select -append -point {1651.97850 1383.65500}
gui_select -append -point {949.78300 1515.01800}
gui_select -append -point {1472.84700 53.30500}
gui_select -append -point {1828.72150 1546.06750}
gui_select -point {281.02550 1512.62950}
gui_select -point {460.15700 1075.54900}
gui_select -point {1647.20150 1343.05200}
gui_select -point {1694.97000 1108.98650}
gui_select -point {331.18200 428.28700}
gui_select -point {1193.40150 540.54300}
gui_select -point {2750.65150 1620.10850}
gui_select -point {2750.65150 1574.72850}
gui_select -point {2750.65150 1414.70450}
gui_select -point {2745.87450 1233.18450}
gui_select -point {2366.11600 7.92500}
gui_select -point {2220.42200 36.58600}
gui_select -point {2318.34750 1710.86850}
gui_select -point {923.51050 1734.75250}
gui_select -point {2741.09800 554.87350}
gui_select -point {2741.09800 480.83250}
gui_select -point {2750.65150 366.18800}
gui_select -point {2753.04000 289.75850}
gui_select -point {335.95900 1751.47150}
gui_select -point {964.11250 1479.19150}
gui_select -rect {1083.53350 1462.47250 1133.69000 1354.99350}
gui_select -point {386.11500 1147.20100}
gui_select -rect {1790.50550 418.73300 1678.25000 445.00550}
gui_select -point {2091.44650 478.44350}
gui_select -point {238.03300 1753.38200}
gui_select -point {249.97500 1750.99350}
gui_select -point {288.18950 1748.60550}
gui_select -point {887.68300 1399.89600}
gui_select -point {300.13150 1261.36750}
write_io_file -locations ../inputs/ioring.io
write_floorplan ../inputs/lp_riscv_top.fp
gui_select -point {-528.65000 2013.72000}
global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.8
write_def -floorplan ../export/lp_riscv_top.floorplan.def
set dbgLefDefOutVersion 5.8
write_def -floorplan -no_std_cells "$design(floorplan_def)"
