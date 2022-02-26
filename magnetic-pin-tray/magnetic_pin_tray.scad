d = 100 * 0.80;
r = d/2;
h = 32 * 0.5;
$fa = 2;
$fs = 1.75/2;
dip = 5;

magnet = [60,10,3];
magnet_spacing = 15;


difference() {
    intersection() {
        cylinder(d=d, h=h, $fa=$fa, $fs=$fs);

        translate([0,0,h/2-5])
        sphere(d=d, $fa = $fa, $fs = $fs);
    }


    translate([0,0,r*3+h-dip])
    sphere(d=d*3, $fn=400);
    
    color("red")
    translate([-0.5*magnet.x,-1*magnet.y-magnet_spacing*0.5,h-magnet.z-dip-1]) {
        cube(magnet);
        translate([0,magnet.y+magnet_spacing,0])
        cube(magnet);
    }
}

