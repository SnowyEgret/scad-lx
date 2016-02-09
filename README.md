# scad-lx

Main parts:

fullrange_adapter.scad
fullrange_cap.scad
woofer_adapter.scad
base.scad

terminal_cup.scad closes the bottom of the base and is inset for banana plugs. I have dumped these for a speakon connector straight into the woofer pipe, but the base still needs to be closed.

cradle.scad is no longer used and woofer_cover I have never printed.

plumbing.scad contains modules for abs pipes and the rubber connector.

util.scad contains generic utility modules.

lx.scad contains all critical dimensions as defined by SL

IN GENERAL all files are organized as such:

includes
modules to be drawn by this file (uncomment these for testing or exporting to .stl)
parameters (always defined at top of file - never within a module)
modules

The modules are ordered from highest assembly to lowest. If you do not find a module at the bottom of a file then it comes from an included file.






