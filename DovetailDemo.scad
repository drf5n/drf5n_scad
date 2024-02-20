///////////////////////////////////////////

// DovetailDemo.scad
// create and demonstrate a dovetail sliding joint
// https://www.thingiverse.com/thing:5540647



// Width of dovetail base
width = 10; // mm
// height of dovetail portion
height = 2; // mm
// length of sample
long = 20; // mm length of dovetail 
// clearance between dovetail and slot
clearance = 0.5; // 0.1mm

// overlap tolerance for good surface intersections
tiny = 0.001; //


rotate([90,0,0]) // flip to x-y plane for printing
    dovetail_demo(wide=width,high=height,long=long,clearance=clearance);

module dovetail_demo(wide=10,high=2,long=20,clearance=0.5){

translate([0,0,0]) 
    dovetail(base=wide,height=high,length=long,rt=0,stubheight=2,center=true);

translate([2*wide,0,0])
    difference(){
        cube([wide+8*high,high*2,long]);
        translate([4*high+wide/2,high-1,-tiny]) 
            dovetail(base=wide+clearance,height=high,length=long+2*tiny,stubheight=2,center=true,rt=4,rf=-.5,rr=-.5);
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
