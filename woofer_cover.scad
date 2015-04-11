include <woofer_adapter.scad>;

//radial_section_of()
woofer_cover();

woofer_cover_tol=.3;
woofer_cover_gap=2.1;
woofer_cover_thickness=1.5;
woofer_cover_outer_radius=woofer_ring_outer_radius+woofer_cover_thickness+woofer_cover_tol;
woofer_cover_depth=9.9;

woofer_cover_logo_size=22;
woofer_cover_logo_height=2.1;



module woofer_cover($fn=200) {
  difference() {
    translate([0,0,woofer_frame_thickness+woofer_cover_gap])
      top_and_lip_and_side();
    woofer_adapter();
  }
}

module top_and_lip_and_side() {
  cylinder(r=woofer_cover_outer_radius, h=woofer_cover_thickness);
  translate([0,0,-(woofer_frame_thickness-woofer_ring_frame_inset+woofer_cover_gap)/2])
    hollow_cylinder(
      ir=woofer_frame_radius,
      t=woofer_cover_outer_radius-woofer_frame_radius-woofer_cover_tol,
      h=woofer_frame_thickness-woofer_ring_frame_inset+woofer_cover_gap);
  translate([0,0,-woofer_cover_depth/2])
    hollow_cylinder(
      ir=woofer_ring_outer_radius+woofer_cover_tol,
      t=woofer_cover_outer_radius-woofer_ring_outer_radius-woofer_cover_tol,
      h=woofer_cover_depth);
  translate([0,0,woofer_cover_thickness])
    rotate([0,0,-90])
      mirror([1,0,0])
        logo(size=woofer_cover_logo_size, height=woofer_cover_logo_height);
}