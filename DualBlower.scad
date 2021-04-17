thickness=1.2;

arc1Diameter=40;
arc1Radius=arc1Diameter/2;
arc2Diameter=40;
arc2Radius=arc2Diameter/2;

blowerCutAngle=37.5;

holeWidth=14+1.6;
holeLength=19.6+1.2;

angle1=-45;
angle2=-30;

fanHolderHeight=4;
fanHolderThiskness=2;
fanHolderWidth=12;
fanHolderTotalLength=holeWidth+2*fanHolderThiskness;
fanHolderHoleRadius=2.6;

connectorLength=48;
connectorHeight=8;
connectorThickness=4;

connectorHoleAngle=22.5;
connectorholeWidth=20;

screwDistance=24;
screwM3Diameter=3+0.2;


module blower()
{
	difference()
	{
		intersection()
		{
			union()
			{
				rotate([-90,0,0])
				{
					linear_extrude(40)
					{
						translate([-arc1Radius-thickness,0])
						difference()
						{
							circle(d=arc1Diameter+2*thickness,$fn=64);
							circle(d=arc1Diameter,$fn=64);
						}
						
						translate([-arc2Radius+holeWidth,0])
						difference()
						{
							circle(d=arc2Diameter+2*thickness,$fn=64);
							circle(d=arc2Diameter,$fn=64);
						}
					}
				}

				rotate([angle1,0,0])
				translate([-50,-thickness,0])
				cube([80,thickness,40]);

				translate([-50,holeLength,0])
				rotate([angle2,0,0])
				cube([80,thickness,40]);
				
				translate([-thickness,-thickness,0])
				cube([holeWidth+2*thickness,thickness,thickness]);
			}
			
			translate([-arc2Radius+holeWidth,-thickness,0])
			rotate([-90,0,0])
			cylinder(d=arc2Diameter+2*thickness,h=40+thickness,$fn=64);
		}
		
		translate([-50,-1,0])
		rotate([-90,0,0])
		cube([100,100,100]);
		
		translate([-arc1Radius-thickness,-1,0])
		rotate([-90,0,0])
		cylinder(d=arc1Diameter,h=40+2,$fn=64);
		
		rotate([angle1,0,0])
		translate([-50,-thickness-40,-10])
		cube([80,40,40]);
		
		translate([-50,holeLength+thickness,0])
		rotate([angle2,0,0])
		cube([80,40,40]);
		
		translate([-30,0,15])
		rotate([0,blowerCutAngle,0])
		cube([20,40,40]);
	}
}

module blowerWithHolder()
{	
	union()
	{
		blower();
		
		difference()
		{
			translate([-fanHolderThiskness,-fanHolderWidth,-fanHolderHeight])
			union()
			{
				radius=fanHolderTotalLength/2-fanHolderHoleRadius-1;
				
				difference()
				{
					cube([fanHolderTotalLength,fanHolderWidth+holeLength+fanHolderThiskness,fanHolderHeight]);
					
					translate([-1,-1,-1])
					cube([radius+1,radius+1,fanHolderHeight+2]);
					
					translate([fanHolderTotalLength-radius,-1,-1])
					cube([radius+1,radius+1,fanHolderHeight+2]);
				}
				
				translate([radius,radius,0])
				cylinder(r=radius,h=fanHolderHeight,$fn=32);
				
				translate([fanHolderTotalLength-radius,radius,0])
				cylinder(r=radius,h=fanHolderHeight,$fn=32);
			}
			
			translate([0,0,-fanHolderHeight])
			cube([holeWidth,holeLength,fanHolderHeight]);
			
			translate([holeWidth/2,-fanHolderWidth-1,-fanHolderHeight])
			rotate([-90,0,0])
			cylinder(r=fanHolderHoleRadius,h=fanHolderWidth+holeLength+fanHolderThiskness+2,$fn=16);
		}
		
	}
}

module dualBlower()
{
	difference()
	{
		union()
		{
			mirror([1,0,0])
			blowerWithHolder();
			
			translate([connectorLength,0,0])
			blowerWithHolder();
			
			translate([0,-connectorThickness,-fanHolderHeight])
			union()
			{
				radius=connectorHeight-fanHolderHeight;
				
				difference()
				{
					cube([connectorLength,connectorThickness,connectorHeight]);
					
					translate([-1,-1,fanHolderHeight])
					cube([radius+1,connectorThickness+2,radius+1]);
					
					translate([connectorLength-radius,-1,fanHolderHeight])
					cube([radius+1,connectorThickness+2,radius+1]);
				}
				
				translate([radius,0,fanHolderHeight])
				rotate([-90,0,0])
				cylinder(r=radius,h=connectorThickness,$fn=32);
				
				translate([connectorLength-radius,0,fanHolderHeight])
				rotate([-90,0,0])
				cylinder(r=radius,h=connectorThickness,$fn=32);
			}
		}
		
		translate([connectorLength/2,-connectorThickness-1,-fanHolderHeight+connectorHeight/2])
		{
			translate([-screwDistance/2,0,0])
			rotate([-90,0,0])
			cylinder(d=screwM3Diameter,h=connectorThickness+2,$fn=16);
			
			translate([screwDistance/2,0,0])
			rotate([-90,0,0])
			cylinder(d=screwM3Diameter,h=connectorThickness+2,$fn=16);
		}
		
		translate([(connectorLength-connectorholeWidth)/2,0,connectorHeight-fanHolderHeight])
		rotate([-connectorHoleAngle,0,0])
		translate([0,0,-connectorHeight-10])
		cube([connectorholeWidth,connectorThickness+10,connectorHeight+10]);
	}
}

dualBlower();
