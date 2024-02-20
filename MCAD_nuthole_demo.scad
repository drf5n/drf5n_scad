 // MCAD_nuthole_demo.scad
 
// This demos MCAD/nuts_and_bolts/nuthole() using the MCAD library

// Note that the nut-trap type nuthole is across the 
// points rather than flats w/o the roate([0,30,0]) trick. 
// MCAD nut traps are awkward.

 
 // install libraries locally per https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
 // or depend on Thingiverse's customizer's builtin MCAD
 use <MCAD/nuts_and_bolts.scad> // https://github.com/openscad/MCAD
 include <MCAD/units.scad>  // defines constants https://github.com/openscad/MCAD/blob/master/units.scad
 
  use <MCAD/nuts_and_bolts.scad>
 include <MCAD/units.scad>; // 
 
 use <MCAD/polyholes.scad>
 

 
 // size
 size = 3; // 
 
 // part size
 part_edge = 10;
 
 // 
 
tiny = 0.001; // for clean intersections
 
 // facet number for rendering
 $fn=50;
 
 nuthole_demo();
 
 module nuthole_demo(){
     translate([-20,0,0])
         nuthole_demo_part(part_edge);
         
     translate([0,0,0])
         nuthole_holes(size=size);
         
     translate([20,0,0])
         difference(){
             nuthole_demo_part(part_edge);
             translate([0,1,part_edge/2])nuthole_holes(size=size);
     }
 }
 
module nuthole_demo_part(size=10){
    translate([-size/2,0,0])
        cube([size,size,size],center=false);
}



module nuthole_holes(size=3,length=part_edge+5,tall=part_edge){
   // translate([10/2,0,10/2]) // position hole
    my_nutbolttrap_default(size=size,length=length,depth=length/4,tall=tall);
}

module my_nutbolttrap_default(size,length,depth,tall){
    union(){
        translate([0*size/2,0,0])rotate([-90,0,0])
            boltHole(size, length= length, tolerance=0.3, proj=-1);  
        translate([0,length+tiny,0])rotate([-90,30,0])nutHole(size, tolerance=0.3);
        translate([0,length-5-2+tiny,0])rotate([-90,30,0])nutHole(size, tolerance=0.3);
        translate([0,depth,-size])
            linear_extrude(height=tall+size/2+tiny)   
                translate([-size/2,0,5.5/2])rotate([0,30,0])nutHole(size, proj=2, tolerance=0.3);
    }

}
 
//translate([-40,0,0])SKIPtestNutsAndBolts();
//translate([-45,10,0])boltHole(3, length= 30, proj=2);

//translate([-50,0,0])linear_extrude(10)nutHole(size, proj=-1); // nope - cant extrude 3d objects


 module testNutsAndBolts()
{
	$fn = 360;
	translate([0,15])nutHole(3, proj=2);
	boltHole(3, length= 30, proj=2);

}
