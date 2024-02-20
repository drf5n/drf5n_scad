// size of cube
d = 20; //1 mm
// wall thickness
wall = 0.8; //0.1

// interference for good intersections
tiny = 0.001;


wallcube(d=d,wall=wall);

module wallcube(d=d,wall=wall,tiny=tiny){
    difference(){
        cube([d,d,d],center=true);
        translate([0,0,-tiny])
            cube([d-2*wall,d-2*wall,d+2*tiny],center=true);
    }
}
    