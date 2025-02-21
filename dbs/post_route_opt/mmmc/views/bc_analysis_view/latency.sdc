set_clock_latency -source -early -min -rise  -0.796407 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -min -fall  -0.893396 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -max -rise  -0.796407 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -early -max -fall  -0.893396 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -min -rise  -0.796407 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -min -fall  -0.893396 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -max -rise  -0.796407 [get_ports {PAD_CLK}] -clock CLK 
set_clock_latency -source -late -max -fall  -0.893396 [get_ports {PAD_CLK}] -clock CLK 
