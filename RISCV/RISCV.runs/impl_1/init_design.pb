
x
Command: %s
53*	vivadotcl2G
3link_design -top display_top -part xc7a100tfgg484-12default:defaultZ4-113h px? 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px? 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2Q
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk.dcp2default:default2
UCLK2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2M
9d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/dram/dram.dcp2default:default2
dmem2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2Q
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/prgrom/prgrom.dcp2default:default2
imem2default:defaultZ1-454h px? 
h
-Analyzing %s Unisim elements for replacement
17*netlist2
27502default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
12default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2018.32default:defaultZ1-479h px? 
W
Loading part %s157*device2$
xc7a100tfgg484-12default:defaultZ21-403h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
?
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt2*
UCLK/inst/clkin1_ibufg2default:default2
clk_i2default:defaultZ31-35h px? 
?
?Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2 
IBUF_LOW_PWR2default:default2"
UCLK/clk_in12default:default2 
IBUF_LOW_PWR2default:default8Z18-550h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2Y
Cd:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc2default:default2
	UCLK/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2Y
Cd:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc2default:default2
	UCLK/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2S
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2
	UCLK/inst	2default:default8Z20-848h px? 
?
%Done setting XDC timing constraints.
35*timing2S
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2
572default:default8@Z38-35h px? 
?
Deriving generated clocks
2*timing2S
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2
572default:default8@Z38-2h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:132default:default2
00:00:132default:default2
1242.8632default:default2
577.8592default:defaultZ17-268h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2S
=d:/code/RISCV/RISCV/RISCV.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2
	UCLK/inst	2default:default8Z20-847h px? 
?
Parsing XDC File [%s]
179*designutils2R
<D:/code/RISCV/RISCV/RISCV.srcs/constrs_1/imports/XDC/pin.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2R
<D:/code/RISCV/RISCV/RISCV.srcs/constrs_1/imports/XDC/pin.xdc2default:default8Z20-178h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:012default:default2 
00:00:00.0302default:default2
1242.9302default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 2048 instances were transformed.
  RAM256X1S => RAM256X1S (MUXF7, MUXF7, MUXF8, RAMS64E, RAMS64E, RAMS64E, RAMS64E): 2048 instances
2default:defaultZ1-111h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
122default:default2
22default:default2
02default:default2
02default:defaultZ4-41h px? 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2!
link_design: 2default:default2
00:00:242default:default2
00:00:242default:default2
1242.9302default:default2
960.0782default:defaultZ17-268h px? 


End Record