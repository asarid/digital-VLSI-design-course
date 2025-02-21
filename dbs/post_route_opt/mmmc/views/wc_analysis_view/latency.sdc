set_clock_latency -source -early -min -rise  -1.91882 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -min -fall  -2.04611 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -max -rise  -1.91882 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -max -fall  -2.04611 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -min -rise  -1.91882 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -min -fall  -2.04611 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -max -rise  -1.91882 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -max -fall  -2.04611 [get_ports {PAD_CLK}] -clock CLK 
