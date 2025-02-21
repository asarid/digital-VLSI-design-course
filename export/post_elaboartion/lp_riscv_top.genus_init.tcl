################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 02/12/2025 09:09:47
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}

read_netlist /data/project/tsmc65/users/saridav/ws/DVD25/hw7/workspace/../export/post_elaboartion/lp_riscv_top.v

init_design -skip_sdc_read
