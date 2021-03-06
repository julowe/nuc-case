//original NUC Case (NUC7i7DNBE) by mraiseris 
// https://www.thingiverse.com/thing:3706360
//licensed under the Creative Commons - Attribution license.

//updates by Justin Lowe 20201029 for NUC7i3DNB (should be same dimensions as above, but in previous model the power button was not aligned)
// https://www.thingiverse.com/thing:4637866
//objects released under Creative Commons - Attribution license, code under GPLv3

//changes:
// * added comments
// * renamed peg to standoff
// * renamed peg2 to foot
// * placed center foot
// * renamed powerButton to powerButtonV1
// * added powerButtonV2
// * added Y support bar to cicrular vent fan on top lid
// * made edges/lips down from case lid 2 wide instead of 1
// * made bottom case wall thicker
// * vents on bottom of case (to offer some protection to components there)
// * fixed bottom case corners overlapping and biting off some of standoffs
// * chamfer all edges inside case lid (top)
// * fan vent moved from +6 Y to +4 Y


//tolerance for 3d printer - used for spacing between top and bottom of case, and power button and hole
T = 0.2;

T2 = T * 2;

renderFNs = 180;
draftFNs = 36;
$fn = renderFNs;



//entire bottom of case
module bottom(){
    union(){
        difference(){
            //main cube to subtract everything from
            //change: cube 2 larger in x and y now, wall thicker
            translate([0,0,19])cube([111,110,34],true);
            
            //major subtraction to form inner case void
            translate([0,0,18])cube([107,106,37],true);
            
            //subtract square corners now - add rounded later
            translate([-53,-52.5,19])cube([9,9,36],true);
            translate([-53,52.5,19])cube([9,9,36],true);
            translate([53,-52.5,19])cube([9,9,36],true);
            translate([53,52.5,19])cube([9,9,36],true);
            
            //subtraction for read I/O ports        
            translate([10,0,25])cube([107,88,37],true);
            
            //subtraction for front I/O ports
            translate([-10,6,29])cube([107,34,37],true);
            
            //TODO move power button hole, reshape to fit new power button
            //subtraction for power button hole
//            translate([-57,-27,15])rotate([0,90,0])cylinder(h=10,d=3,$fn=20);
            
            
            //TODO check Z
            // looks good actually, centered on button... coudl be higher but meh

//TODO check Y
//19.5 from edge of usb io hole
//        translate([-xxxx,-47.5,0]){
//13.5 to 22.5 from standoff
//measured: -35.0 to -24.0 gap in board, center then 29.5
//current: -30.5 to -23.5
//prposed: 32.5 to 26.5
//END check y
//
            translate([-55,-30,15]){
                rotate([0,-90,0]){
                    //button square, through and outside case
                    buttonRounding = 0.5;
                    buttonSize = 7+T*2;
                    buttonHeight = 4;
                    cube([buttonSize-buttonRounding*2,buttonSize,buttonHeight],true);
                    cube([buttonSize,buttonSize-buttonRounding*2,buttonHeight],true);
                    translate([buttonSize/2-buttonRounding,buttonSize/2-buttonRounding,-2]){
                        cylinder(buttonHeight,buttonRounding,buttonRounding);
                    }
                    translate([-(buttonSize/2-buttonRounding),(buttonSize/2-buttonRounding),-2]){
                        cylinder(buttonHeight,buttonRounding,buttonRounding);
                    }
                    translate([-(buttonSize/2-buttonRounding),-(buttonSize/2-buttonRounding),-2]){
                        cylinder(buttonHeight,buttonRounding,buttonRounding);
                    }
                    translate([(buttonSize/2-buttonRounding),-(buttonSize/2-buttonRounding),-2]){
                        cylinder(buttonHeight,buttonRounding,buttonRounding);
                    }
                }
                   
            }
            
            
        }
        
        //support bars for feet
        difference(){
            //main plane that sits on top of feet //3,5 //2.5,5.5
            translate([0,0,3.75])cube([100,98,2.5],true);
            
            //subtract inner lower part of plane to have support bars for bridging vent holes
            translate([0,23.5,0])cube([91,43,6],true);
            translate([0,-23.5,0])cube([91,43,6],true);
            
            //TODO will this slice well, or do i need to put a thin strip under middle support bar?
            for (i = [-1:2:1]){
                for (j =[0:11]){
                    translate([44-(j*8),23.5*i,3])cube([4,43,7],true);
                }
            }
        }
        
        //add board standoffs/mounts
        translate([-45.75,-47.5,0]){
            translate([0,0,0])standoff();
            translate([91.5,0,0])standoff();
            translate([0,95,0])standoff();
            translate([91.5,95,0])standoff();
        }
        
        //add corner feet
        translate([-48.5,-48,0])foot();
        translate([48.5,-48,0])foot();
        translate([-48.5,48,0])foot();
        translate([48.5,48,0])foot();

