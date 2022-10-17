/* Cartesian equations */
/* Sine wave bed adhesion/bed leveling test */
// https://www.thingiverse.com/thing:5516205
// https://www.printables.com/model/286875
// CC BY Drf5n drf5na@gmail.com 2022-09-16 

// Put the 2dgraphiing.scad file in your OpenSCAD include path per
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
include <2dgraphing.scad> // http://www.thingiverse.com/thing:11243

height = 0.2; // 0.1
width = 0.3; // 0.1
amplitude = 20; // 1
points = 500; // 1

pi = 3.14159;
function _f(x) = amplitude*sin((1/8)*x);
function f(x) = _f(d2r(x)); // called by function

linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);
      
translate([0,40,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);
      
translate([0,80,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);
      
translate([0,-40,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);      

translate([0,-80,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);