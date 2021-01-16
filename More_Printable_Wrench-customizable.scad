// Fully assembled more printable wrench with customizable text
// By DrLex, original by barspin a.k.a. Daniel Noree (Thing:139268)
// Licence: Creative Commons - Attribution (https://creativecommons.org/licenses/by/4.0/)
// Version history:
// 20210116: Further split up the model such that it can also be generated without supports, or with larger gaps. Now directly importing STLs since I don't care about Thingiverse compatibility anymore.
// 20170624: I have finally managed to clean up the models such that OpenSCAD no longer flips out when trying to merge the two separate polyhedra (see https://github.com/openscad/openscad/issues/802)

Text = "3D Printed";
FontSize = 6.5; //[3:0.1:8]
BoldFont = "no"; //[yes, no]
NarrowFont = "no"; //[yes, no]
// Similar to the bigger gap version of barspin's original, may help when you can't get the parts in the regular model to move.
LargerGaps="no"; //[yes, no]
// You can disable supports if you want to attempt to print without supports, or try your slicer's auto-generated supports.
Supports="yes"; //[yes, no]
// If you want to print this in two colours on a multi-material printer, first generate a 'body' model for the first colour and then 'inserts' for the other.
MultiMaterial="no"; //[no, body, inserts]
// When doing a multi-material print, set this to 'yes' if you want the text to be in the second colour as well.
MultiMatText="no"; //[yes, no]

// preview[view:south east, tilt:top diagonal]

/* [Hidden] */
Font = NarrowFont == "no" ? "Roboto" : "Roboto Condensed";
TextFont = BoldFont == "no" ? Font : str(Font, ":style=Bold");


union() {
    if(MultiMaterial == "no" || MultiMaterial == "inserts") {
        import("raw_parts/inserts.stl", convexity=6);
        if(MultiMaterial == "inserts" && MultiMatText == "yes") {
            wrenchText();
        }
    }

    if(MultiMaterial == "no" || MultiMaterial == "body") {
        difference() {
            import("raw_parts/body_only.stl", convexity=6);
            if(LargerGaps == "yes") {
                difference() {
                    translate([-50.75, 9.5, 5.7]) rotate([90, 0, 0]) cylinder(center=true, r=4.05, h=54, $fn=80);
                    translate([-56.75, -12, 5.7]) cube(5.65, center=true);
                }
                translate([-56.75, 12, 5.7]) cube([8.7, 44.82, 5.6], center=true);
                translate([-56.75, 10, 5.7]) cube([10.6, 18.906, 5.6], center=true);
            }
            if(MultiMaterial == "body" && MultiMatText == "yes") {
                wrenchText();
            }
        }

        if(Supports == "yes") {
            import("raw_parts/supports.stl", convexity=6);
        }

        if(MultiMaterial == "no" || MultiMatText == "no") {
            wrenchText();
        }
    }
}


module wrenchText()
{
    translate([18, -10.2-FontSize/2, 3.6]) rotate([0, 0, -15.11]) linear_extrude(0.9, convexity=6) text(Text, FontSize, font=TextFont, halign="center", valign="baseline", $fn=24);

}