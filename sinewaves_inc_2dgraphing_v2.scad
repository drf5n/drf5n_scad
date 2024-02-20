/* Cartesian equations */
/* Sine wave bed adhesion/bed leveling test */
// https://www.thingiverse.com/thing:5516205
// CC BY Drf5n drf5na@gmail.com 2022-09-16 

// Put the 2dgraphiing.scad file in your OpenSCAD include path per
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries

// for thingiverse on-line customization: expand includes into flat file:
//include 2dgraphing.scad // http://www.thingiverse.com/thing:11243

height = 0.2; // 0.1 mm level height
width = 0.3; // 0.1 mm wide traces
width_increment = 0.0 ; // 0.1 mm 
spacing = 40; // 5 mm between traces
count = 5; // 1 number of traces
amplitude = 20; // 1
points = 500; // 1
bed_width = 200; //mm 
bed_depth = 200; //mm 

pi = 3.14159 * 0;
// function to convert degrees to radians
function d2r(theta) = theta*360/(2*pi);

function _f(x) = amplitude*sin((1/8)*x);
function f(x) = _f(d2r(x)); // called by function

translate([-bed_width/2, -bed_depth/2,0]) // center on 0,0 
for (i = [0:count-1]) { 

//linear_extrude(height=height)
//      2dgraph([-100, 100], width+i*width_increment, steps=points);
      
translate([0,i*spacing,0]) linear_extrude(height=height)
      2dgraph([0, bed_width], width+i*width_increment, steps=points);

/*      
translate([0,80,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);
      
translate([0,-40,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);      

translate([0,-80,0]) linear_extrude(height=height)
      2dgraph([-100, 100], width, steps=points);
*/
}


////// begin include/////////////////////////////

// These functions are here to help get the slope of each segment, and use that to find points for a correctly oriented polygon
function diffx(x1, y1, x2, y2, th) = cos(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function diffy(x1, y1, x2, y2, th) = sin(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function point1(x1, y1, x2, y2, th) = [x1-diffx(x1, y1, x2, y2, th), y1-diffy(x1, y1, x2, y2, th)];
function point2(x1, y1, x2, y2, th) = [x2-diffx(x1, y1, x2, y2, th), y2-diffy(x1, y1, x2, y2, th)];
function point3(x1, y1, x2, y2, th) = [x2+diffx(x1, y1, x2, y2, th), y2+diffy(x1, y1, x2, y2, th)];
function point4(x1, y1, x2, y2, th) = [x1+diffx(x1, y1, x2, y2, th), y1+diffy(x1, y1, x2, y2, th)];
function polarX(theta) = cos(theta)*r(theta);
function polarY(theta) = sin(theta)*r(theta);

module nextPolygon(x1, y1, x2, y2, x3, y3, th) {
	if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th)))) {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				// This point connects this segment to the next
				point4(x2, y2, x3, y3, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3,4]]
		);
	}
	else if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th)))) {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				// This point connects this segment to the next
				point1(x2, y2, x3, y3, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3,4]]
		);
	}
	else {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3]]
		);
	}
}

module 2dgraph(bounds=[-10,10], th=2, steps=10, polar=false, parametric=false) {
	step = (bounds[1]-bounds[0])/steps;
	union() {
		for(i = [bounds[0]:step:bounds[1]-step]) {
			if(polar) {
				nextPolygon(polarX(i), polarY(i), polarX(i+step), polarY(i+step), polarX(i+2*step), polarY(i+2*step), th);
			}
			else if(parametric) {
				nextPolygon(x(i), y(i), x(i+step), y(i+step), x(i+2*step), y(i+2*step), th);
			}
			else {
				nextPolygon(i, f(i), i+step, f(i+step), i+2*step, f(i+2*step), th);
			}
		}
	}
}


////// end include /////////////

