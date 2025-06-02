## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {LED_out[6]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {LED_out[5]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {LED_out[4]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {LED_out[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {LED_out[2]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {LED_out[1]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {LED_out[0]}]

#set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports dp]

set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {Anode_Activate[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {Anode_Activate[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {Anode_Activate[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {Anode_Activate[3]}]

## Pmod Header JA for Keypad
set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {cols[0]}];#Sch name = JA1
set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {cols[1]}];#Sch name = JA2
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {cols[2]}];#Sch name = JA3
set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {cols[3]}];#Sch name = JA4
set_property -dict { PACKAGE_PIN H1   IOSTANDARD LVCMOS33 } [get_ports {rows[0]}];#Sch name = JA7
set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports {rows[1]}];#Sch name = JA8
set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports {rows[2]}];#Sch name = JA9
set_property -dict { PACKAGE_PIN G3   IOSTANDARD LVCMOS33 } [get_ports {rows[3]}];#Sch name = JA10

## Pmod Header JB for Keypad
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports {cols[0]}];#Sch name = JB1
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports {cols[1]}];#Sch name = JB2
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports {cols[2]}];#Sch name = JB3
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports {cols[3]}];#Sch name = JB4
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports {rows[0]}];#Sch name = JB7
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports {rows[1]}];#Sch name = JB8
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports {rows[2]}];#Sch name = JB9
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports {rows[3]}];#Sch name = JB10

## Pmod Header JC for 2 digit 7 Segment Display
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[6]}];#Sch name = JC1
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[5]}];#Sch name = JC2
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[4]}];#Sch name = JC3
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[3]}];#Sch name = JC4
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[2]}];#Sch name = JC7
set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[1]}];#Sch name = JC8
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {SSD_LED_out[0]}];#Sch name = JC9
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {JC[7]}];#Sch name = JC10

##Pmod Header JXADC for activating 2 digit 7 Segment Display
set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports {SSD_Anode_Activate[0]}];#Sch name = XA1_P
set_property -dict { PACKAGE_PIN L3   IOSTANDARD LVCMOS33 } [get_ports {SSD_Anode_Activate[1]}];#Sch name = XA2_P
#set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[2]}];#Sch name = XA3_P
#set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[3]}];#Sch name = XA4_P
#set_property -dict { PACKAGE_PIN K3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[4]}];#Sch name = XA1_N
#set_property -dict { PACKAGE_PIN M3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[5]}];#Sch name = XA2_N
#set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[6]}];#Sch name = XA3_N
#set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[7]}];#Sch name = XA4_N

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
