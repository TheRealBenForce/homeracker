//$fn=20;
include <BOSL2/std.scad>

// Global dimensions (units)
unit=15; // Size of one unit of measurement. Defaults to 15 for homeracker.
unit_width = 9; // Your device must fit into this.
unit_depth = 4; // Your device must fit into this.
unit_height = 15; // Your device must fit into this.
display_cage = false; // Set to true to display the full cage for reference.

// Device dimensions (mm)
device_width = 75; // [100:1:300]
device_depth = 10; // [5:1:50]
device_height = 150; // [100:1:400]
device_rounding = 10; // [0:1:50]


module reference_unit() {
  cuboid(unit, chamfer=.5);
  }

module reference_support(length=10) {
  cuboid([length * 15, 15, 15], chamfer=.5);
}

module reference_device() {
  color("gray")
  cuboid([device_width, device_depth, device_height], rounding=device_rounding, edges=[RIGHT, LEFT]);
}

module bevel() {
  step = 15;
  w = (ceil((device_width  + 30) / step) * step );
  h = (ceil((device_height + 30) / step) * step);
  color("black")
  cuboid([h, 2, w]);
}

if (display_cage) {
  color("blue", 0.5)
  cuboid([unit * unit_width, unit * unit_depth, unit * unit_height], chamfer=.5, edges=[FRONT, BACK, LEFT, RIGHT, TOP, BOTTOM]);
}

// Render the selected device plus the reference pieces
reference_device();
reference_unit(); 
//reference_support(length=16);



rotate([0,90,0])
//reference_support(length=21);
bevel();


