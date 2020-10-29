T = 0.2;

T2 = T * 2;

module bottom(){
    difference(){
        union(){
            difference(){
                translate([0,0,19])cube([109,108,34],true);
                translate([0,0,18])cube([107,106,37],true);
                translate([10,0,25])cube([107,88,37],true);
                translate([-10,6,29])cube([107,34,37],true);
                translate([-57,-31,15])rotate([0,90,0])cylinder(h=10,d=3,$fn=20);
            }
            
            difference(){
                translate([0,0,4])cube([99,98,2],true);
                translate([0,0,3])cube([91,90,7],true);
            }
            
            translate([-45.75,-47.5,0]){
                translate([0,0,0])peg();
                translate([91.5,0,0])peg();
                translate([0,95,0])peg();
                translate([91.5,95,0])peg();
            }
            
            translate([-48.5,-48,0])peg2();
            translate([48.5,-48,0])peg2();
            translate([-48.5,48,0])peg2();
            translate([48.5,48,0])peg2();
            
            translate([0,-48,0])peg2();
            translate([-48.5,0,0])peg2();
            translate([0,48,0])peg2();
            translate([48.5,0,0])peg2();
            
            translate([-53.5,-53,19])rotate([0,0,45])cube([6,6,34],true);
            translate([-53.5,53,19])rotate([0,0,45])cube([6,6,34],true);
            translate([53.5,-53,19])rotate([0,0,45])cube([6,6,34],true);
            translate([53.5,53,19])rotate([0,0,45])cube([6,6,34],true);
        }
        translate([-48.5,-48,0])rotate([0,0,0])cornercutout();
        translate([48.5,-48,0])rotate([0,0,90])cornercutout();
        translate([-48.5,48,0])rotate([0,0,-90])cornercutout();
        translate([48.5,48,0])rotate([0,0,180])cornercutout();
    }
}

module peg(){
    difference(){
        cylinder(h=18, d=6, $fn=200);
        translate([0,0,5])cylinder(h=23, d=3, $fn=200);
    }
}

module peg2(){
        cylinder(h=3, d=12, $fn=200);
}

module cornercutout(){
    difference(){
        translate([-6,-6,50.5])cube([12,12,98],true);
        difference(){
            cylinder(h=100, d=12, $fn=200);
            translate([0,0,3])cylinder(h=100, d=10, $fn=200);
        }
    }
}

module cornercutout2(){
    difference(){
        translate([-6,-6,50.5])cube([12,12,98],true);
        cylinder(h=100, d=12, $fn=200);
    }
}

module top(){
    translate([0,0,T]){
        difference(){
            union(){
                translate([0,0,37])cube([109,108,2],true);
                translate([0,0,30])cube([60,106-T2,12],true);
                translate([-54+T,6,27.25])cube([1+T2,34-T2,20],true);
                translate([-53+T,6,27.25])cube([1,40,20],true);

                translate([54-T,0,27.25])cube([1+T2,88-T2,20],true);
                translate([53-T,0,27.25])cube([1,94,20],true);
            }
            translate([-48.5,-48,0])rotate([0,0,0])cornercutout2();
            translate([48.5,-48,0])rotate([0,0,90])cornercutout2();
            translate([-48.5,48,0])rotate([0,0,-90])cornercutout2();
            translate([48.5,48,0])rotate([0,0,180])cornercutout2();

            translate([0,0,29])cube([62,104-T2,14],true);
            translate([-53+T,6,26])cube([1+T2,32-T2,20],true);
            translate([53-T,0,26])cube([1+T2,86-T2,20],true);

            translate([54-T,6,13])cube([10,36,20],true);
            
            difference(){
                union(){
                    translate([54-T,0,35])cube([10,80,2],true);
                    translate([54-T,0,31])cube([10,80,2],true);
                    translate([54-T,0,27])cube([10,80,2],true);

                    translate([51,0,35])cube([2,80,10],true);
                    translate([47,0,35])cube([2,80,10],true);
                    translate([43,0,35])cube([2,80,10],true);
                }
                translate([54-T,0,35])cube([30,10,30],true);
            }
            
            difference(){
                union(){
                    difference(){
                        translate([-20,6,27.25])cylinder(d=40, h=100, $fn=200);
                        translate([-20,6,27.25])cylinder(d=36, h=100, $fn=200);
                    }
                    
                    difference(){
                        translate([-20,6,27.25])cylinder(d=32, h=100, $fn=200);
                        translate([-20,6,27.25])cylinder(d=28, h=100, $fn=200);
                    }
                    
                    difference(){
                        translate([-20,6,27.25])cylinder(d=24, h=100, $fn=200);
                        translate([-20,6,27.25])cylinder(d=20, h=100, $fn=200);
                    }
                }
                translate([-20,6,27.25])cube([100,2,100], true);
            }
        }
    }
}

module powerButton(){
    union(){
        cylinder(d1=6,d2=0,h=3,$fn=20);
        cylinder(d=2,h=6,$fn=20);
    }
}





powerButton();
bottom();
top();
