// paper?


linear_extrude(10) square([100,100]);
    translate([5,5,9]) 
    difference()
    {

        linear_extrude(5) square([90,90]);
        linear_extrude(6) polygon([[-10,-10],[30,-10],[-10,30],[-10,-10]]);
    }