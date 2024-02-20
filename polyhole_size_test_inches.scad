// polyhole size test from 
// https://hydraraptor.blogspot.com/2011/02/polyholes.html
// in 1/16th inches drf
// offset towards the center so an edge of the holes should be 
// the same distance from the side.

// plate length
width = 40;
// plate width
length=135;
// margin
margin = 10;
// mm vs inch toggle:
scheme = "mm";// [mm,inch]

function inch(x) = x * 25.4 * (scheme=="mm"?16/26.4:1);

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}


difference() {
 cube(size = [length ,width,3]);
    union() {
     for(i = [1:10]) {
            translate([(i * i + i)/1.4 + 3 * i , margin+inch((10-i)/16/2),-1])
                polyhole(h = 5, d = inch(i/16));
                
            let(d = i + 0.5)
                translate([(d * d + d)/1.4 + 3 * d, (width-margin)-(inch((10-i)/32)),-1])
                    polyhole(h = 5, d = inch(d/16));
     }
    }
}
