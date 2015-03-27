(*
	This Mathematica file generates three images to
	illustrate stereographic projection

	Usage:
	math -script stereographic.m
*)
colour[r_] := If[r == 1, Black, RGBColor[r, 0, 1 - r^2]]
contours = 40;
height[r_] := (2 r - 1)/(2 r^2 - 2 r + 1);
imagesize = 600;
ball = Show[
   Table[ContourPlot[x^2 + y^2 == r^2, {x, -2, 2}, {y, -2, 2}, 
     ContourStyle -> colour[r]], {r, 0, 1, 1/contours}], 
   ImageSize -> imagesize];
plane = Show[
   Table[ContourPlot[x^2 + y^2 == 1/(1 - r^2), {x, -2, 2}, {y, -2, 2},
      ContourStyle -> colour[r]], {r, 0, 1 - 1/contours, 1/contours}],
    ImageSize -> imagesize];
sphere = Show[
   ContourPlot3D[
    x^2 + y^2 + z^2 == 1, {x, -1.1, 1.1}, {y, -1.1, 1.1}, {z, -1.1, 
     1.1}, ContourStyle -> {Opacity[0.5], 
      Directive[RGBColor[0.98, 0.22, 0.11]], Specularity[White, 40]}, 
    Mesh -> None, PlotPoints -> 40], 
   Table[ParametricPlot3D[{Sqrt[1 - height[r]^2]*Cos[t], 
      Sqrt[1 - height[r]^2]*Sin[t], height[r]}, {t, 0, 2*Pi}, 
     PlotStyle -> {Thick, colour[r]}], {r, 0, 1, 1/contours}], 
   ImageSize -> imagesize];

antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];
Export["ball.png", antialias[ball]];
Export["plane.png", antialias[plane]];
Export["sphere.png", antialias[sphere]];
