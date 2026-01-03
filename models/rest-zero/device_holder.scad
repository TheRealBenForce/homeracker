//$fn=20;
include <BOSL2/std.scad>

/* [Device dimensions (mm)] */
device_width = 75; // [100:1:300]
device_depth = 10; // [5:1:50]
device_height = 150; // [100:1:400]
device_rounding = 5; // [0:1:50]

/* [Bounding dimensions (units)] */
// Your device must fit into this. Play around with it until you are happy.
x_units = 7; // [1:1:50]
// Your device must fit into this.
y_units = 4; // [1:1:50]
// Your device must fit into this.
z_units = 15; // [1:1:50]

/* [Display options] */
// Export to print view when you are ready.
orientation= "Display"; // ["Display", "Print"]
// Show the reference unit block. Won't appear in print view.
show_reference_unit = false; 
// Show the reference support block. Won't appear in print view.
show_reference_supports = false; 
// Show the reference device block. Won't appear in print view.
show_reference_device = true; 
// Show angle size for reference.
show_angle_label = true;

/* [Experimental] */
unit_size_mm=15; // Size of one unit of measurement. Defaults to 15 for homeracker.

/* [Hidden] */
x_mm  = (x_units  * unit_size_mm);
y_mm  = y_units  * unit_size_mm;
z_mm  = z_units  * unit_size_mm;

tilt_length_mm = sqrt(z_mm*z_mm + y_mm*y_mm);
tilt_angle_deg = atan2(y_mm, z_mm); // OpenSCAD = degrees

echo("Tilt length (mm): ", tilt_length_mm);
echo("Tilt angle (deg): ", tilt_angle_deg);

module reference_unit() {
  cuboid(unit, chamfer=.5);
  }

module reference_support(length=10) {
  color("lightblue", .7)
  cuboid([length * unit_size_mm, unit_size_mm, unit_size_mm], chamfer=.5);
}

module reference_device() {
  color("gray")
  cuboid([device_width, device_depth, device_height], rounding=device_rounding, edges=[TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT]);
}

// BOSL2-based angle label
module angle_label(
    tilt_angle_deg,
    pos = [0,0,0],
    size = 8,
    thickness = 1,
    decimals = 1,
    orient = [0,0,0]
) {
    angle_txt = str("~", round_to(tilt_angle_deg, decimals), "°");

    translate(pos)
    rotate(orient)
        text3d(
            angle_txt,
            size = size,
            height = thickness,
            anchor = CENTER
        );
}

module bevel() {
  bevel_width  = x_mm;
  bevel_height = tilt_length_mm;

  color("black")
  rotate([360-tilt_angle_deg, 0, 0])
    cuboid([bevel_width, 2, bevel_height]);
}

// Render the selected device plus the reference pieces
if (show_reference_supports){
  // Bottoms
  left((x_mm / 2) - (unit_size_mm / 2))
  down((z_mm / 2) - (unit_size_mm / 2))
  zrot(90)
  reference_support(length= y_units);

  right((x_mm / 2) - (unit_size_mm / 2))
  down((z_mm / 2) - (unit_size_mm / 2))
  zrot(90)
  reference_support(length= y_units);

  // Width
  up((z_mm / 2) - (unit_size_mm / 2))
  back((y_mm / 2) - (unit_size_mm / 2))
  reference_support(length= x_units);

  down((z_mm / 2) - (unit_size_mm / 2))
  back((y_mm / 2) - (unit_size_mm / 2))
  reference_support(length= x_units);

  down((z_mm / 2) - (unit_size_mm / 2))
  back(-(y_mm / 2) + (unit_size_mm / 2))
  reference_support(length= x_units);

  // Sides
  back((y_mm / 2) - (unit_size_mm / 2)){
    left((x_mm / 2) - (unit_size_mm / 2))
    yrot(90)
    reference_support(length= z_units);
    right((x_mm / 2) - (unit_size_mm / 2))
    yrot(90)
    reference_support(length= z_units);
  }
}
if (show_reference_unit){
  
  reference_unit();
}
if (show_reference_device){
  rotate([360 - tilt_angle_deg, 0, 0])
  reference_device();
}

if (show_angle_label){
  //rotate([90, 0, 0])
  translate([ 0, 0, 0])
  angle_label(
      tilt_angle_deg,
      pos = [0, -y_mm / 2, 0],
      size = 20,
      thickness = 1,
      decimals = 1,
      orient = [90, 0, 0]   // face upward
  );
}

if (orientation == "Display") {
  bevel();
}

// Utility: controlled rounding
function round_to(n, decimals=1) =
    round(n * pow(10, decimals)) / pow(10, decimals);

