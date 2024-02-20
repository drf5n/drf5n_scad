///////////////////////////////////////////

// DovetailDemo.scad
// create and demonstrate a dovetail sliding joint
// https://www.thingiverse.com/thing:5540647



// Width of dovetail base
width = 15; // mm
// height of dovetail portion
height = 5; // mm
// length of sample
long = 20; // mm length of dovetail 
// clearance between dovetail and slot
clearance = 0.5; // 0.1mm



// /* Bolt */
part = 0; // [0:1]

include <MCAD/units.scad> // define bolt sizes, etc..


size = M3;

// overlap tolerance for good surface intersections
tiny = 0.001; //


module my_nutbolttrap(size,length,depth,tall){
    union(){
    translate([0,depth,-size])linear_extrude(height=tall) nutHole(size, proj=2);
        translate([size/2,0,0])rotate([-90,0,0])
            boltHole(size, length= length, tolerance=0.3, proj=-1);
    }
}

difference(){
  dovetail_demo_part(part=part);
  if(part ==1)translate([-3/2,-2.25*long+1,3.5])my_nutbolttrap(M3,50,35,10);
}


module dovetail_demo_part(part=0){
    if(part == 0){
    rotate([90,0,0]) // flip to x-y plane for printing
        dovetail_demo(wide=width,high=height,long=long,clearance=clearance);
    }
    
    if(part ==1){ // linear slide
        union(){
    rotate([90,0,0]) // flip to x-y plane for printing
        dovetail_demo(wide=width,high=height,long=long,clearance=clearance,offset = 0,backplate=true);
   
        }
    }
    
    
}

module dovetail_demo(wide=10,high=2,long=20,clearance=0.5,offset=40,backplate = false){

// dovetail slide
translate([0,0,0]) 
    dovetail(base=wide,height=high,length=long,rt=0,stubheight=2,center=true);

// dovetail block
translate([(offset? offset:-((wide+8*high)/2)),-(high-1)-clearance,0])
    difference(){
        cube([wide+8*high,high*2,long*(backplate?2.25:1)]);
        translate([4*high+wide/2,high-1,-tiny]) 
            dovetail(base=wide+clearance*2,height=high,length=(backplate?2:1)*long+2*tiny,stubheight=2,center=true,rt=4,rf=-.5,rr=-.5);
      
    }

}
module dovetail(base = 20,height = 5,length=10,angle = 45,stubheight=0.001,
                rb=0.5,rt=0, rf=0.5,rr=0.5, center=false){
    // this creates a dovetail shape 
    // rb is the bottom radius, 
    // rt radius of the top
    // rf radius of the front (negative for chamfering in holes)
    // rr radius of the rear (negative for chamfering in holes)
    // stubheight 
    // 
                    
    radiiPoints=[
        [0, 0,  rb   ],
        [base,  0,  rb],
        [base-height*cos(angle),  height,  rt],
           [base-height*cos(angle),  height+stubheight,  rt],
           [0+height*cos(angle),  height+stubheight,  rt],
        [0+height*cos(angle),  height,  rt  ]
    ];
  
    translate([center?-base/2:0,0,0])
        polyRoundExtrude(radiiPoints,length,rf,rr,fn=20);
}

/////////////////
use <Round-Anything-1.0.4/polyround.scad> // https://github.com/Irev-Dev/Round-Anything
use <MCAD/nuts_and_bolts.scad> //https://github.com/openscad/MCAD
