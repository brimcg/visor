
// Design variable for different elastic band dimensions
elastic_width = 20;
elastic_width_margin = 1;
slot_narrow = 2;
slot_wide = 5;
ew = elastic_width + elastic_width_margin;
eh = 3.5;


// Hack design of Prusa headband RC2 and clean off their tabs for button hole elastic
headband_left = 8;
headband_right = 180.5;

module headband_org()   // Why is it way off the the right?  Anyway hand force it to left corner.
	translate([-749, 65, 10]) import("covid19_headband_rc2.stl", convexity=4);

module headband_hack()
	difference() {
		headband_org();
		translate([-1, -1, -1]) cube([9, 25, 25]);
		translate([183, -1, -1]) cube([9, 25, 25]);
	}



// Add my cinch strap design

module prism(l, w, h) {
   translate([l, w, 0]) rotate([0, 0, 180]) polyhedron(
		   points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
		   faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
		   );
}

module extension(x) {
	h = ew + 2*eh;
	translate([x, 0, 0]) cube([2.5, 30, h]);
	translate([x, 30, 20]) prism(2.5, 5, h-20);
}

module slot(y)
	translate([-1, 4, eh]) cube([4, y, ew]);

module slots(x) {
	translate([x, 0, 0]) {
		slot(slot_wide);
		translate([0, 12, 0]) slot(slot_narrow);
		translate([0, 20, 0]) slot(slot_narrow);
	}
}

module headband_ext() {
	headband_hack();
	extension(headband_left);
	extension(headband_right);
}


// Build it!!!
difference() {
	headband_ext();
	slots(headband_left);
	slots(headband_right);
}
