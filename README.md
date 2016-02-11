# scad-lx

Files:

## woofer_adapter.scad
Connects the rubber coupler to the woofer and fullrange diffuser.

## base.scad
Connects to the bottom of the woofer pipe and has 3 or more legs with holes for insetings threaded inserts for adjustable feet. It has an opening underneath for accessing the interior of the pipe and is closed by a terminal cup with mounts for banana plugs.

## fullrange_adapter.scad
Mounts the fullrange driver to the diffuser. Openings behind the driver allow sound to propagate to the rear.
## fullrange_cap.scad
Caps the rear end of the diffuser
## terminal_cup.scad
Closes the bottom of the base and has holes and mounts for banana plugs. If a SpeakON connector is mounted on the woofer pipe, then the banana plugs are not necessary.

## cradle.scad
Deprecated. The woofer adapter mounts directly to the diffuser now.

## plumbing.scad
Contains modules for abs pipe and the rubber connector.

## util.scad
Generic utility modules.

## lx.scad
Drivers and all critical dimensions of SL design

IN GENERAL all files are organized as such:

includes
modules to be drawn by this file (uncomment these for testing or exporting to .stl)
parameters (always defined at top of file - never within a module)
modules

The modules are ordered from highest assembly to lowest. If you do not find a module at the bottom of a file then it comes from an included file.






