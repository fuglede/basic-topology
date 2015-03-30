(*
        This Mathematica file generates the graph of the
	function x \mapsto x/(1-|x|), x in (-1,1).

        Usage:
        math -script homeointerval.m
*)
imagesize = 600;
antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];

graph = Show[Plot[x/(1 - Abs[x]), {x, -1, 1}], 
  ImageSize -> imagesize];
Export["homeointerval.png", antialias[graph]];
