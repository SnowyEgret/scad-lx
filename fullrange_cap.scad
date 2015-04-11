include <lx.scad>;

cap_height=12;
cap_rim_thickness=3;
cap_rim_height=0;
cap_inset=3;
cap_logo_size=14;

fullrange_cap($fn=120);
//cap_less_logo($fn=120);

module fullrange_cap() {
  difference() {
    cap_positioned();
    #fullrange();
  }
}

module cap_positioned() {
  translate([
    fullrange_back_from_center
    +fullrange_frame_to_pipe
    +fullrange_pipe_length
    -cap_inset,
    0,
    fullrange_above_woofer
  ])
    rotate([0,90,0])
      cap_rimmed();
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
      logo(size=cap_logo_size, height=100, font="Liberation Sans:style=Bold", spacing=1);
  }
}

module cap() {
  cylinder(r=fullrange_pipe_outer_radius-.01, h=cap_height);
}