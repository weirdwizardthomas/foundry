$fs = 0.01;

total_height = 1;
base_height = 0.3;
radius = 3.4;
shell_thickness = 0.1;

beam_width = 0.22;
beams = 6;

central_beam_extra_height = 2;
central_beam_radius=0.22;
central_beam_thickness=0.1;

module shell(height,radius, thickness){
    difference(){
        cylinder(h=total_height,r=radius);
        cylinder(h=total_height,r=radius-thickness);
    }
}

module base(height, radius){
    cylinder(h=height,r=radius);
}


module beams(n=4, width, height, radius) {
    angle = 360 / n;
    for(i=[0:n]){
      rotate(i*angle){
        translate([-beam_width/2,0,0]){
                cube([beam_width,radius,height]);
            }
        }    
    }
}

module central_beam(height,radius, thickness){   
    difference(){
        cylinder(
            h=height,
            r=radius
        );
        cylinder(
            h=height,
            r=radius-thickness
        );
    }
}


shell(
    height=total_height,
    radius=radius,
    thickness=shell_thickness
);
base(
    height=base_height, 
    radius=radius
);
beams(
    n=beams,
    width=beam_width, 
    height=total_height,
    radius=radius
);
central_beam(
    height=central_beam_extra_height+total_height,
    radius=central_beam_radius,
    thickness=central_beam_thickness
);

