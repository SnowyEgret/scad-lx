// The woofer adapter connects the woofer to the rubber coupler below and the fullrange diffuser above. The adapter geometry is intersected with the woofer, diffuser, and coupler geometry - all imported in lx.scad.
// Note that all surfaces formed by an intersection are rendered in green.

include <util.scad>;
include <lx.scad>;
include <elbow.scad>;
// The cradle is no longer used to connect to the diffuser
//include <cradle.scad>;


// For rendering drivers, abs pipes, coupler
//lx($fn=200);

// Uncomment the top level assembly to print the woofer adapter. Sub-assemblies can be uncommented to be viewed independently
// File must be saved before OpenSCAD will re-render
woofer_adapter();
//woofer_assembly();
//woofer_section();
//woofer_assembly();
//connector_and_post();
//woofer_wire_hole();

// All parameters are defined here, not within modules.
// Values can be changed here without compromising the topology of the model (in theory)
// If a parameter is not defined here, it is defined in an imported file.
woofer_ring_height=42;
woofer_ring_width=13;
woofer_ring_frame_inset=3;
// This parameter is derived from two parameters, both imported with lx.scad
// woofer_frame_* names refer to the dimensions of the steel frame of the woofer
// A derived parameter should not be modified.
woofer_ring_inner_radius=woofer_frame_diameter/2 - woofer_frame_width_at_mounting_holes;
woofer_ring_outer_radius=woofer_ring_inner_radius+woofer_ring_width;

woofer_post_radius=15;
woofer_post_oval_scale=1.3;
woofer_post_long_radius=woofer_post_radius*woofer_post_oval_scale;
// Again a parameter derived from parameters imported from lx.scad
// All fullrange_* names refer to dimensions of the fullrange driver and associated parts
woofer_post_height=
  woofer_ring_height
  -woofer_ring_frame_inset
  +fullrange_above_woofer
  -fullrange_pipe_inner_radius;

connector_width=22;
woofer_ring_connector_length=
  fullrange_back_from_center
  +fullrange_frame_to_pipe
  +fullrange_pipe_length/2
  -woofer_frame_diameter/2;

woofer_ring_wire_hole_radius=5.5;
woofer_ring_wire_hole_x_offset=
    fullrange_back_from_center+
    fullrange_frame_to_pipe+
    fullrange_pipe_length/2;
// This might have to be adjusted if you play with other parameters
woofer_ring_wire_hole_z_offset=-14;

// Top level assembly for printing
// Modules are ordered from highest assembly to lowest
module woofer_adapter() {
  //%lx($fn=220);
  woofer_less_lx();
}

// Renderes a radial section to better view its geometry
// Comment out line woofer_adapter(); at top of file (after includes) and uncomment line woofer_section(); to render
module woofer_section() {
  difference() {
    boolean_assembly();
    union() {
      translate([-100,0,0]) cube(size=[200,200,200], center=true);
      rotate([0,0,90]) translate([-200,0,0]) cube(size=[400,400,400], center=true);
      rotate([0,0,-60]) translate([-200,0,0]) cube(size=[400,400,400], center=true);
    }
 }
}

// Differnces assembly with coupler, woofer, and diffuser
// Coupler, woofer, and diffuser is all imported from lx.scad.
// Surfaces created by differencing solids are rendered green, not yellow
module woofer_less_lx() {
  difference() {
    woofer_less_hole();
    lx($fn=180);
  }
}

// Drills hole for wire
module woofer_less_hole() {
  difference() {
    woofer_assembly();
    woofer_wire_hole($fn=30);
  }
}

// Combines ring with previously combined connector and post.
module woofer_assembly() {
  translate([0,0,-woofer_ring_height+woofer_ring_frame_inset]) {
    woofer_ring();
    translate([woofer_frame_diameter/2,0,0])
      connector_and_post();
  }
}

// Combines connector and post
module connector_and_post() {
  translate([woofer_ring_connector_length,0,0])
    woofer_post();
  translate([-2,0,0]) // for bottom chanfer on ring
    woofer_connector();
}

// Creates geometry for the hole through which the wire from the fullrange will pass.
// Will be differenced with the connector and post.
// Module elbow is imported from elbow.scad
// There is a small problem with the elbow module. It creates some residual geometry when exported to stl which may have to be cleaned up in Blender before printing.
module woofer_wire_hole() {
  translate([
    woofer_ring_wire_hole_x_offset,
    0,
    woofer_ring_wire_hole_z_offset
  ])
    rotate([0,0,-90])
      elbow(
        bend_radius=20,
        pipe_radius=woofer_ring_wire_hole_radius,
        lv=woofer_post_height,
        lh=woofer_ring_connector_length
      );
}

// Modules below this comment are used also by base.
// The ring, post, and connector are all re-used to create the geometry of the base.
// The ring, post, and connector are all based on basic geometry defined in util.scad
// Comment line woofer_adapter(); at top of file before printing base.

module woofer_ring(inner_radius=woofer_ring_inner_radius, width=woofer_ring_width) {
  chanfered_ring(
    ir=inner_radius,
    w=width,
    h=woofer_ring_height,
    $fn=220
  );
}

module woofer_post(height=woofer_post_height) {
  scale([woofer_post_oval_scale,1,1])
    chanfered_ring(
      ir=0,
      w=woofer_post_radius,
      h=height,
      $fn=60
    );
}

module woofer_connector(length=woofer_ring_connector_length) {
  rotate([0,90,0])
    rotate([0,0,90])
      chanfered_box(
        h=woofer_ring_height,
        w=connector_width,
        l=length
      );
}