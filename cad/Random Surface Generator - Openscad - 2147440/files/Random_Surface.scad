// Module Made By Kevin Symss //// 
 
 X=15; Y=15; // this is 12 x 12 , 144 combinations
 
 resize(newsize=[90,90,10])  // change here to adjust rough size
 
// difference()
 {    
     difference()
     {    
        Random_Surface(); 
        union()
        {
            translate([-15,-10,-10]) linear_extrude(30) square([15,150]);
            translate([10,-10,-10]) linear_extrude(30) square([15,150]);
            translate([-10,-15,-10]) linear_extrude(30) square([150,15]);
            translate([-10,10,-10]) linear_extrude(30) square([150,15]);
        }
     }
 }
     
 module Random_Surface() 
 {
 for(x=[0:1:X ]) for(y=[0:1:Y])
    {
        single_rand = rands(0,4,1)[0]; //12345+x+X*y

        translate([x,y,single_rand  +4])rotate([x,y,single_rand*10])

        resize(newsize=[5,5
        ,8])    sphere(r=4 ,$fn=single_rand+3);
    }
     ;
     translate([0,0,-1]) cube(size = [X,Y,10], center =  false); 
}