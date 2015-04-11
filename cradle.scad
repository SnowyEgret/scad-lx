include <lx.scad>;
//include <woofer_adapter.scad>;
include <util.scad>;

//cradle($fn=180);

// The distance the cradle extends past the long dimension of the oval post
cradle_length_offset=6;
//cradle_length=2*woofer_post_long_radius+cradle_length_offset*2;
cradle_length=50;
cradle_inner_radius=fullrange_pipe_outer_radius;
cradle_thickness=4;
cradle_outer_radius=cradle_inner_radius+cradle_thickness;
cradle_angle=55;

cradle_screw_angle_inset=16;
cradle_screw_angle=cradle_angle-cradle_screw_angle_inset;
cradle_screw_inset=8;
cradle_screw_offset=cradle_length/2-cradle_screw_inset;
// Number 6 machine srew
cradle_screw_hole_shaft_radius=3.6/2;
cradle_screw_hole_head_radius=6.8/2;

cradle_key_width=2.2;
cradle_key_depth=2;
// The key is inset from the woofer post
cradle_key_inset=cradle_length_offset+3;

//cradle_peg_radius=woofer_ring_wire_hole_radius+3;
cradle_peg_radius=3/8*m-.1;
cradle_peg_height=fullrange_pipe_thickness+3;

module cradle() {
  translate([0,0,cradle_inner_radius])
  rotate([0,90.0])
  difference() {
    union() {
      difference() {
        radial_section_of(angle=cradle_angle) {
          hollow_cylinder(ir=cradle_inner_radius, t=cradle_thickness, h=cradle_length);
        }
        screw_holes();
      }
      key();
      peg();
    }
    cradle_wire_hole();
  }
}

module cradle_wire_hole() {
  rotate([0,90,0])
    cylinder(r=6, h=100);
}

module peg() {
  translate([cradle_inner_radius+cradle_thickness/2,0,0])
    rotate([0,-90,0])
      cylinder(r=cradle_peg_radius, h=cradle_peg_height+cradle_thickness/2);
}

module key() {
  translate([cradle_inner_radius+cradle_thickness/2,0,0])
    cube(size=[
      2*cradle_key_depth+cradle_thickness,
      cradle_key_width,
      cradle_length-2*cradle_key_inset
    ], center=true);
}

module screw_holes() {
  for(d=[-cradle_screw_offset, cradle_screw_offset]) {
    translate([0,0,d])
      for(a=[-cradle_screw_angle, cradle_screw_angle]) {
        rotate([0,0,a/2])
          translate([cradle_inner_radius+cradle_thickness/2.2,0,0])
            rotate([0,90,0])
              screw_hole(r_shaft=cradle_screw_hole_shaft_radius, r_head=cradle_screw_hole_head_radius);
      }
  }
}

