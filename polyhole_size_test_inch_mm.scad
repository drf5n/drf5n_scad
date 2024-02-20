// polyhole size test from 
// https://hydraraptor.blogspot.com/2011/02/polyholes.html
// in 1/16th inches drf
// offset towards the center so an edge of the holes should be 
// the same distance from the side.
// https://www.thingiverse.com/thing:5564300
// based on https://www.thingiverse.com/thing:6118
// and http://hydraraptor.blogspot.com/2011/02/polyholes.html


// plate length
width = 30;
// plate width
length=125;
// center margin
margin = 0;
// number of holes (by 0.5mm or 1/32")
pairs = 10; // 1.0 
// mm vs inch toggle:
scheme = "mm";// [mm,inch]

// global polyhole rotation
polyrotation = 90; // 

K = scheme=="mm"? 1 : (25.4/32);

module polyhole(h, d, polyrotation = polyrotation) { // modified to align flat with axis
    n = max(round(2 * d),3); 
    rotate([0,0,polyrotation +180/n])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}


difference() {
 cube(size = [length ,width,3]);
    union() {
     for(i = [1:pairs]) {
            translate([(i * i + i)/1.4 + 3 * i , (width+margin)/2+i*K/2,-1])
                    rotate([0,0,180])polyhole(h = 5, d = i*K);
                
            let(d = i + 0.5)
                translate([(d * d + d)/1.4 + 3 * d, (width-margin)/2-d*K/2,-1])
                    rotate([0,0,0])polyhole(h = 5, d = d*K);
     }
translate([2,27,-.1])linear_extrude(0.3) rotate([180,0,0])
     text(scheme=="mm"?"1mm X 0.5mm":"Inch: 1/32\"x1/64\"", size=5);
translate([2,4,-.1])linear_extrude(0.3) rotate([180,0,0])
     text("https://www.thingiverse.com/thing:5564505", size=3);
     
    }
}

