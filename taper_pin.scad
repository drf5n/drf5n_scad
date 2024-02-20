// radiused_rod.scad
// https://www.thingiverse.com/thing:6079195

        use <MCAD/regular_shapes.scad>

d1 = 2;
d2 = 10;
length = 10;

overhang_angle = 45;

$fn=36;
eps = 0.0001;



// shaft with a ball on the end, flattened for printing

radiused_shaft();

dmin=min(d1,d2);
dmax = max(d1,d2);

module radiused_shaft(){

difference(){
translate([0,0,cos(overhang_angle)* dmax/2]) bit1();
translate([0-dmax/2,-length-dmax-eps,-dmax])cube([dmax,length+4*dmax,dmax]);
}
}
module bit1(d1=d1,d2=d2){
    module end(d){sphere(d=d);}
    module rod(){
        rotate([90+atan((d1-d2)/length/2),0,0])
            cylinder(d1=d1,d2=d2,h=length);
    }
    {
        translate([0,0,-(d2-d1)/2]) end(d1);
        translate([0,0,-(d2-d1)/2]) rod();
        translate([0,-length,0]) end(d2);
    }
}





