(*
        This Mathematica file generates the graph of the
	topologist's sine curve.

        Usage:
        math -script sinecurve.m
*)
imagesize = 600;
antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];

graph = Show[
  Plot[Sin[1/x], {x, 0, 2}, PlotPoints -> 10000, 
   PlotRange -> {{0, 1.5}, {-1, 1}}], ImageSize -> imagesize]
Export["sinecurve.png", antialias[graph]];
