(*
	This Mathematica file generates the front page
	illustration, also used to illustrate stereographic
	projection.

	Usage:
	math -script stereo-frontpage.m
*)
colour[r_] := If[r == 1, Black, RGBColor[r, 0, 1 - r]]
colour2[r_] := If[r == 1, Black, RGBColor[0.2, 1 - r, r]]
contours = 15;
height[r_] := (2 r - 1)/(2 r^2 - 2 r + 1);
imagesize = 2000;

plane = Show[
   Table[ParametricPlot3D[{r^2/(1 - r^2)*Cos[2*Pi*t], 
      r^2/(1 - r^2)*Sin[2*Pi*t], 0}, {t, 0, 1}
     , PlotStyle -> {{Thick, colour2[r]}}, PlotPoints -> 200], {r, 0, 
     1 - 1/contours, 1/contours}]];

sphere = Show[
   ContourPlot3D[
    z == 0, {x, -3.2, 3.2}, {y, -3.2, 3.2}, {z, -1.1, 1.1}, 
    ContourStyle -> {Opacity[0.7], 
      Directive[RGBColor[0.88, 0.22, 0.11]], 
      Specularity[RGBColor[0.88, 0.72, 0.11], 0]}, Mesh -> None],
   ContourPlot3D[
    x^2 + y^2 + z^2 == 1, {x, -1.1, 1.1}, {y, -1.1, 1.1}, {z, -1.1, 
     1.1}, ContourStyle -> {Opacity[0.18], 
      Directive[RGBColor[0.38, 0.22, 0.11]], Specularity[White, 1]}, 
    Mesh -> None, PlotPoints -> 40], 
   Table[ParametricPlot3D[{Sqrt[1 - height[r]^2]*Cos[t], 
      Sqrt[1 - height[r]^2]*Sin[t], height[r]}, {t, 0, 2*Pi}, 
     PlotStyle -> {Thick, colour2[r]}, PlotPoints -> 100], {r, 0, 1, 
     1/contours}], ImageSize -> imagesize];

line[{x1_, x2_, x3_}, {y1_, y2_, y3_}, t_] := (1 - t)*{x1, x2, x3} + 
   t*{y1, y2, y3};
lines = Show[Table[ParametricPlot3D[
     line[{0, 0, 1},
      If[r^2/(1 - r^2) > 1,
       {r^2/(1 - r^2)*Cos[2*Pi*theta], r^2/(1 - r^2)*Sin[2*Pi*theta], 
        0},
       {Sqrt[1 - height[r]^2]*Cos[2*Pi*theta], 
        Sqrt[1 - height[r]^2]*Sin[2*Pi*theta], height[r]}
       ]
      , t],
     {t, 0, 1}, PlotStyle -> {colour2[r], Opacity[0.65]}],
    {theta, 0, 1, 0.1}, {r, 0, Min[1 - 1/contours, Sqrt[2/3] + 0.1], 
     1/contours}]];

collected = 
  Show[plane, lines, sphere, 
   PlotRange -> {{-3.1, 3.1}, {-3.1, 3.1}, {-1.1, 1.1}}, Axes -> None,
    Boxed -> False, ViewVector -> {{5, 5, 1.4}, {0, 0, 0}}, 
   ImageSize -> imagesize];

antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];

Export["stereo-frontpage.png", antialias[collected, 5]];
