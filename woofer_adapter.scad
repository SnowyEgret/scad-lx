include <util.scad>;
include <lx.scad>;
include <elbow.scad>;
//include <cradle.scad>;

//lx($fn=200);
//woofer_adapter();
//woofer_assembly();
//woofer_section();
//woofer_assembly();
//connector_and_post();
//woofer_wire_hole();

woofer_ring_height=42;
woofer_ring_width=13;
woofer_ring_frame_inset=3;
woofer_ring_inner_radius=woofer_frame_diameter/2 - woofer_frame_width_at_mounting_holes;
woofer_ring_outer_radius=woofer_ring_inner_radius+woofer_ring_width;

woofer_post_radius=15;
woofer_post_oval_scale=1.3;
woofer_post_long_radius=woofer_post_radius*woofer_post_oval_scale;
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
woofer_ring_wire_hole_z_offset=-14;

module woofer_adapter() {
  //%lx($fn=220);
  woofer_less_lx();
}

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

module woofer_less_lx() {
  difference() {
    woofer_less_hole();
    lx($fn=180);
  }
}

module woofer_less_hole() {
  difference() {
    woofer_assembly();
    woofer_wire_hole($fn=30);
  }
}

module woofer_assembly() {
  translate([0,0,-woofer_ring_height+woofer_ring_frame_inset]) {
    woofer_ring();
    translate([woofer_frame_diameter/2,0,0])
      connector_and_post();
  }
}

module connector_and_post() {
  translate([woofer_ring_connector_length,0,0])
    woofer_post();
  translate([-2,0,0]) // for bottom chanfer on ring
    woofer_connector();
}

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

// Modules below this comment are used also by base

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