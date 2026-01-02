//$fn=20;
include <BOSL2/std.scad>

// Homeraker dimensions (units)
Homeracker_units_width = 120; // Count how many holes corner to corner
Homeracker_units_depth = 80; // Count how many holes corner to corner

// Device dimensions (mm)
device_width = 75; // [100:1:300]
device_depth = 10; // [5:1:50]
device_height = 150; // [100:1:400]
device_rounding = 10; // [0:1:50]

module reference_unit() {
  cuboid(15, chamfer=.5);
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
  cuboid([w, 2, h]);
}



// Render the selected device plus the reference pieces
reference_device();
reference_unit(); 
//reference_support(length=16);



rotate([0,90,0])
//reference_support(length=21);
bevel();


