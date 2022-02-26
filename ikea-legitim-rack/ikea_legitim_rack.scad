to_mm = 25.4;
cutting_board_length = 13.5 * to_mm;
cutting_board_width = 9.5 * to_mm;
cutting_board_thickness = 0.25 * to_mm;
rack_depth = cutting_board_width - 30;
$fn = 100;

module cutting_board() {
    color("white")
    cube([cutting_board_width, cutting_board_length, cutting_board_thickness]);
}

edge = 3;
rack_edge_w = edge;
rack_edge_h = edge;
fit_gap = 5;
overhang = 25;
gap = cutting_board_thickness + 6;
rear_overhang = overhang*2;

/*module rack_base() {

    difference() {
        union() {
            // side wall (front wall)
            cube([rack_depth, rack_edge_w, rack_edge_h*2 + gap*2]);

            // upper shelf front
            translate([0,0,gap + rack_edge_h])
            cube([rack_depth, overhang, rack_edge_h]);

            // upper mount, front
            translate([0,0,gap*2 + rack_edge_h*2])
            cube([rack_depth, overhang, rack_edge_h]);

            // upper mount, rear
            translate([0,0,gap*2 + rack_edge_h*2])
            cube([overhang, rear_overhang, rack_edge_h]);

            // lower shelf front
            cube([rack_depth, overhang, rack_edge_h]);

            // lower shelf rear
            cube([overhang, rear_overhang, rack_edge_h]);

            // upper shelf rear
            translate([0,0,gap + rack_edge_h])
            cube([overhang, rear_overhang, rack_edge_h]);


            // closure at rear
            cube([rack_edge_w, rear_overhang, rack_edge_h*2+gap*2]);
        }


        translate([rack_depth - overhang,0,-1])
        difference () {
            translate([0,rack_edge_w,0])
            cube([overhang*2, overhang-rack_edge_w, rack_edge_h*2+gap+2]);
            cylinder(h=rack_edge_h*2+gap+2, r=overhang*2);
        }
    }
}*/

module board_slot() {
    cube([rack_depth, rear_overhang+10, gap]);
}

module shelf(depth, width, height) {
    r = depth / (width * width);
    for (i = [0:depth]) {
        //rotate([0,0,90])
        translate([i, 0, 0])
        cube([1, depth-i*i*r, height]);
    }
}

//shelf(rack_depth, rear_overhang, rack_edge_h);

rack_h = rack_edge_h * 3 + gap * 2;

module rack_base_2() {


    difference() {
        cube([rack_depth, rear_overhang, rack_h]);
        translate([rack_edge_w, rack_edge_w, rack_edge_w])
        board_slot();
        translate([rack_edge_w, rack_edge_w, rack_edge_w*2 + gap])
        board_slot();
        
        translate([overhang, overhang, -5])
        cube([rack_depth, rear_overhang, rack_h+10]);
    }
}


module screw_hole(h) {
    screwdriver_d = 9.5;
    screw_head_d = 5.5;
    screw_id = 3.0;
    screw_od = 5.25;
    d = 5;
    screw_taper_h = 2.65;

    translate([0,0,h])
    mirror([0,0,h])
    union() {
        translate([0,0,-2])
        cylinder(d=screw_id, h=rack_edge_h - screw_taper_h+2);

        translate([0,0,rack_edge_h - screw_taper_h])
        cylinder(d1=screw_id, d2=screw_od, h = screw_taper_h);

        translate([0,0,rack_edge_h])
        cylinder(d=screwdriver_d, h=h);

    }

}

module rack() {
    difference() {
        rack_base_2();

        center = (rack_edge_w + overhang) / 2;
        translate([center, center, 0])
        screw_hole(h=rack_h);

        translate([rack_depth - (center/2), center, 0])
        screw_hole(h=rack_h);
    }
}

%translate([10,rack_edge_w+fit_gap,rack_edge_h])
cutting_board();

%translate([10,rack_edge_w+fit_gap,rack_edge_h*2 + gap])
cutting_board();

color("red")
rack();

color("red")
translate([0,cutting_board_length+2*fit_gap+rack_edge_w*2,0])
mirror([0,1,0])
rack();