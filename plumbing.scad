// Uncomment for testing
// Comment out before including this file
//coupler($fn=200);
//abs_pipe($fn=200, r=50, t=6, h=100);

// Not used anymore
//m=25.4;

// All parameters defined here, not within modules
// Adjust to dimensions of coupler purchased
coupler_id_large=122;
coupler_id_small=111;
coupler_thickness=8.3;
// The coupler is made combining the rotate_extrude of two profiles (polygons).
// The outer profile is mirrored and re-used to create both of small and large ends of the coupler.
coupler_center_profile_height=20;
coupler_outer_profile_height=42;
coupler_lip=5;
coupler_clamp_width=16;
coupler_clamp_depth=1.8;
// Makes the top lip a little wider and deeper so that its groove in the top ring is deep enough after cleaning support material
// Remember, this solid will be differenced with woofer adapter, so the bigger it is, the smaller the adapter is.
coupler_tol=1;


module coupler(r1=coupler_id_small/2, r2=coupler_id_large/2) {
  translate([0,0,-(2*coupler_outer_profile_height+coupler_center_profile_height)])
  rotate_extrude()
  translate([r1, coupler_outer_profile_height, 0]) {
    translate([r2-r1,coupler_center_profile_height,0]) coupler_outer_profile();
    coupler_center_profile();
    mirror([1,0,0]) rotate([0,0,180]) coupler_outer_profile();
  }
}

// Creates a 2D polygon which will be rotate_extruded to create both large and small ends of coupler
module coupler_outer_profile(t=coupler_thickness, d=coupler_lip+coupler_tol, w=coupler_clamp_width, o=coupler_clamp_depth, h=coupler_outer_profile_height) {
  polygon(points=[
    [0,0],
    [t,0],
    [t,h-d-w],
    [t-o,h-d-w],
    [t-o,h-d],
    [t+coupler_tol,h-d],
    [t+coupler_tol,h],
    [0,h],
  ]);
}

// Creates a 2D polygon which will be rotate_extruded to create the center section of the coupler
module coupler_center_profile(t=coupler_thickness, h=coupler_center_profile_height, d=(coupler_id_large-coupler_id_small)/2) {
  polygon(points=[
    [0,0],
    [t,0],
    [d+t,h],
    [d,h],
  ]);
}

// Used by plumbing module to create woofer and fullrange diffuser pipes
module abs_pipe(r, t, h) {
  difference() {
    cylinder(r=r+t, h=h);
    translate([0,0,-1]) cylinder(r=r, h=h+2);
  }
}
