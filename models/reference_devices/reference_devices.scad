include <BOSL2/std.scad>;

module surface_pro_3() {
    // Not print verified
    color("grey")
    cuboid([201, 9, 292], chamfer=6,center=true);
}

module generic_phone() {
    color("grey")
    cube([75, 10, 150], radius=10, center=true);
}