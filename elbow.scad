//http://forum.openscad.org/hull-to-create-elbow-not-working-td11667.html
//elbow(lv=10, lh=20);

module elbow(bend_radius=5, pipe_radius=1.5, lv=10, lh=10, detail=30) {
  translate([0,0,bend_radius+pipe_radius])
    cylinder(r=pipe_radius, lv, $fn=detail);  
  translate([0,-bend_radius,pipe_radius])
    rotate([90,0,0])
      cylinder(r=pipe_radius, lh, $fn=detail);
  bend(r=bend_radius, rc=pipe_radius, detail=detail);
}

module bend(r, rc, detail){
  translate([0,0,r+rc])
    rotate([0,90,0])
      translate([0,-r,0])
        difference(){
          rotate_extrude($fn=60,convexity=4)
            translate([r,0])
              rotate([0,0,360/detail/2])
                circle(rc,$fn=detail);
            translate([0,-2*r,0])
              cube(4*r,true);
            translate([-2*r,0,0])
              cube(4*r,true);
        }
}

