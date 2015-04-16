(*
    This Mathematica file generates an image to
    illustrate covering maps.

    Usage:
    math -script covering.m
*)

start = 3; (* lowest z-coordinate of helix *)
height = 3; (* number of turns of helix - 1 *)
imageSize = 600;

(*angles determining subset to be lifted*)
startAngle = 1/4;
endAngle = 1/2;

covering = 
  Show[
   ParametricPlot3D[{Cos[2*Pi*t], Sin[2*Pi*t], 0}, {t, endAngle, startAngle + 1},
    PlotStyle -> {Thickness[0.005], Red}], 

   ParametricPlot3D[{Cos[2*Pi*t], Sin[2*Pi*t], 0}, {t, startAngle, endAngle},
    PlotStyle -> Thickness[0.01]], 

   ParametricPlot3D[{Cos[2*Pi*t], Sin[2*Pi*t], t + start}, {t, 0, startAngle},
    PlotStyle -> {Thickness[0.005], Red}], 

   ParametricPlot3D[
    Evaluate@
     Table[{Cos[2*Pi*t], Sin[2*Pi*t], t + n}, {n, start, start + height}], {t, endAngle, startAngle + 1}, 
    PlotStyle -> {{Thickness[0.005], Red}}], 

   ParametricPlot3D[
    Evaluate@
     Table[{Cos[2*Pi*t], Sin[2*Pi*t], t + n}, {n, start, start + height}], {t, startAngle, endAngle}, 
    PlotStyle -> Thickness[0.01]], 

   ParametricPlot3D[{Cos[2*Pi*t], Sin[2*Pi*t], t + start + height - 1}, {t, endAngle, 1}, 
    PlotStyle -> {Thickness[0.005], Red}], 

   Graphics3D[{Thick, Arrowheads[Large], 
     Arrow[{{0, 0, start - 0.5}, {0, 0, 1.3}}]}],
     
   PlotRange -> {{-1.1,1.1}, {-1.1, 1.1}, {0, start + height + 1}}, 
   ImageSize -> imageSize, Boxed -> False, Axes -> None
  ];

antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];
Export["covering.png", antialias[covering,4]]
