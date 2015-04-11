include <util.scad>;
include <lx.scad>;
include <woofer_adapter.scad>;
include <terminal_cup.scad>;

$fn=120;
base();
//base_less_terminal_cup();
//base_less_woofer_pipe();
//base_assembled();
//base_ring();
//base_leg();
//woofer_post_drilled();
//threaded_insert();

num_legs=3;

//The top and bottom rings are the same profile
base_ring_height=woofer_ring_height;
base_ring_inner_radius=cup_shaft_outer_radius;
base_ring_width=20;
base_ring_pipe_inset=base_ring_height-15;
base_ring_pipe_inner_radius_tolerance=.9;
base_ring_pipe_inner_radius=woofer_pipe_outer_radius + base_ring_pipe_inner_radius_tolerance;

base_leg_height=base_ring_height+20;
base_leg_inset=5;
base_leg_length=60;

threaded_insert_head_radius=6.1;
threaded_insert_head_length=1.5;
threaded_insert_shaft_radius=4.5;
threaded_insert_length=20;

print_bed_width=200;

module base() {
  //%print_bed();
  //%base_legs();
  base_less_terminal_cup();
}

module base_less_terminal_cup() {
  difference() {
    base_less_woofer_pipe();
    rotate([0,0,45])
      scale([1,1,-1])
        translate([0,0,base_ring_height])
          union() {
            terminal_cup(screw_holes=true, radius_tolerance=.5, $fn=120);
            terminal_cup_gasket($fn=120);
          }
  }
}

module base_less_woofer_pipe() {
    difference() {
      base_assembled();
      translate([0,0,-base_ring_pipe_inset])
        cylinder(r=base_ring_pipe_inner_radius, h=100, $fn=120);
    }
}

module base_assembled() {
  difference() {
    base_ring();
    base_legs();
  }
}

module base_legs() {
  radial_array(n=num_legs) {
    base_leg();
  }
}

module base_ring() {
  scale([1,1,-1]) 
    woofer_ring(inner_radius=base_ring_inner_radius, width=base_ring_width);
}

module base_leg() {
  scale([1,1,-1]) 
    translate([woofer_pipe_outer_radius+base_leg_inset,0,0]) {
      translate([base_leg_length, 0,0])
        woofer_post_drilled();
    woofer_connector(length=base_leg_length);
  }
}

module woofer_post_drilled() {
  difference() {
   woofer_post(height=base_leg_height);
    translate([0,0,base_leg_height+.001])
      mirror([0,0,1])
        threaded_insert();
  }
}

module threaded_insert() {
   cylinder(r=threaded_insert_shaft_radius, h=threaded_insert_length);
   cylinder(r=threaded_insert_head_radius, h=threaded_insert_head_length);
}

module print_bed() {
  translate([0,0,-base_leg_height])
  cube(size=[print_bed_width,print_bed_width,1], center=true);
}


