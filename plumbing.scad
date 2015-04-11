//coupler();

m=25.4;

id_large=122;
id_small=111;
thickness=8.3;

center_profile_height=20;
outer_profile_height=42;
//Makes the top lip a little wider and deeper so that its
//groove in the top ring is deep enough after cleaning support material
tol=1;

module coupler_outer_profile(t=thickness, d=5+tol, w=16, o=1.8, h=outer_profile_height) {
  polygon(points=[
    [0,0],
    [t,0],
    [t,h-d-w],
    [t-o,h-d-w],
    [t-o,h-d],
    [t+tol,h-d],
    [t+tol,h],
    [0,h],
  ]);
}

module coupler_center_profile(t=thickness, h=center_profile_height, d=(id_large-id_small)/2) {
  polygon(points=[
    [0,0],
    [t,0],
    [d+t,h],
    [d,h],
  ]);
}

module coupler(r1=id_small/2, r2=id_large/2) {
  translate([0,0,-(2*outer_profile_height+center_profile_height)])
  rotate_extrude()
  translate([r1, outer_profile_height, 0]) {
    translate([r2-r1,center_profile_height,0]) coupler_outer_profile();
    coupler_center_profile();
    mirror([1,0,0]) rotate([0,0,180]) coupler_outer_profile();
  }
}

module abs_pipe(r, t, h) {
  difference() {
    cylinder(r=r+t, h=h);
    translate([0,0,-1]) cylinder(r=r, h=h+2);
  }
}
