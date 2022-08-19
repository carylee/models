include <BOSL2/std.scad>

$fn = 100;

inch = 25.4;
od = 8*inch;
width = 3;

module wheel_and_spokes() {
  stroke(circle(d=od), closed=true, width=width);
  stroke(circle(d=0.8*od), closed=true, width=width);
  stroke(circle(d=0.6*od), closed=true, width=width);

  rotate([0,0,-45])
  square([width,od], center=true);
  rotate([0,0,45])
  square([width,od], center=true);
  rotate([0,0,90])
  square([width,od], center=true);
  square([width,od], center=true);
}

module half_wheel_and_spokes() {
  difference() {
    translate([-width/2,0])
    wheel_and_spokes();

    translate([0,-1000/2])
    square([1000,1000]);
  }
}

module split_wheel_and_spokes(gap=20) {
  translate([-gap/2,0])
  half_wheel_and_spokes();
  mirror([1,0,0])
  translate([-gap/2,0])
  half_wheel_and_spokes();
}


module mask() {
  resize(newsize=[7*inch,4*inch])
  import("/Users/cary/Documents/mask.svg", center=true);

  split_wheel_and_spokes(gap=5*inch);
}

linear_extrude(3)
mask();