        //add feet in middle of edges            
        translate([0,-48,0])foot();
        translate([-48.5,0,0])foot();
        translate([0,48,0])foot();
        translate([48.5,0,0])foot();
        
        //change: place center foot
        //center foot
        foot();
        
        //add rounded corners
        translate([-48.5,-48,0])rotate([0,0,0])roundedCorners();
        translate([48.5,-48,0])rotate([0,0,90])roundedCorners();
        translate([-48.5,48,0])rotate([0,0,-90])roundedCorners();
        translate([48.5,48,0])rotate([0,0,180])roundedCorners();
        
    }

}

//cylindrical standoffs that circuit board screws into
module standoff(){
    difference(){
        cylinder(h=18, d=6, $fn=200);
        translate([0,0,5])cylinder(h=23, d=3, $fn=200);
    }
}

//circular feet on bottom of case
module foot(){
    //change: feet 14 now, were 12
        cylinder(h=3, d=14, $fn=200);
}

//bottom case rounded corners
module roundedCorners(){
    intersection(){
        translate([-6,-6,18])cube([12,12,36],true);
        difference(){
            //change: d=14 now, was 12
            cylinder(h=36, d=14, $fn=200);
            cylinder(h=37, d=10, $fn=200);
        }
    }
}

//rounding for corners of top case
module cornercutout2(){
    difference(){
        translate([-6,-6,50.5])cube([12,12,98],true);
        //change: d=14 now, was 12
        cylinder(h=100, d=14, $fn=200);
    }
}

//entire top of case
module top(){
    translate([0,0,T]){
        difference(){ //1st difference
            //
            union(){
                //top plane of case
                //change: cube 2 larger in x and y now, wall thicker
                translate([0,0,37])cube([111,110,2],true);
                
                //cube make edges (running parallel to X axis) down into case
                translate([0,0,30])cube([90,106-T2,12],true);
                
                //front edge down into case (over I/O ports)
                translate([-54.5+T,6,27.25])cube([2+T2,34-T2,20],true);
                //lip behind/around front edge
                translate([-53+T,6,27.25])cube([1,40,20],true);
                //chamfered lip behind/around front edge
                translate([-53+T+(2/2)+1,6,33+(3/2)])cube([1+2,40,20-17],true);

                //back edge down into case (over main I/O ports)
                translate([54.5-T,0,27.25])cube([2+T2,88-T2,20],true);
                //lip behind/around back edge
                translate([53-T,0,27.25])cube([1,94,20],true);
                //chamfered lip behind/around back edge
                translate([53-T-(1/2)-1,0,33+(4/2)])cube([1+1,94,20-18],true); //i messed up this math somehow but the magic numbers work so i'm done. TODO FIXME... ha.
                //larger radius would be better, this edge is still a bit flimsy, but fine when all together
            }
            
            //round edges of top plane of case
            translate([-48.5,-48,0])rotate([0,0,0])cornercutout2();
            translate([48.5,-48,0])rotate([0,0,90])cornercutout2();
            translate([-48.5,48,0])rotate([0,0,-90])cornercutout2();
            translate([48.5,48,0])rotate([0,0,180])cornercutout2();

            //subtract cube inside case, leave edges/lips down into case (running parallel to X axis)
            //change: subtraction cube is now 102 wide instead of 104
            translate([0,0,34])cube([92,96-T2,4],true); //cube is +2 in the X dimension to get rid of "wall" in preview view
            translate([0,0,27.5])cube([92,102-T2,11],true); //cube is +2 in the X dimension to get rid of "wall" in preview view
            
            //chamfer long edges
            translate([-50,48-T,33]){
                rotate([0,90,0]){
                    cylinder(100,3,3,$fn=200);
                }
            }
            translate([-50,-(48-T),33]){
                rotate([0,90,0]){
                    cylinder(100,3,3,$fn=200);
                }
            }
            
            //chamfer front edge
            translate([-53+T+(1)/2+3,(48-T),33]){
                rotate([90,0,0]){
                    cylinder(95,3,3,$fn=200);
                }
            }
            
            //chamfer rear edge
            translate([53-T-(1)/2-2,(48-T),34]){
                rotate([90,0,0]){
                    cylinder(95,2,2,$fn=200);
                }
            }

            //make back opening 1.5mm smaller only on outer edge next to USB ports
            usbAdjustment = 1.5;
            //remove material for ethernet and USB ports on back edge
            translate([54-T,6-usbAdjustment/2,13])cube([10,36-usbAdjustment,20],true);
            
            difference(){ //2nd difference
                union(){
                    //make rectangular/vertical fan vent holes on back edge (ZY plane)
                    translate([54-T,0,35])cube([10,80,2],true);
                    translate([54-T,0,31])cube([10,80,2],true);
                    translate([54-T,0,27])cube([10,80,2],true);

                    //make vent holes towards back of case on top plane (XY plane)
                    translate([51,0,35])cube([2,80,10],true);
                    translate([47,0,35])cube([2,80,10],true);
                    translate([43,0,35])cube([2,80,10],true);
                }
                
                //add back central support on ZY & XY plane vents
                translate([54-T,0,35])cube([30,10,30],true);
            } //end 2nd difference
            
            //fan vent moved from +6 Y to +4 Y, -20 X to -24 X
            difference(){ //3rd difference
                union(){
                    difference(){
                        //large outer cylinder to make outer donut that will be removed
                        translate([-24,4,27.25])cylinder(d=40, h=100, $fn=200);
                        //smaller inner cylinder to make outer donut that will be removed
                        translate([-24,4,27.25])cylinder(d=36, h=100, $fn=200);
                    }
                    
                    difference(){
                        //large outer cylinder to make middle donut that will be removed
                        translate([-24,4,27.25])cylinder(d=32, h=100, $fn=200);
                        //smaller inner cylinder to make middle donut that will be removed
                        translate([-24,4,27.25])cylinder(d=28, h=100, $fn=200);
                    }
                    
                    difference(){
                        //large outer cylinder to make inner donut that will be removed
                        translate([-24,4,27.25])cylinder(d=24, h=100, $fn=200);
                        //smaller inner cylinder to make inner donut that will be removed
                        translate([-24,4,27.25])cylinder(d=20, h=100, $fn=200);
                    }
                }
                //add X support bar to circular fan vent
                translate([-24,4,27.25])cube([100,2,100], true);
                //change: add Y support bar
                //add Y support bar to circular fan vent
                translate([-24,4,27.25])cube([2,100,100], true);
            } //end 3rd difference
        } //end 1st difference
    } //end translate
}

