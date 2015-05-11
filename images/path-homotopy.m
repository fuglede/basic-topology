(*
	This Mathematica file generates three images to
	illustrate a homotopy between two paths.

	Usage:
	math -script path-homotopy.m
*)

imagesize = 600;

(* Two curves; no particular reason for choosing the concrete expressions. *)
gamma1[t_] := {2*Tan[t - 1], Cos[3*Sin[t]]};
gamma2[t_] := {2*Tan[Sin[Pi*t/2] - 1] - Tan[Sin[Pi*0] - 1] + Tan[0 - 1], 
               Cos[3*Sin[t] + 2*Pi*t] - Cos[6*Pi*Sin[0]] + Cos[3*Sin[0]]};

(* The straight-line homotopy *)
F[s_, t_] := (1 - t)*gamma1[s] + t*gamma2[s];

homotopy = Show[
	ParametricPlot[Table[F[s, t], {t, 0.1, 0.9, 0.1}], {s, 0, 1}, 
		PlotStyle -> {{Red, Opacity[0.5]}}],
	ParametricPlot[Table[F[s, t], {s, 0.1, 0.9, 0.1}], {t, 0, 1}, 
		PlotStyle -> {{Blue, Opacity[0.5]}}],
	ParametricPlot[{gamma1[s], gamma2[s]}, {s, 0, 1}, 
		PlotStyle -> {{Red, Thickness[0.004], CapForm["Round"]}}],
	Axes -> None, PlotRange -> {{-3.1, 0.1}, {-1.1, 1.1}}, ImageSize -> imagesize
];

antialias[g_, n_: 3] := 
  ImageResize[Rasterize[g, "Image", ImageResolution -> n 72], 
   Scaled[1/n]];

Export["path-homotopy.png", antialias[homotopy]];
