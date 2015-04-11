include <plumbing.scad>;
include <util.scad>;

//lx($fn=200);
//fullrange($fn=200);
//fullrange_pipe($fn=200);
//woofer($fn=200);
//woofer_pipe($fn=200);
//logo(font="Liberation Sans:style=Bold");

// Imperial to metric conversion factor
m=25.4;

// The frame will be differenced with the woofer and fullrange rings
// Tried at 2 for second prototype
frame_diameter_tolerance=1.4;
// Pipes are differenced with rings mounted on exterior on one end, and diffuser or stand mounted on interior on other
pipe_tolerance=0;
// The frame of the woofer is tapered. This has to be big enough so that the frame fits into coupler
gap_woofer_frame_pipe_top=17;

fullrange_pipe_interior_radius=77.3/2-pipe_tolerance;
fullrange_pipe_thickness=5.8+2*pipe_tolerance;
fullrange_pipe_outer_radius=fullrange_pipe_interior_radius+fullrange_pipe_thickness;
fullrange_pipe_length=5*m;

fullrange_frame_diameter=97.7+frame_diameter_tolerance;
fullrange_frame_radius=fullrange_frame_diameter/2;
fullrange_frame_thickness=5.4;
fullrange_frame_width_at_mounting_holes=8.5;
//Two blocks 3.4 inch mdf + inner pipe radius + space for screws
fullrange_above_woofer=(2*.75 + 3/2 +.25)*m + fullrange_pipe_thickness;
//fullrange_above_woofer=3.25*m;
fullrange_back_from_center=3/8*m;
fullrange_frame_to_pipe=8/7*m;

woofer_frame_diameter=146+frame_diameter_tolerance;
woofer_frame_radius=woofer_frame_diameter/2;
woofer_frame_thickness=7.15;
woofer_frame_width_at_mounting_holes=10;
woofer_frame_to_pipe=3.25*m;

woofer_pipe_inner_radius=100.3/2;
woofer_pipe_thickness=6.9;
woofer_pipe_outer_radius=woofer_pipe_inner_radius+woofer_pipe_thickness;
woofer_pipe_length=31*m;

logo_text="LX";

module lx() {
  fullrange();
  woofer();
}

module fullrange() {
  translate([fullrange_back_from_center,0,fullrange_above_woofer])
  rotate([0,90,0]) {
    translate([0,0,-fullrange_frame_thickness])
      driver(
        frame_outer_radius=fullrange_frame_radius,
        frame_height=fullrange_frame_thickness,
        hole_center_from_outer_edge_frame=4.8,
        num_holes=4
      );
    translate([0,0,fullrange_frame_to_pipe])
      fullrange_pipe();
   }
}


module woofer() {
  rotate([0,180,0]) {
    translate([0,0,-woofer_frame_thickness])
    rotate([0,0,30])
      driver(
        frame_outer_radius=woofer_frame_diameter/2,
        frame_height=woofer_frame_thickness
      );
    translate([0,0,woofer_frame_to_pipe])
    woofer_pipe();
  }
  translate([0,0,-gap_woofer_frame_pipe_top])
    coupler();
}

module fullrange_pipe() {
  abs_pipe(
    r=fullrange_pipe_interior_radius,
    t=fullrange_pipe_thickness,
    h=fullrange_pipe_length
  );
}

module woofer_pipe() {
  abs_pipe(
    r=woofer_pipe_inner_radius,
    t=woofer_pipe_thickness,
    h=woofer_pipe_length
  );  
}

module driver(
  frame_outer_radius,
  frame_height,
  hole_width=1.9,
  hole_depth=15,
  hole_center_from_outer_edge_frame=4,
  num_holes=6)
{  
  union() {
    cylinder(r=frame_outer_radius, h=frame_height);
    radial_array(n=num_holes, r=frame_outer_radius-frame_diameter_tolerance/2-hole_center_from_outer_edge_frame)
      cylinder(r=hole_width, h=frame_height+hole_depth, $fn=16);
  }
}

module logo(text=logo_text, size=1, height=1, font, spacing) {
  linear_extrude(height=height, center=false)
    text(text=logo_text, halign="center", valign="center", size=size, font=font, spacing=spacing);
}
