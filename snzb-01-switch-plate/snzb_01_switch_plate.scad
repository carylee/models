include <BOSL2/std.scad>

h = 43;
w = 43;
d = 16;
box_wall = 1.2;

$fn=100;


module button() {
    translate([0,0,-2])
    cube([w, h, d], center=true);
}

//color("green")
//button();

module box() {
    t = box_wall;
    difference() {
        translate([0,0,-2-t])
        cube([w+t*2,h+t*2,d+t], center=true);
    
        button();
        
        cylinder(h=60, r=d, center=true);
    
    }
    layer_h = 0.2;
    color("pink")
    down(d/2 + t + layer_h/2)
    cube([w,h,layer_h], center=true);
}


module hole(distance) {
    color("blue")
    fwd(distance/2)
    cylinder(h=60, r=2.4, center=true);
    
    color("blue")
    back(distance/2)
    cylinder(h=60, r=2.4, center=true);
}


module plate() {
    plate_h=5.8;
    plate_w=74.4;
    plate_l=118.5;
    wall=1.8;
    
    color("red")
  //  up(plate_h/2)
    difference() {
        cuboid([plate_w, plate_l, plate_h*2], rounding=5);
        down(5+plate_h/2)
        cube([plate_w*1.1, plate_l*1.1,plate_h+10], center=true);
        down(wall)
        cuboid([plate_w-wall*2, plate_l-wall*2, plate_h*2], rounding=5);
        hole(84);
    }
}

difference() {
union(){
plate();
box();
}
    up(2)
    cube([w, h, 10], center=true);

}
