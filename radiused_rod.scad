// radiused_rod.scad
// https://www.thingiverse.com/thing:6079195
// https://www.printables.com/model/506143

// diameter of shaft
d = 2; // 0.01
// length of shaft (excluding rounds)
length = 10; // 0.1

// number of shafts
nShaft = 1;
// change in diameter per each shaft
deltaDia = 0; //0.1

// maximum overhang angle
overhang_angle = 45;
// round ends or square ends
roundEnds = true;

// head diameter factor  1= no head
headDiaFactor = 1; //0.1


// facet Number
$fn=36;
// epsilon for intersecting elements
eps = 0.0001;

// shaft with a ball on the end, flattened for printing
radiused_shaft_array(d,length,nShaft,deltaDia);


module radiused_shaft_array(d,length,nShaft,deltaDia){
    for(a = [0:nShaft-1]){
        translate([(a*((d+1+a*deltaDia/2))*(headDiaFactor)),0,0])
        radiused_shaft(d+a*deltaDia,length);
    }
}


//radiused_shaft(d,length);


module radiused_shaft(d,length){
    cutWidth = max(d,d*headDiaFactor);
    
    difference(){
        translate([0,0,cos(overhang_angle)* d/2]) bit1(d);
        translate([0-cutWidth/2,-length-d-eps,-d])cube([cutWidth,length+4*d,d]);
    }
}
module bit1(d=d){
    module end(){if(roundEnds == true)sphere(d=d);}
    module rod(length=length,d=d){
        rotate([90,0,0])
            linear_extrude(height = length)circle(d = d);
    }
    {
        end();
        rod();
        translate([0,-length,0])end();
        if(headDiaFactor != 1) {
            headDia = headDiaFactor * d;
            headLength = d/2;
            translate([0,headLength,0])rod(headLength,headDia);
        }
    }
}







