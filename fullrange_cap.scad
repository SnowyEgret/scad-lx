include <lx.scad>;

fullrange_cap($fn=120);
//cap_less_logo($fn=120);
//cap_angled($fn=120);

cap_height=24;
cap_rim_thickness=3;
cap_rim_height=16;
cap_inset=5;
cap_logo_size=15;
cap_angle=6;

module fullrange_cap() {
  //radial_section_of(90)
  difference() {
    cap_angled();
    translate([0,0,cap_inset])
      mirror([0,0,1])
        fullrange_pipe(inner_tol=-.1);
  }
}

//module cap_positioned() {
//  translate([
//    fullrange_back_from_center
//    +fullrange_frame_to_pipe
//    +fullrange_pipe_length
//    -cap_inset,
//    0,
//    fullrange_above_woofer
//  ])
//    rotate([0,90,0])
//      cap_angled();
//}

module cap_angled() {
  difference() {
    cap_rimmed();
    rotate([0,cap_angle,0])
      translate([0,0,50+cap_height-cap_rim_height/2])
        cube(size=[100,100,100], center=true);
  }
}

module cap_rimmed() {
  difference() {
    cap_less_logo();
    translate([0,0,cap_height-cap_rim_height])
      cylinder(r=fullrange_pipe_outer_radius-cap_rim_thickness, h=cap_rim_height+1);
  }
}

module cap_less_logo() {
  difference() {
    cap();
    rotate([0,0,90])
      logo(text="LXmini", size=cap_logo_size, height=100, font="Liberation Sans:style=Bold", spacing=1);
  }
}

module cap() {
  cylinder(r=fullrange_pipe_outer_radius-.001, h=cap_height);
}