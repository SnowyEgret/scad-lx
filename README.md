# scad-lx

Files:

## woofer_adapter.scad
Connects the rubber coupler to the woofer and fullrange diffuser.

![woofer_adapter](/images/woofer_adapter.png)

## base.scad
Connects to the bottom of the woofer pipe and has 3 or more legs with holes for insetings threaded inserts for adjustable feet. It has an opening underneath for accessing the interior of the pipe and is closed by a terminal cup with mounts for banana plugs.

![base](/images/base.png)

## fullrange_adapter.scad
Mounts the fullrange driver to the diffuser. Openings behind the driver allow sound to propagate to the rear.

![fullrange_adapter](/images/fullrange_adapter.png)

## fullrange_cap.scad
Caps the rear end of the diffuser.

![fullrange_cap](/images/fullrange_cap.png)

## terminal_cup.scad
Closes the bottom of the base and has holes and mounts for banana plugs. If a SpeakON connector is mounted on the woofer pipe, then the banana plugs are not necessary.

![terminal_cup](/images/terminal_cup.png)

## cradle.scad
Deprecated. The woofer adapter mounts directly to the diffuser now.

## plumbing.scad
Contains modules for abs pipe and the rubber connector.

![plumbing](/images/plumbing.png)

## util.scad
Generic utility modules.

## lx.scad
Critical dimensions of SL design and drivers.

![lx](/images/lx.png)

## IN GENERAL
All files are organized as such:

includes

modules to be drawn by this file (uncomment these for testing or exporting to .stl)
parameters (always defined at top of file - never within a module)

modules

The modules are ordered from highest assembly to lowest. If you do not find a module at the bottom of a file then it comes from an included file.






