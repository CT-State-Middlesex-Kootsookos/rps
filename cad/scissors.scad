module ring(inner,outer)
{
    difference()
    {        
        cylinder(10,outer,outer);
        translate([0,0,-1]) cylinder(12,inner,inner);
    }
};

module sciss()
{
ring(10,15);
linear_extrude(10) polygon([[-10,10],[10,10],[-70,70]]);
}

module scissors()
{
sciss();
translate([-50,0,0]) mirror() sciss();
}

linear_extrude(10) square([100,100]);
translate([75,25,10]) scissors();
