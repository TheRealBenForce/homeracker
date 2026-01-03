include <BOSL2/std.scad>;

module surface_pro_3() {
    // Not print verified
    color("grey")
    cuboid([201, 9, 292], rounding=6, edges=[TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT]);
}

module generic_phone() {
    color("grey")
    cuboid([75, 10, 150], rounding=10, edges=[TOP+RIGHT, TOP+LEFT, BOTTOM+RIGHT, BOTTOM+LEFT]);
}