mount_z_offset = 5;
mount_length = 60;


bltouch_head_rect_width = 11.5;
bltouch_head_rect_length = 6;
bltouch_hole_diameter = 3.2;
bltouch_hole_edge = 2.5;
bltouch_hole_pitch = 18;

arm_hole_pitch = 30;
arm_hole_distance_from_end = 7;
arm_width = 14;
arm_length = mount_length - bltouch_head_rect_width;
arm_height = 3.2;

zip_tie_width = 2.5;
strain_relief_height = arm_height;

$fn = 72;

print_parts();

module print_parts() {
    print_head();
    print_arm();
    print_strain_relief();
}

module print_strain_relief() {
    translate([-2, (bltouch_hole_pitch + bltouch_hole_diameter + 2 * bltouch_hole_edge) / 2 - bltouch_head_rect_length / 2 , 0])
        difference() {
            cube([2, bltouch_head_rect_length, zip_tie_width + 2]);
            translate([1 , 0 - bltouch_head_rect_length / 2 , 1])
                cube([1, bltouch_head_rect_length * 2, zip_tie_width]);
        }
}

module print_head() {
    linear_extrude(arm_height + mount_z_offset) {
        difference() {
            hull() {
                translate([bltouch_head_rect_width / 2,  bltouch_hole_diameter / 2 + bltouch_hole_edge]) {
                    circle(d = bltouch_hole_diameter + bltouch_hole_edge * 2);
                    translate([0, bltouch_hole_pitch, 0])
                        circle(, d = bltouch_hole_diameter + bltouch_hole_edge * 2);
                }
                translate([0, (bltouch_hole_pitch + bltouch_hole_edge) / 2])
                    square([bltouch_head_rect_width, bltouch_head_rect_length]);
            }
            translate([bltouch_head_rect_width / 2,  bltouch_hole_diameter / 2 + bltouch_hole_edge]) {
                circle(d = bltouch_hole_diameter);
                translate([0, bltouch_hole_pitch, 0])
                    circle(, d = bltouch_hole_diameter);
                translate([0, bltouch_hole_pitch / 2, 0])
                    circle(, d = bltouch_hole_diameter);

            }
        }
    }
}

module print_arm() {
    translate([bltouch_head_rect_width - 1, (bltouch_hole_pitch + bltouch_hole_diameter + 2 * bltouch_hole_edge) / 2 - arm_width / 2 , 0])
        difference() {
            cube([arm_length, arm_width, arm_height]);
            translate([arm_length - arm_hole_distance_from_end - arm_hole_pitch, arm_width / 2, 0 - arm_height / 2])
                cylinder(h = arm_height * 2, d = 3);
            translate([arm_length - arm_hole_distance_from_end, arm_width / 2, 0 - arm_height / 2])
                cylinder(h = arm_height * 2, d = 3);
        }
    }