//TODO change power button to be less stabby
module powerButtonV2(){
    //7mm wide back, 5mm wide button
    difference(){
        union(){
            //base square, inside case
            cube([9,9,3],true);
            translate([0,0,3]){
                //button square, through and outside case
                buttonRounding = 0.5;
                buttonSize = 7;
                buttonHeight = 4;
                cube([buttonSize-buttonRounding*2,buttonSize,buttonHeight],true);
                cube([buttonSize,buttonSize-buttonRounding*2,buttonHeight],true);
                translate([buttonSize/2-buttonRounding,buttonSize/2-buttonRounding,-2]){
                    cylinder(buttonHeight,buttonRounding,buttonRounding);
                }
                translate([-(buttonSize/2-buttonRounding),(buttonSize/2-buttonRounding),-2]){
                    cylinder(buttonHeight,buttonRounding,buttonRounding);
                }
                translate([-(buttonSize/2-buttonRounding),-(buttonSize/2-buttonRounding),-2]){
                    cylinder(buttonHeight,buttonRounding,buttonRounding);
                }
                translate([(buttonSize/2-buttonRounding),-(buttonSize/2-buttonRounding),-2]){
                    cylinder(buttonHeight,buttonRounding,buttonRounding);
                }
                   
            }
        }
        
        //power button icon
        solidBottom = -1.0; //-1.5 is flush
        solidTop = -2.5; //-2 is flush
        iconOffset = solidBottom;
        translate([0,0.0,iconOffset]){
            iconAngle = 55;
            translate([0,0,0]){
                rotate([0,0,-35]){
                    rotate_extrude(angle=360-iconAngle*2, convexity = 10){
                        translate([1.0, 0, 0]){
                            square([1,7]);
                        }
                    }
                }
            }
            
            //circle part
            rotate([0,0,iconAngle]){
                translate([0,-1.5,0]){
                    cylinder(7,0.5,0.5);
                }
            }
            rotate([0,0,-iconAngle]){
                translate([0,-1.5,0]){
                    cylinder(7,0.5,0.5);
                }
            }
            
            //line part
            translate([0,-1.7,0]){
                cylinder(7,0.35,0.35);
            }
            translate([0,-0.2,0]){
                cylinder(7,0.35,0.35);
            }
            translate([-0.35,-1.7,0]){
                cube([0.7,1.5,7]);
            }

        }
    }
    
}




module powerButtonV1(){
    union(){
        cylinder(d1=6,d2=0,h=3,$fn=20);
        cylinder(d=2,h=6,$fn=20);
    }
}



//translated to the side, just because i keep forgetting it is there...
translate([80,0,0]){
//    powerButtonV1();
//    powerButtonV2();
}

//diffrence function below is retained so you can print partial test pieces (if you use a different board)
//difference(){
bottom();
//top();

//translate([-34,-100,0]){
//    cube([200,200,50]);
//}
//
//translate([-70,2,0]){
//    cube([200,200,50]);
//}
//translate([-70,-80,20]){
//    cube([200,200,50]);
//}
//
//}
//
//
//
//
//translate([-39,-2,0]){
//    cube([5,4,3]);
//}
//
//translate([-39,-55,0]){
//    cube([5,10,3]);
//}
