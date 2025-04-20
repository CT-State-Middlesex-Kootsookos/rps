module basic_box()
{
    difference()
    {
        linear_extrude(25) square([110,110]);
        translate([5,5,5]) linear_extrude(25) square([101,101]);
    }
}


difference()
{
    basic_box();
    union()
    {
    translate([-5,55,10]) rotate([0,90,0]) cylinder(11,4,4);
    translate([100,55,10]) rotate([0,90,0]) cylinder(11,2.7,2.7);
    }
}


translate([55,55,0])
difference()
{
    linear_extrude(12) square([8,8]);
    translate([-1,1,5]) linear_extrude(16) square([8,6.5]);
}

translate([110,25,0]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(2) text("COMPUTER WINS", 5);