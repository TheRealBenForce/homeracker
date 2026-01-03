//$fn=20;
include <BOSL2/std.scad>

/* [Bounding dimensions (units)] */

unit_width = 9; // Your device must fit into this.
unit_depth = 4; // Your device must fit into this.
unit_height = 15; // Your device must fit into this.

/* [Device dimensions (mm)] */
device_width = 75; // [100:1:300]
device_depth = 10; // [5:1:50]
device_height = 150; // [100:1:400]
device_rounding = 5; // [0:1:50]

/* [Display options] */
// Export to print view when you are ready.
orientation= "Display"; // ["Display", "Cage", "Print"]
// Show the reference unit block. Won't appear in print view.
show_reference_unit = false; 
// Show the reference support block. Won't appear in print view.
show_reference_support = false; 
// Show the reference device block. Won't appear in print view.
show_reference_device = true; 

/* [Experimental] */
unit_size=15; // Size of one unit of measurement. Defaults to 15 for homeracker.

/* [Hidden] */
x = unit_height * unit_size;
y = unit_depth * unit_size;
z = unit_width * unit_size;

hypotenuse = sqrt(x*x + y*y);
angle = atan2(y, x); // OpenSCAD returns degrees already

echo(hypotenuse_mm = hypotenuse);
echo(rotation_deg = angle);

module reference_unit() {
  cuboid(unit, chamfer=.5);
  }

module reference_support(length=10) {
  cuboid([length * 15, 15, 15], chamfer=.5);
}

module reference_device() {
  color("gray")
  cuboid([device_width, device_depth, device_height], rounding=device_rounding, edges=[TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT]);
}

module bevel() {
  step = 15;
  w = (ceil((device_width  + 30) / step) * step );
  h = (ceil((device_height + 30) / step) * step);
  color("black")
  cuboid([w, 2, h]);
}

// Render the selected device plus the reference pieces
if (show_reference_support){
  reference_support(length=10);
}
if (show_reference_unit){
  reference_unit();
}
if (show_reference_device){
  reference_device();
}



if (orientation[0] == "Cage") {
  color("blue", 0.5)
  cuboid([unit * unit_width, unit * unit_depth, unit * unit_height], chamfer=.5, edges=[FRONT, BACK, LEFT, RIGHT, TOP, BOTTOM]);
}


bevel();


