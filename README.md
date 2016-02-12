# scad-lx

### woofer_adapter.scad
Connects the rubber coupler to the woofer and fullrange diffuser. Has holes for #6 machine screw mount of driver with a gasket. Wire hole must be sealed. Dimesions are derived in part from dimensions of rubber coupler defined in plumbing.scad.

![woofer_adapter](/images/woofer_adapter.png)

### base.scad
Connects to the bottom of the woofer pipe and has 3 or more legs with holes for insetings threaded inserts for adjustable feet. Has an opening underneath for accessing the interior of the pipe and is closed by a terminal cups. Unless your printer has an enormous bed, the ring and legs will have to be printed separately. Should be printed upside down.

![base](/images/base.png)

### fullrange_adapter.scad
Mounts the fullrange driver to the diffuser. Openings behind the driver allow sound to propagate to the rear.

![fullrange_adapter](/images/fullrange_adapter.png)

### fullrange_cap.scad
Caps the rear end of the diffuser.

![fullrange_cap](/images/fullrange_cap.png)

### terminal_cup.scad
Closes the bottom of the base and has recesses and mounts for banana plugs. If a SpeakON connector is mounted on the woofer pipe, then the banana plugs are not necessary and the cup should be printed flat.

![terminal_cup](/images/terminal_cup.png)

### woofer_cover.scad
A cover which fits over the woofer adapter and protects the woofer from damage. Not intended to be used operationaly. Has a configurable logo. Should be printed upside down. (I have never printed one of these)

### cradle.scad
Deprecated. The woofer adapter mounts directly to the diffuser now.

### lx.scad
Critical dimensions of SL design and drivers.

### plumbing.scad
ABS pipe and the rubber connector.

### util.scad
Generic utility modules.

## Notes
These models are all parametric. Pretty well anything is configurable including the number of legs on the base. The ABS pipe and rubber coupler should be purchased and measured amd their dimensions set before printing. I started my prints and aborted them after a few layers to make sure there was a tight fit to the ABS pipes. Parameters are defined at the top of each file, after the includes. Modules follow, and are ordered from highest assembly to lowest. The call to the top level module might need uncommenting if the file is drawing nothing (immediatly after includes). If the file is included, you might want to comment out these calls to prevent it from being drawn. There are not .stl files here. OpenSCAD exports stl for printing.






