/*///////////////////////////////////////////////
//Prusa headband modifications
//brimcg02020@gmail.com 3/26/2020
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
////////////////////////////////////////////////*/

qty = 1;			// >1 will print 2 max

// Design type based off Prusa headband RC2 3/26/2020
// https://www.prusaprinters.org/prints/25857-prusa-protective-face-shield-rc1

3_hole = true;		// false for original Prusa 4-hole RC2
cinch = true;		// false for original Prusa button

pintest = false;	// true to build cropped part for pin location testing to save time and material;

// Design variable for different elastic band dimensions

elastic_width = 20;
elastic_width_margin = 1;
slot_narrow = 2;
slot_wide = 5;
ew = elastic_width + elastic_width_margin;
eh = 3.5;


// Hack design of Prusa headband RC2 and clean off their tabs for button hole elastic and pins for 4-hole, if specified

headband_left = 8;
headband_right = 180.5;
shield_center = [(headband_right+2.5-headband_left)/2 + headband_left, 42.6, 0];
shield_radius = 100.1;



module headband_org() {  // Why is it way off to the right?  Anyway hand force it to left corner.
	translate([-749, 65, 10]) import("covid19_headband_rc2.stl", convexity=4);
//	translate([103.3, 74, 12]) import("covid19_headband_rc3.stl", convexity=4);
}

module headband_hack() {
	intersection() {
		if(3_hole) {
			translate([0, 0, -1])translate(shield_center) cylinder(h=25, r=shield_radius, $fn=200, center=false);
			if(!cinch) translate([-1, -1, -1]) cube([headband_right + 25, 25, 25]);
		}
		if(cinch) difference()
		{
			headband_org();
			translate([-1, -1, -1]) cube([headband_right + 25, 25, 25]);
		}
		else headband_org();
	}
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
	if(h < 20) translate([x, 0, 0]) cube([2.5, 30, 20]);
	else translate([x, 0, 0]) cube([2.5, 30, h]);
	if(h > 20) translate([x, 30, 20]) prism(2.5, 5, h-20);
}

module slot(y) {
	translate([-1, 4, eh]) cube([4, y, ew]);
}

module slots() {
	slot(slot_wide);
	translate([0, 12, 0]) slot(slot_narrow);
	translate([0, 20, 0]) slot(slot_narrow);
}

module bandslot(x) {
	translate([x, 0, 0]) slots();
}

module pin(hp) {
	$fn = 20;
	rp = 2.7;
	intersection() {
		translate([0, 0, rp-0.3]) {
			rotate([-90, 0, 0]) cylinder(h=hp, r=rp);
			translate([0, hp, 0]) sphere(rp);
		}
		translate([-rp, 0, 0]) cube([2*rp, 4*rp, 2*rp]);
	}
}

module cinchtabs() {
	// tabs for cinch
	extension(headband_left);
	extension(headband_right);
}

module pins_3hole() {
	// new pins to match 3 hole punch
	spacing = 108 - 2; // had to readjust
	angle = spacing / 100 * 180 / PI;
	sr = shield_radius + 2.5/2;
	x = sr * sin(angle);
	y = sr * cos(angle)-2.5;
	embed = 1.2;
	
	translate([0, shield_radius-embed, 0]) translate(shield_center) pin(4); // center pin
	translate([-x+embed, y, 0]) translate(shield_center) rotate(90) pin(5); //left pin
	translate([x-embed, y, 0]) translate(shield_center) rotate(-90) pin(5); //right pin
}

module headband_ext() {
	headband_hack();
	if(cinch) cinchtabs();
	if(3_hole) pins_3hole();
}

module logo() {		// add web logo only if it's my modification
	if(3_hole || cinch) difference() {
		translate([0, shield_radius-15, 10]) translate(shield_center) rotate([90, 0, 180]) linear_extrude(height = 20) text("BRIMCG.GITHUB.IO / VISOR", size = 5, halign = "center", valign = "center");
		translate([0, 0, 10]) translate(shield_center) cylinder(h=25, r=shield_radius-0.75, $fn=200, center=true);
	}
}

module headband(angle = 0) {
	center = (headband_right+2.5-headband_left)/2 + headband_left;
	rotate([0, 0, angle]) translate([-center, -center+25, 0]) difference() {
		headband_ext();
		logo();

		if(cinch) {
			bandslot(headband_left);
			bandslot(headband_right);
		}

		if(pintest) {	// crop out majority for pin testing
			translate([0, -20, -1]) translate(shield_center) cylinder(h=50, r=shield_radius, $fn=100, center=false); 
			translate([0, 0, 6]) cube([200, 200, 50]); 
		}
	}
}

// Build it!!!
%translate([0, 0, -0.5]) cube([250, 200, 1], center=true);  //virtual Prusa build bed

if(qty > 1) {
	shiftx = 35;
	shifty = 16;
	translate([shiftx, -shifty, 0]) headband(-135);
	translate([-shiftx, shifty, 0]) headband(45);
}
else headband(180);
