//$fn=20;
include <BOSL2/std.scad>

//include <../core/main.scad>
//include <../reference_devices/reference_devices.scad>
//support(1, x_holes=false);

// Surface Pro 3 = 292, 201, 9

// ===== Device dimensions (mm) =====
device_width = 200; // [100:1:300]
device_depth = 10; // [5:1:50]
device_height = 280; // [100:1:400]


// Bevel Style//
// extra length in units (15mm each) to add to the device holder //
addition_units_width = 0; // [0:1:10]
addition_units_height = 0; // [0:1:10] 

module reference_unit() {
  cuboid(15, chamfer=.5);
  }

module reference_support(length=10) {
  cuboid([length * 15, 15, 15], chamfer=.5);
}

module reference_device() {
  color("gray")
  cuboid([device_width, device_depth, device_height], chamfer=1);
}

module bevel() {
  step = 15;
  w = (ceil((device_width  + 30) / step) * step ) + (addition_units_width * 15);
  h = (ceil((device_height + 30) / step) * step)  + (addition_units_height * 15);
  color("black")
  cuboid([w, 2, h]);
}

// Render the selected device plus the reference pieces
reference_device();
reference_unit(); 
reference_support(length=16);

rotate([0,90,0])
reference_support(length=21);
bevel();
