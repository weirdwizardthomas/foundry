
// -------------------------------------------------------------------------
// modules 
// -------------------------------------------------------------------------

module base(radius, height) {
    cylinder(h=height, r=radius);
}


module base_half_circle(radius, thickness, height) {
    difference() {
        base(radius, height);
        translate([-radius, 0, 0]) {
            cube([radius * 2, radius, height]);
        }
    }
}

module wall(radius, thickness, height) {
    difference(){
            base_half_circle(radius, thickness, height);
            base_half_circle(radius - thickness, thickness, height);
    };
}

module front_wall(radius, wall_thickness, height){
    translate([0, 0, height]){
        bumper(radius, wall_thickness);
        rotate(90){
            bumper(radius, wall_thickness);
        }
    }
}

module bumper(radius, wall_thickness) {
    intersection(){
        base_half_circle(radius, wall_thickness, wall_thickness);
        translate([-radius, -radius, 0]){
            base(radius + bumper_correction, wall_thickness);
        }
    }
}


module back_wall(radius, wall_thickness){
    base_half_circle(radius, wall_thickness, wall_thickness);
}

module body(radius, wall_thickness, height) {
    union(){
        back_wall(radius, wall_thickness);
        wall(radius, wall_thickness, height + wall_thickness);
        front_wall(radius, wall_thickness, height + wall_thickness);
    }
}

module filter_holder(radius, hole_half_size, height, wall_thickness) {
    difference(){
        body(radius, wall_thickness, height);
        translate([-hole_half_size, -radius, wall_thickness]){
            cube([2 * hole_half_size, hole_half_size, height]);
        }
    }
}

// -------------------------------------------------------------------------
// controls
// -------------------------------------------------------------------------

$fa=0.01;

// all units are in mm  
wall_thickness = 2;
radius = 35;
height = 15;
hole_half_size = 30;
bumper_correction = 0.1;


// -------------------------------------------------------------------------
// model 
// -------------------------------------------------------------------------
filter_holder(radius, hole_half_size, height, wall_thickness);