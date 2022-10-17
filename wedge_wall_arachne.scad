// Arachne thin wall wedge test
// wedge wall along X
// https://www.printables.com/model/286864
// https://www.thingiverse.com/thing:5541710

// Customization options
// height of wedge wall
height = 2; // 0.1 mm 

//length of wedge 
length = 100; // 1 mm

//width of wide end
thickness = 2; // 0.1 mm

// rotation from vertical wedge wall along x
rot = [0,0,0]; // xyz deg

rotate(rot)wedge(length,height,thickness);

module wedge(len, wid, thick){ // change prism orientation to wall along x
    translate([len,0,height])
        rotate([90,90,180])
            prism(wid,len,thickness);
}

module prism(l, w, h){ // x,y,z
    // from https://en.m.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
    // copied 2022-10-01 
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}