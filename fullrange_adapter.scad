//include <util.scad>;
include <lx.scad>;

ring_height=42;
ring_width=12;
ring_distance_above_frame=3;
ring_inner_radius=fullrange_frame_radius - fullrange_frame_width_at_mounting_holes;

fullrange_adapter($fn=120);
//ring_positioned($fn=120);
//ring_vented($fn=120);
//vent_rounded($fn=120);
//vent_quartered($fn=120);
//vent($fn=120);

module fullrange_adapter() {
  difference() {
    ring_positioned();
    #fullrange();
  }
}

module ring_positioned() {
    translate([fullrange_back_from_center-ring_distance_above_frame,0,fullrange_above_woofer])
        rotate([0,-90,0])
            translate([0,0,-ring_height])
                ring_vented();
}

module ring_vented() {
  difference() {
    chanfered_ring(ir=ring_inner_radius, w=ring_width, h=ring_height);
    radial_array(n=4)
      vent_quartered();
  }
}

module vent_quartered() {
  rotate([0,0,105-22.5])
  difference() {
    vent();
    translate([100,0,0])
      cube(size=([200,200,200]), center=true);
    rotate([0,0,105])
      translate([100,0,0])
        cube(size=([200,200,200]), center=true);
  }
}

module vent() {
  rotate_extrude()
    vent_profile();
}

module vent_profile(r=80, h=35) {
  polygon(points=[
    [r,1],
    [r,h],
    [1,h],
  ]);
}
