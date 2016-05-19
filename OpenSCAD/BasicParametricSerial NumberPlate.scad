  // Timothy Abraham 
  // May 18, 2016 
  // 
  // Generates a customizable serial number plague for mounting on aluminium extrusion 
  // 

SerialNumber = "SN: 007";  
ExtrusionSize = 20; // in mm
OverallLength = 80;
TextThickness = 2; // in mm
PlateThickness = 5; // in mm
TextScale = 10; // Arbitrary scale of text sizing

NozzleDiameter = .4; // in mm. Used to account for sizing differences of interior holes on most machines. Set to 0 to ignore.
MountingBoltThreadDiameter = 5; // in mm
MountingBoltHeadDiameter = 9.5; // in mm
CounterboreDepth = 2.75;

$fn = 100;

HoleSpacing = OverallLength-ExtrusionSize; // in mm
BaseHeight = ExtrusionSize;
MountingHoleRadius = (5 + NozzleDiameter)/2;

module Bolt() {
    union() {
        cylinder(h = PlateThickness, r = MountingHoleRadius, center = false);
        translate([0,0,PlateThickness-CounterboreDepth]) cylinder(h = CounterboreDepth, r = MountingBoltHeadDiameter/2, center = false);
    }
}

module Number(x,y) {
        translate([x,y,PlateThickness])
    linear_extrude(TextThickness)
            {
                
                text(text = SerialNumber,size = TextScale ,valign = "center",halign = "center");
            }
}

module Base() {
    EndCapRadius = BaseHeight / 2;
    difference() {
        union(){
            cylinder(h = PlateThickness, r = EndCapRadius, center = false);
            translate([0,-EndCapRadius,0]) cube([HoleSpacing,BaseHeight,PlateThickness]);
            translate([HoleSpacing,0,0]) cylinder(h = PlateThickness, r = EndCapRadius, center = false);
        }
    union(){
        Bolt();
        translate([HoleSpacing,0,0]) Bolt();
        }
    }
}
Number(HoleSpacing/2,0);
Base();
