# RST
set_property PACKAGE_PIN B6 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# Global Clock
set_property PACKAGE_PIN G11 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Buzz
set_property PACKAGE_PIN L5 [get_ports buz]
set_property IOSTANDARD LVCMOS33 [get_ports buz]

# Key
set_property PACKAGE_PIN M5 [get_ports {key_in[0]}]
set_property PACKAGE_PIN M4 [get_ports {key_in[1]}]
set_property PACKAGE_PIN P5 [get_ports {key_in[2]}]
set_property PACKAGE_PIN N4 [get_ports {key_in[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {key_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[3]}]

# LED
# set_property PACKAGE_PIN P11 [get_ports {led[7]}]
# set_property PACKAGE_PIN P10 [get_ports {led[6]}]
# set_property PACKAGE_PIN N11 [get_ports {led[5]}]
# set_property PACKAGE_PIN N10 [get_ports {led[4]}]
# set_property PACKAGE_PIN P13 [get_ports {led[3]}]
# set_property PACKAGE_PIN P12 [get_ports {led[2]}]
# set_property PACKAGE_PIN M14 [get_ports {led[1]}]
# set_property PACKAGE_PIN N14 [get_ports {led[0]}]

# set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

