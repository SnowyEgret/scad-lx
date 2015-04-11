include <util.scad>;
include <lx.scad>;

//Screw holes and radius_tolerance build positive solid to difference with external object
//terminal_cup($fn=120);
//cup_part_of_shaft_removed($fn=120);
//terminal_cup(screw_holes=true, radius_tolerance=2, $fn=120);
//terminal_cup_gasket($fn=120);
//cup_bottomed($fn=120);
//cup_assembled($fn=120);
//plate_rounded($fn=120);
//plate_less_binding_posts($fn=120);
//binding_post($fn=30);
//plate_thickened($fn=120);
//plate_profile_extruded();
//plate_profile();

cup_gasket_thickness=1;
cup_shaft_thickness=6;
//First print: cup_shaft_depth=23;
cup_shaft_depth=20;
cup_shaft_outer_radius=woofer_pipe_inner_radius-2;
cup_shaft_inner_radius=cup_shaft_outer_radius-cup_shaft_thickness;
//First print: cup_shaft_bottom_inset=2;
cup_shaft_bottom_inset=3;

cup_flange_width=11;
cup_flange_thickness=4;
cup_flange_screw_inset=1.2;

//First print: binding_post_radius=1.9;
//First print: binding_post_y_offset=(5.6-2*binding_post_radius)/2;
binding_post_radius_x=2;
binding_post_radius_y=6;
binding_post_tab_x=20;
binding_post_tab_y=7.2;
binding_post_tab_z=1;
binding_post_offset = 10;

plate_thickness=4;
plate_delta_x=-22;
plate_b=40;
plate_a=12;
plate_h=12;

module terminal_cup_gasket() {
  translate([0,0,-cup_gasket_thickness/2-cup_flange_thickness])
    hollow_cylinder(ir=cup_shaft_outer_radius, t=cup_flange_width, h=cup_gasket_thickness);
}

module terminal_cup(screw_holes=false, radius_tolerance=0) {
//  translate([0,0,-cup_flange_thickness])
//    scale([1,1,-1])
//      %woofer_pipe();
  cup_bottomed(screw_holes);
  //
  if (radius_tolerance != 0) {
    translate([0,0,-cup_flange_thickness-cup_gasket_thickness-1])
      cylinder(r=cup_shaft_outer_radius+cup_flange_width+radius_tolerance, h=20);
  }
}

//Removes part of shaft which would make installation of binding posts difficult
module cup_part_of_shaft_removed(screw_holes=false) {
  difference() {
    cup_bottomed(screw_holes);
    difference() {
      translate([plate_delta_x,0,-plate_b-cup_shaft_depth])
        plate_bottom_surface();
      translate([50+plate_delta_x,0,0])
        cube(size=[100,100,100], center=true);
    }
 }
}

module cup_bottomed(screw_holes=false) {
  difference() {
    cup_assembled(screw_holes);
    //Didn't print well like this. Thicken plate earlier
//    translate([plate_delta_x,0,-plate_b-cup_shaft_depth])
//      plate_bottom_surface();
    translate([0,0,
      -50
      -cup_flange_thickness
      -cup_shaft_depth
    ])
      cylinder(r=100, h=50);
  }
}


module cup_assembled(screw_holes=false) {
  translate([0,0,-plate_thickness/2])
    flange(screw_holes);
  translate([0,0,-plate_b/2])
    shaft();
  translate([0,0,-cup_shaft_depth])
    plate_rounded();
}

module flange(screw_holes=false) {
  dx=cup_shaft_outer_radius+cup_flange_width/2-cup_flange_screw_inset;
  difference() {
    translate([0,0,-plate_thickness/2])
      //-1 and +1 for slope on shaft
      chanfered_cylinder(ir=cup_shaft_outer_radius-1, t=cup_flange_width+1, h=plate_thickness, c3=[1,1]);
    radial_array(n=4, r=cup_shaft_outer_radius+cup_flange_width/2-cup_flange_screw_inset) {
      screw_hole(r_shaft=2.2);
    }
  }
  //For differencing with external object
  if(screw_holes) {
    radial_array(n=4, r=cup_shaft_outer_radius+cup_flange_width/2-cup_flange_screw_inset) {
      #screw_hole();
    }
  }
}

module shaft() {
  translate([0,0,-plate_b/2])
    chanfered_cylinder(
      ir=cup_shaft_inner_radius,
      h=plate_b,
      taper_bottom=-cup_shaft_bottom_inset,
      t=cup_shaft_thickness,
      c4=[2,2]);
}

module plate_rounded() {
  translate([0,0,-plate_b])
    difference() {
      translate([plate_delta_x,0,0]) plate_less_binding_posts();
      pipe(ir=cup_shaft_inner_radius, t=2*plate_b, h=10*plate_b);
    }
}

module plate_less_binding_posts() {
  difference() {
    //plate_profile_extruded();
    plate_thickened();
    // Difference with four holes
    for(dx=[0,plate_b]) {
      for(dy=[-binding_post_offset,binding_post_offset]) {
        translate([dx,dy,0])
          binding_post_positioned();
      }
    }
  }
}

module binding_post_positioned() {
  translate([-plate_a/2,0,plate_h/2])
    translate([0,0,plate_b])
      // Tan theta = opposite / adjacent
      rotate([0,atan(plate_a/plate_h),0])
        binding_post($fn=30);
}

module binding_post() {
  binding_post_y_offset=(binding_post_radius_y-2*binding_post_radius_x)/2;
  hull() {
    translate([0,binding_post_y_offset,0])
      cylinder(r=binding_post_radius_x, h=100, center=true);
    translate([0,-binding_post_y_offset,0])
      cylinder(r=binding_post_radius_x, h=100, center=true);
  }
  translate([
    -binding_post_tab_y/2,
    -binding_post_tab_y/2,
    -plate_thickness-.01]
  ) cube(size=[binding_post_tab_x,binding_post_tab_y,binding_post_tab_z]);
}

module plate_thickened() {
  difference() {
    plate_profile_extruded();
    plate_bottom_surface();
  }
}

module plate_profile_extruded() {
  translate([-2*plate_b,cup_shaft_inner_radius,0])
    rotate([90,0,0])
      linear_extrude(height=2*cup_shaft_inner_radius)
        plate_profile();
}

module plate_bottom_surface() {
//Same as plate_profile_extruded except with offset on profile
  translate([-2*plate_b,3*cup_shaft_inner_radius/2,0])
    rotate([90,0,0])
      linear_extrude(height=3*cup_shaft_inner_radius)
       offset(delta=-plate_thickness)
        plate_profile();
}

module plate_profile(a=plate_a, b=plate_b, h=plate_h) {
  polygon(points=[
    [0,0],
    [4*b,0],
    [4*b,b],
    [3*b,b],
    [3*b-a,b+h],
    [2*b,b],
    [2*b-a,b+a],
    [0,b+a]
  ]);
}