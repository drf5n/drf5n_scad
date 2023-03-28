// bushing.scad

// library for parametric washer, bushing, spacer, ring or gasket 
// with chamfers and optional flange
// compare to flanged bushings at https://www.mcmaster.com/flanged-bushings/
//
// Remixed from Tony Z. Tonchev's washer.scad
// to add chamfers and flanges
// 
// Based on washer.scad from 
// https://www.thingiverse.com/thing:3183449
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018

//https://www.thingiverse.com/thing:5577366
Instructions = "";// ["Chamfered Bushing, parametric, flange optional","1) Choose an ID, Length, and OD.","2) For a flange, choose a non-zero Flange Thickness & Flange OD > OD","(Based on https://www.thingiverse.com/thing:3183449)"]

// (in mm)
Inside_Diameter = 15; //0.1

// (in mm)
Length = 5; //0.1

// (in mm)
Outside_Diameter = 30; //0.1

// <OD is no flange
Flange_OD = 0; //0.1

// 0 is no flange
Flange_Thickness =0; //0.1

//corner break
Break = 0.2; //0.1

//Hole Taper on radius, relative to top
HoleTaper = 0.0; //0.1

//Outer Taper on radius, relative to top
OuterTaper = 0.0; //0.1


/* [advanced] */

// number of facets
$fn=100;
// overlap 
eps=0.001;


chamfered_bushing(Inside_Diameter, Length, Outside_Diameter, Flange_OD, Flange_Thickness, Break, HoleTaper,OuterTaper);


module chamfered_bushing (di=15, h=5, do=30, fod=0, fh=0, break=0.2,holeTaper = 0,outerTaper=0) {
    ro=do/2;
    rob = ro - outerTaper;
    ri=di/2;
    rib = ri-holeTaper;  // bottom inner radius
    fr = fod/2;
    translate([0,0,h/2])
        difference () {
          union(){
            cylinder (h, rob, ro, true);
            if(fod != 0)translate([0,0,-h/2+fh/2+eps])cylinder(h=fh,d=fod,center=true);
        }
        cylinder (h+2*eps, rib, ri, true);
        if(Break != 0 ){
            translate([0,0,-h/2]){
                break_circular(r=(fod<rob?rob:fod/2),break=break);
                break_circular(r=-rib,break=break);}
            translate([0,0,h/2])rotate([180,0,0]){
                break_circular(r=ro,break=break);
                break_circular(r=-ri,break=break);}
        if(fod>do && fh > 0)
            translate([0,0,-h/2+fh])rotate([180,0,0])break_circular(r=fod/2,break=break);
        }
        }
}

module break_circular(r=10,angle=360,break=0.5,margin=0.5,draft=45){
      rotate_extrude(angle=angle)
        translate([r,0,0])
            chamfer_polygon(break = break,margin = margin,draft=draft);
      
  }


module chamfer_polygon(break=1,margin=1,thickness=1,draft=3)
    polygon(chamfer_points(break=break,margin=margin,thickness=thickness,draft=draft)); 

function chamfer_points(break=1,margin=1,thickness=1,draft=3) = [
        [thickness,-thickness],
        [-margin,-thickness],
        [-margin,-margin*sin(draft)],
        [-break,0],
        [0,break],
        [margin*sin(draft),margin],
        [thickness,margin]
    ];



if (0){
    dos = [10,15,20];
    dis = [1,5,9];
    for( i=[0,1,2],j=[0,1,2])
    translate([i*30,j*30,0])chamfered_bushing(h=(dos[i]+dis[j])%7+1,do=dos[i],di=dis[j],break=.2);
    
}