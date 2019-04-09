(* ::Package:: *)

(* ::Subsection::Closed:: *)
(*About*)


(*
Package file CollierLink.m
Copyright (C) 2017 by Hiren H. Patel

This file is part of CollierLink v1.0, by Hiren H. Patel and is the main program that provides
the Mathematica interface to the COLLIER library by A. Denner, S. Dittmaier, L. Hofer.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see <http://www.gnu.org/licenses/>.
*)


(* ::Subsection::Closed:: *)
(*Usages and SyntaxInformation*)


If[Not[$VersionNumber==9.0] && $Notebooks,
  CollierLinkOptions::usage = "\!\(CollierLinkOptions[\*StyleBox[\"name\", \"TI\"]]\) gives the current setting for the global CollierLink option with specified name.
\!\(CollierLinkOptions[]\) gives the current settings for all settable global CollierLink options.";
  SetCollierLinkOptions::usage = "\!\(SetCollierLinkOptions[\*StyleBox[\"name\", \"TI\"]\[Rule]\*StyleBox[\"value\", \"TI\"]]\) resets the value for the global CollierLink option with the specified name.";
  SeparateUV::usage = "\!\(SeparateUV[\*StyleBox[\"expr\", \"TI\"]]\) gives the limiting behavior of \!\(\*StyleBox[\"expr\", \"TI\"]\) as \!\(\[ScriptD]\[Rule]4\) and separates the UV divergent parts of Passarino\[Hyphen]Veltman functions wrapping them with UVDiv for numerical evaluation.";
  UVDiv::usage = "\!\(UVDiv[\*StyleBox[\"f\", \"TI\"]]\) is the UV divergent polynomial of the Passarino\[Hyphen]Veltman function \!\(\*StyleBox[\"f\", \"TI\"]\).";
  COLLIER::usage = "COLLIER is a symbol to which Collier evaluation error messages are attached.  Off[\"COLLIER\"] switches off all COLLIER evaluation error messages.";
  CollierCompile::usage = "\!\(CollierCompile[{\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),2], \[Ellipsis]},\*StyleBox[\"expr\",\"TI\"]]\) creates a compiled function that evaluates \!\(\*StyleBox[\"expr\",\"TI\"]\) using the COLLIER library assuming numerical values of the \!\(\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),\(\*StyleBox[\"i\",\"TI\"]\)]\).
\!\(CollierCompile[{\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),2], \[Ellipsis]},Module[{\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),2], \[Ellipsis]},\*StyleBox[\"expr\",\"TI\"]]]\) creates a compiled function with local variables \!\(\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),\(\*StyleBox[\"i\",\"TI\"]\)]\).";
  CollierCompiledFunction::usage = "\!\(CollierCompiledFunction[\*StyleBox[\"args\",\"TI\"],\[Ellipsis]]\) represents compiled code for evaluating a compiled function using the COLLIER library.";
  CollierCodeGenerate::usage = "\!\(CollierCodeGenerate[{\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),2], \[Ellipsis]},\*StyleBox[\"expr\",\"TI\"]]\) generates source code that defines a function with arguments \!\(\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),\(\*StyleBox[\"i\",\"TI\"]\)]\) to evaluate \!\(\*StyleBox[\"expr\",\"TI\"]\) using the COLLIER library.
\!\(CollierCodeGenerate[{\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"x\",\"TI\"]\),2], \[Ellipsis]},Module[{\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),1],\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),2], \[Ellipsis]},\*StyleBox[\"expr\",\"TI\"]]]\) generates source code with local variables \!\(\*SubscriptBox[\(\*StyleBox[\"y\",\"TI\"]\),\(\*StyleBox[\"i\",\"TI\"]\)]\).";
	,

(*For version 9, or without Front End*)
  CollierLinkOptions::usage="CollierLinkOptions[name] gives the current setting for the global CollierLink option with specified name.\nCollierLinkOptions[] gives the current settings for all settable global CollierLink options.";
  SetCollierLinkOptions::usage="SetCollierLinkOptions[name->value] resets the value for the global CollierLink option with the specified name.";
  SeparateUV::usage="SeparateUV[expr] gives the limiting behavior of expr as d->4 and separates the UV divergent parts of Passarino\[Hyphen]Veltman functions wrapping them with UVDiv for numerical evaluation.";
  UVDiv::usage="UVDiv[f] is the UV divergent part of the Passarino\[Hyphen]Veltman function f.";
  COLLIER::usage = "COLLIER is a symbol to which Collier evaluation error messages are attached.  Off[\"COLLIER\"] switches off all COLLIER evaluation error messages.";
  CollierCompile::usage="CollierCompile[{x1,x2, \[Ellipsis]},expr] creates a compiled function that evaluates expr using the COLLIER library assuming numerical values of the xi.\nCollierCompile[{x1,x2, \[Ellipsis]},Module[{y1,y2, \[Ellipsis]},expr]] creates a compiled function with local variables yi.";
  CollierCompiledFunction::usage="CollierCompiledFunction[args,\[Ellipsis]] represents compiled code for evaluating a compiled function using the COLLIER library.";
  CollierCodeGenerate::usage="CollierCodeGenerate[{x1,x2, \[Ellipsis]},expr] generates source code that defines a function with arguments xi to evaluate expr using the COLLIER library.\nCollierCodeGenerate[{x1,x2, \[Ellipsis]},Module[{y1,y2, \[Ellipsis]},expr]] generates source code with local variables yi.";
];

(*Mode::usage = If[ValueQ[Mode::usage], Mode::usage <> "\n" <> #, #] &@ "Mode is a global CollierLink option that specifies the branch of COLLIER used to numerically evaluate Passarino-Veltman functions.  Possible settings are '1' (for COLI-implementation), '2' (for DD-implementation), or '3' (for check COLI- against DD-implementation).";*)
Constants::usage = If[ValueQ[Constants::usage], Constants::usage <> "\n" <> #, #] &@ "Constants is an option to CollierCompile that specifies variables to be declared constants.";


SyntaxInformation[CollierLinkOptions]={"ArgumentsPattern"->{_.}};
SyntaxInformation[SetCollierLinkOptions]={"ArgumentsPattern"->{_}};
(*SyntaxInformation[SetCollierLinkOptions]={"ColorEqualSigns"->{1,1}};*)
(*,"ArgumentsPattern"->{OptionsPattern[]},"OptionNames" -> {"\"MaxDenominators\"","\"MaxRank\"","\"Mode\"","\"InvEpsUV\"","\"MuUV\"","\"InvEpsIR\"","\"MuIR\"","\"SmallMasses\"","\"ReqAcc\"","\"Ritmax\""}*)

SyntaxInformation[SeparateUV]={"ArgumentsPattern"->{_}};
SyntaxInformation[UVDiv]={"ArgumentsPattern"->{_}};

Options[CollierCompile]={Constants->{}, "UseCacheSystem"->True, "ExpressionOptimization"->Automatic, "InlineExternalDefinitions"->False, "PrimeCacheSystem"->True};
SyntaxInformation[CollierCompile]={"ArgumentsPattern"->{_,_,OptionsPattern[]},"LocalVariables"->{"Solve",{1}},
  "OptionNames" ->{"Constants","\"UseCacheSystem\"","\"ExpressionOptimization\"","\"InlineExternalDefinitions\""}};

Options[CollierCodeGenerate]=
  {Constants->{}, "ExpressionOptimization"->Automatic, "InlineExternalDefinitions"->False, 
	"Language"->"Fortran", "MaxCharactersPerLine"->Automatic, "FunctionName"->"generatedFunction", "VariableNames"->Automatic,
	"Externals"->{},"PreambleLines"->{},"PostambleLines"->{}};

SyntaxInformation[CollierCodeGenerate]={"ArgumentsPattern"->{_,_,OptionsPattern[]},"LocalVariables"->{"Solve",{1}},
  "OptionNames" ->{"Constants","\"ExpressionOptimization\"","\"MaxCharactersPerLine\"",
				  "\"Language\"","\"Externals\"","\"FunctionName\"","\"VariableNames\"","\"PreambleLines\"",
				  "\"PostambleLines\"","\"TranslationRules\""}};


(*Accuracy messages*)
COLLIER::reqacc="Accuracy flag -1: Numerical evaluation of `1` failed to reach prescribed accuracy within `2` iterations using all known methods.";
COLLIER::critacc="Accuracy flag -2: Numerical evaluation of `1` failed to reach critical accuracy within `2` iterations using all known methods.";
(*Error messages*)
COLLIER::intcheck="Error flag -1: Internal check failed while evaluating `1`.";
COLLIER::argcut="Error flag -4: Attempted to evaluate log or dilog on cut while evaluating `1`.";
COLLIER::critevent="Error flag -5: Error greater than critical error, or wrong exit of rloop.";
COLLIER::nored="Error flag -6: No reduction method works to evaluate `1`, or input momenta are inconsistent.";
COLLIER::specnum="Error flag -7: Numerical problem encountered while trying to evaluate `1`.";
COLLIER::intcons="Error flag -9: Internal inconsistency encountered while trying to evaluate `1`.";
COLLIER::nocase="Error flag -10: Unable to evaluate `1`; case is not supported or implemented.";

(*Accuracy messages*)
CollierCompiledFunction::reqacc="Accuracy flag -1: Numerical evaluation at `1` failed to reach prescribed accuracy within `2` iterations using all known methods.";
CollierCompiledFunction::critacc="Accuracy flag -2: Numerical evaluation at `1` failed to reach critical accuracy within `2` iterations using all known methods.";
(*Error messages*)
CollierCompiledFunction::intcheck="Error flag -1: Internal check failed while evaluating at `1`.";
CollierCompiledFunction::argcut="Error flag -4: Attempted to evaluate log or dilog on cut while evaluating at `1`.";
CollierCompiledFunction::critevent="Error flag -5: Error greater than critical error, or wrong exit of rloop.";
CollierCompiledFunction::nored="Error flag -6: No reduction method works to evaluate at `1`, or input momenta are inconsistent.";
CollierCompiledFunction::specnum="Error flag -7: Numerical problem encountered while trying to evaluate at `1`.";
CollierCompiledFunction::intcons="Error flag -9: Internal inconsistency encountered while trying to evaluate at `1`.";
CollierCompiledFunction::nocase="Error flag -10: Unable to evaluate at `1`; case is not supported or implemented.";

PrependTo[$MessageGroups,"COLLIER":>
	{COLLIER::reqacc,COLLIER::critacc,COLLIER::intcheck,COLLIER::argcut,COLLIER::critevent,COLLIER::nored,COLLIER::specnum,COLLIER::intcons,COLLIER::nocase,
	 CollierCompiledFunction::reqacc,CollierCompiledFunction::critacc,CollierCompiledFunction::intcheck,CollierCompiledFunction::argcut,CollierCompiledFunction::critevent,CollierCompiledFunction::nored,CollierCompiledFunction::specnum,CollierCompiledFunction::intcons,CollierCompiledFunction::nocase}];
Off[COLLIER::reqacc,CollierCompiledFunction::reqacc];


Begin["`Private`"];


(* ::Subsection:: *)
(*UVDiv code injection into LoopRefine [Patching OneLoop.m]*)


(* ::Subsubsection::Closed:: *)
(*StandardForm formatting of Derivative[0,0,1,0,0][UVDiv[PVB]]*)


MakeExpression[RowBox[{
  RowBox[{"UVDiv","[","PVB","]"}],"'"}]|SuperscriptBox[RowBox[{"UVDiv","[","PVB","]"}],"\[Prime]"],StandardForm]:=
 MakeExpression[RowBox[{RowBox[{RowBox[{"Derivative", "[", RowBox[{"0",",","0",",","1",",","0",",","0"}], "]"}], "[", RowBox[{"UVDiv","[","PVB","]"}],"]"}]}],StandardForm];

(*Need to HoldPattern for version 9.0 *)
HoldPattern[MakeBoxes[Derivative[0,0,1,0,0][UVDiv[PVB]],StandardForm]]:=RowBox[{InterpretationBox[SuperscriptBox[RowBox[{"UVDiv","[","PVB","]"}],"\[Prime]",MultilineFunction->None],Derivative[0,0,1,0,0][UVDiv[PVB]]]}];


(* ::Subsubsection::Closed:: *)
(*TraditionalForm of formatting UVDiv[PVA], UVDiv[PVB], ...*)


MakeBoxes[UVDiv[PVA][r_Integer, m0_, opts:OptionsPattern[PVA]], TraditionalForm] ^:=
With[{tensorIndices=RowBox[Riffle[If[NonNegative[r],Table["0", {Max[2*r, 1]}], {"(",r,")"}],"\[InvisibleComma]"]],
	  kinematicArguments=Sequence["(",X`Internal`ToRowBox[{m0},TraditionalForm],")"]}, 
  TooltipBox[
    If[(*Normal PVA*)OptionValue[PVA,opts,Weights]==={1},
	  RowBox[{SubsuperscriptBox[StyleBox["A",FontSlant->Plain,FontWeight->Bold], tensorIndices, StyleBox["(UV)",FontSlant->Plain]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}],
	   (*Weighted PVA*)
	  RowBox[{SubsuperscriptBox[StyleBox["A",FontSlant->Plain,FontWeight->Bold], tensorIndices, RowBox[{ToBoxes[OptionValue[PVA,opts,Weights]],StyleBox[", (UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
    ],If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVA]",kinematicArguments}],"UVDiv[PVA]"]]
];


MakeBoxes[UVDiv[PVB][r_Integer, n_Integer?NonNegative, s_, m0_, m1_, opts:OptionsPattern[PVB]], TraditionalForm] ^:=
With[{tensorIndices=RowBox[Riffle[Which[
		r===n===0,      {"0"},
		NonNegative[r], Table["0", {2*r}],
		Negative[r],    {"(",r,")"}]~Join~Table["1", {n}],"\[InvisibleComma]"]],
	  kinematicArguments=Sequence["(",X`Internal`ToRowBox[{s},TraditionalForm],";",X`Internal`ToRowBox[{m0,m1},TraditionalForm],")"]},
  TooltipBox[
	If[(*Normal PVB*)OptionValue[PVB,opts,Weights]==={1,1},
	  RowBox[{SubsuperscriptBox[StyleBox["B",FontSlant->Plain,FontWeight->Bold], tensorIndices, StyleBox["(UV)",FontSlant->Plain]],If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}],
	   (*Weighted PVB*)
	  RowBox[{SubsuperscriptBox[StyleBox["B",FontSlant->Plain,FontWeight->Bold], tensorIndices, RowBox[{ToBoxes[OptionValue[PVB,opts,Weights]],StyleBox[", (UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
    ],If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVB]",kinematicArguments}],"UVDiv[PVB]"]]
];


MakeBoxes[Derivative[0,0,1,0,0][UVDiv[PVB]][r_Integer, n_Integer?NonNegative, s_, m0_, m1_, opts:OptionsPattern[PVB]], TraditionalForm] ^:=
With[{tensorIndices=RowBox[Riffle[Which[
		r===n===0,      {"0"},
		NonNegative[r], Table["0", {2*r}],
		Negative[r],    {"(",r,")"}]~Join~Table["1", {n}],"\[InvisibleComma]"]],
	  kinematicArguments=Sequence["(",X`Internal`ToRowBox[{s},TraditionalForm],";",X`Internal`ToRowBox[{m0,m1},TraditionalForm],")"]},
  TooltipBox[
	If[(*Normal PVB*)OptionValue[PVB,opts,Weights]==={1,1},
	  RowBox[{SubsuperscriptBox[StyleBox["B",FontSlant->Plain,FontWeight->Bold], tensorIndices, RowBox[{"\[Prime]",StyleBox["(UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}],
	   (*Weighted PVB*)
	  RowBox[{SubsuperscriptBox[StyleBox["B",FontSlant->Plain,FontWeight->Bold], tensorIndices, RowBox[{"\[Prime]",ToBoxes[OptionValue[PVB,opts,Weights]],StyleBox[", (UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
    ],If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVB]",kinematicArguments}],"UVDiv[PVB]"]]
];


MakeBoxes[UVDiv[PVC][r_Integer, n1_Integer?NonNegative, n2_Integer?NonNegative, p1_, q_, p2_, m0_, m1_, m2_, opts: OptionsPattern[PVC]], TraditionalForm] ^:= 
With[{tensorIndices=RowBox[Riffle[Which[
		r===n1===n2===0, {"0"},
		NonNegative[r],  Table["0", {2*r}],
		Negative[r],     {"(",r,")"}]~Join~Join[Table["1", {n1}],Table["2", {n2}]],"\[InvisibleComma]"]],
	  kinematicArguments=Sequence["(",X`Internal`ToRowBox[{p1,q,p2},TraditionalForm],";",X`Internal`ToRowBox[{m0,m1,m2},TraditionalForm],")"]},
  TooltipBox[
	If[(*Normal PVC*)OptionValue[PVC,opts,Weights]==={1,1,1},  
	  RowBox[{SubsuperscriptBox[StyleBox["C",FontSlant->Plain,FontWeight->Bold], tensorIndices, StyleBox["(UV)",FontSlant->Plain]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}],
	   (*Weighted PVC*)
	  RowBox[{SubsuperscriptBox[StyleBox["C",FontSlant->Plain,FontWeight->Bold], tensorIndices, RowBox[{ToBoxes[OptionValue[PVC,opts,Weights]],StyleBox[", (UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
  ],If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVC]",kinematicArguments}],"UVDiv[PVC]"]]
];


MakeBoxes[UVDiv[PVD][r_Integer, n1_Integer?NonNegative, n2_Integer?NonNegative, n3_Integer?NonNegative, s1_, s2_, s3_, s4_, s12_, s23_, m0_, m1_, m2_, m3_, opts:OptionsPattern[PVD]], TraditionalForm] ^:= 
With[{tensorIndices=RowBox[Riffle[Which[
		r===n1===n2===n3===0, {"0"},
		NonNegative[r],       Table["0", {2*r}],
		Negative[r],          {"(",r,")"}]~Join~Join[Table["1", {n1}],Table["2", {n2}],Table["3", {n3}]],"\[InvisibleComma]"]],
	  kinematicArguments=Sequence["(",X`Internal`ToRowBox[{s1,s2,s3,s4},TraditionalForm],";",X`Internal`ToRowBox[{s12,s23},TraditionalForm],";",X`Internal`ToRowBox[{m0,m1,m2,m3},TraditionalForm],")"]},
  TooltipBox[
	If[(*Normal PVD*)OptionValue[PVD,opts,Weights]==={1,1,1,1},
	  RowBox[{SubsuperscriptBox[StyleBox["D",FontSlant->Plain,FontWeight->Bold], tensorIndices, StyleBox["(UV)",FontSlant->Plain]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}],
	   (*Weighted PVD*)
	  RowBox[{SubsuperscriptBox[StyleBox["D",FontSlant->Plain,FontWeight->Bold], tensorIndices,RowBox[{ToBoxes[OptionValue[PVD,opts,Weights]],StyleBox[", (UV)",FontSlant->Plain]}]], If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
  ],If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVD]",kinematicArguments}],"UVDiv[PVD]"]]
];


(*General Passarino-Veltman function*)
MakeBoxes[HoldPattern[UVDiv[PVX][args__]], TraditionalForm] ^:=
  With[{noDenom=(-3+Sqrt[9+8*Length[Unevaluated[{args}]]])/2}, 
	With[
	  {indices=Hold[args][[1;;noDenom]],
	   extInv=Hold[args][[1+noDenom;;(-1+noDenom)noDenom/2+noDenom]],
	   intMasses=Hold[args][[-noDenom;;]],
	   pvID=FromCharacterCode[64+noDenom]},
	  With[{tensorIndices=RowBox[Riffle[Which[
			  MatchQ[indices,Hold[(0)..]],  {"0"},
			  NonNegative[indices[[1]]], Table["0", {2*indices[[1]]}],
			  Negative[indices[[1]]],   {"(",indices[[1]],")"} ] ~Join~ (Join@@MapIndexed[ConstantArray[ToString[#2[[1]]],#1]&,List@@Rest[indices]]),"\[InvisibleComma]"]],
			kinematicArguments=Sequence["(",X`Internal`ToRowBox[extInv,TraditionalForm],";",X`Internal`ToRowBox[intMasses,TraditionalForm],")"]},

		TooltipBox[RowBox[{SubsuperscriptBox[StyleBox[pvID,FontSlant->Plain,FontWeight->Bold], tensorIndices, StyleBox["(UV)",FontSlant->Plain]],If[X`Utilities`$PVShortForm,Unevaluated@Sequence[],Unevaluated@kinematicArguments]}]
		,If[X`Utilities`$PVShortForm,RowBox[{"UVDiv[PVX]",kinematicArguments}],"UVDiv[PVX]"]]		
	  ]/;MatchQ[indices,Hold[__Integer?NonNegative]]
	]/;X`Private`argsCheckPVX[Length[Unevaluated[{args}]]]
  ];


(* ::Subsubsection::Closed:: *)
(*Injection into LoopRefine*)


Clear[X`Private`pvWeightReduce];

X`Private`pvWeightReduce = {
  HoldPattern[UVDiv[PVA][r_Integer,m0_]] :> X`Private`pvADivUV[r, m0],
  HoldPattern[UVDiv[PVB][r_Integer,n1_Integer?NonNegative,s_,m0_,m1_]] :> X`Private`pvBDivUV[r,n1,s,m0,m1],
  HoldPattern[UVDiv[PVC][r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,p1_,q_,p2_,m0_,m1_,m2_]] :> X`Private`pvCDivUV[r,n1,n2,p1,q,p2,m0,m1,m2],
  HoldPattern[UVDiv[PVD][r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,n3_Integer?NonNegative,s1_,s2_,s3_,s4_,s12_,s23_,m0_,m1_,m2_,m3_]] :> X`Private`pvDDivUV[r,n1,n2,n3,s1,s2,s3,s4,s12,s23,m0,m1,m2,m3],

  HoldPattern[UVDiv[PVA][r_Integer,m0_, opts__Rule]] /; Quiet@Check[X`Private`validPVmodifiers[PVA,opts], False]:> 
	With[{w0=OptionValue[PVA,{opts},Weights][[1]], delDimhalf=2-OptionValue[PVA,{opts},Dimensions]/2}, 
	  ((-1)^(w0-1) (-2)^(1-w0-delDimhalf))/Gamma[w0] X`Private`pvADivUV[r, m0]],
  HoldPattern[UVDiv[PVB][r_Integer,n1_Integer?NonNegative,s_,m0_,m1_,opts__Rule]] /; Quiet@Check[X`Private`validPVmodifiers[PVB,opts], False]:> 
	With[{w0=OptionValue[PVB,{opts},Weights][[1]], w1=OptionValue[PVB,{opts},Weights][[2]], delDimhalf=2-OptionValue[PVB,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(2-w0-w1-delDimhalf))/(Gamma[w0] Gamma[w1]) Sum[Binomial[w0-1,j1]*X`Private`pvBDivUV[r,n1,s,m0,m1],{j1,0,w0-1}]],
  HoldPattern[UVDiv[PVC][r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,p1_,q_,p2_,m0_,m1_,m2_,opts__Rule]] /; Quiet@Check[X`Private`validPVmodifiers[PVC,opts], False]:> 
	With[{w0=OptionValue[PVC,{opts},Weights][[1]], w1=OptionValue[PVC,{opts},Weights][[2]], w2=OptionValue[PVC,{opts},Weights][[3]], delDimhalf=2-OptionValue[PVC,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(3-w0-w1-w2-delDimhalf))/(Gamma[w0]Gamma[w1]Gamma[w2]) Sum[Multinomial[j1,j2,w0-1-j1-j2]*X`Private`pvCDivUV[r,n1,n2,p1,q,p2,m0,m1,m2],{j1,0,w0-1},{j2,0,w0-1-j1}]],
  HoldPattern[UVDiv[PVD][r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,n3_Integer?NonNegative,s1_,s2_,s3_,s4_,s12_,s23_,m0_,m1_,m2_,m3_,opts__Rule]] /; Quiet@Check[X`Private`validPVmodifiers[PVD,opts], False]:> 
	With[{w0=OptionValue[PVD,{opts},Weights][[1]], w1=OptionValue[PVD,{opts},Weights][[2]], w2=OptionValue[PVD,{opts},Weights][[3]], w3=OptionValue[PVD,{opts},Weights][[4]], delDimhalf=2-OptionValue[PVD,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(4-w0-w1-w2-w3-delDimhalf))/(Gamma[w0]Gamma[w1]Gamma[w2]Gamma[w3]) Sum[Multinomial[j1,j2,j3,w0-1-j1-j2-j3]*X`Private`pvDDivUV[r,n1,n2,n3,s1,s2,s3,s4,s12,s23,m0,m1,m2,m3],{j1,0,w0-1},{j2,0,w0-1-j1},{j3,0,w0-1-j1-j2}]],

  PVA[r_Integer,m0_, opts__Rule] /; Quiet@Check[X`Private`validPVmodifiers[PVA,opts], False]:> 
	With[{w0=OptionValue[PVA,{opts},Weights][[1]], delDimhalf=2-OptionValue[PVA,{opts},Dimensions]/2}, 
	  ((-1)^(w0-1) (-2)^(1-w0-delDimhalf))/Gamma[w0] PVA[r+1-w0-delDimhalf,m0]],
  PVB[r_Integer,n1_Integer?NonNegative,s_,m0_,m1_,opts__Rule] /; Quiet@Check[X`Private`validPVmodifiers[PVB,opts], False]:> 
	With[{w0=OptionValue[PVB,{opts},Weights][[1]], w1=OptionValue[PVB,{opts},Weights][[2]], delDimhalf=2-OptionValue[PVB,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(2-w0-w1-delDimhalf))/(Gamma[w0] Gamma[w1]) Sum[Binomial[w0-1,j1]*PVB[r+2-w0-w1-delDimhalf,n1+w1-1+j1,s,m0,m1],{j1,0,w0-1}]],
  PVC[r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,p1_,q_,p2_,m0_,m1_,m2_,opts__Rule] /; Quiet@Check[X`Private`validPVmodifiers[PVC,opts], False]:> 
	With[{w0=OptionValue[PVC,{opts},Weights][[1]], w1=OptionValue[PVC,{opts},Weights][[2]], w2=OptionValue[PVC,{opts},Weights][[3]], delDimhalf=2-OptionValue[PVC,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(3-w0-w1-w2-delDimhalf))/(Gamma[w0]Gamma[w1]Gamma[w2]) Sum[Multinomial[j1,j2,w0-1-j1-j2]*PVC[r+3-w0-w1-w2-delDimhalf,n1+w1-1+j1,n2+w2-1+j2,p1,q,p2,m0,m1,m2],{j1,0,w0-1},{j2,0,w0-1-j1}]],
  PVD[r_Integer,n1_Integer?NonNegative,n2_Integer?NonNegative,n3_Integer?NonNegative,s1_,s2_,s3_,s4_,s12_,s23_,m0_,m1_,m2_,m3_,opts__Rule] /; Quiet@Check[X`Private`validPVmodifiers[PVD,opts], False]:> 
	With[{w0=OptionValue[PVD,{opts},Weights][[1]], w1=OptionValue[PVD,{opts},Weights][[2]], w2=OptionValue[PVD,{opts},Weights][[3]], w3=OptionValue[PVD,{opts},Weights][[4]], delDimhalf=2-OptionValue[PVD,{opts},Dimensions]/2},
	  ((-1)^(w0-1) (-2)^(4-w0-w1-w2-w3-delDimhalf))/(Gamma[w0]Gamma[w1]Gamma[w2]Gamma[w3]) Sum[Multinomial[j1,j2,j3,w0-1-j1-j2-j3]*PVD[r+4-w0-w1-w2-w3-delDimhalf,n1+w1-1+j1,n2+w2-1+j2,n3+w3-1+j3,s1,s2,s3,s4,s12,s23,m0,m1,m2,m3],{j1,0,w0-1},{j2,0,w0-1-j1},{j3,0,w0-1-j1-j2}]]
};


(* ::Subsection:: *)
(*CreateLibrary and LibraryFunctionLoad*)


(* ::Subsubsection::Closed:: *)
(*Source*)


collierLinkSource = "
#include \"mathlink.h\"
#include \"WolframLibrary.h\"
#include <stdlib.h>

    void Init_cll(mint*, mint*);
    void InitCacheSystem_cll(mint*, mint*);
    void AddNewCache_cll(mint*, mint*);
    void InitEvent_cll(mint*);
    void SwitchOffCacheSystem_cll();
    void SwitchOnCacheSystem_cll();
    
    void SetMode_cll(mint*);
    void GetMode_cll(mint*);
    
    void SetReqAcc_cll(double*);
    void GetReqAcc_cll(double*);
    
    void SetCritAcc_cll(double*);
    void GetCritAcc_cll(double*);
    
    void SetCheckAcc_cll(double*);  //Irrelevant if mode!=3
    void GetCheckAcc_cll(double*);  //Irrelevant if mode!=3
    
    void SetRitmax_cll(mint*);
    void GetRitmax_cll(mint*);
    
    void SetMuUV2_cll(double*);
    void GetMuUV2_cll(double*);
    void SetMuIR2_cll(double*);
    void GetMuIR2_cll(double*);
    void SetDeltaUV_cll(double*);
    void GetDeltaUV_cll(double*);
    void SetDeltaIR_cll(double*, double*);
    void GetDeltaIR_cll(double*, double*);
    
    void Setminf2_cll(mint*, mcomplex[]);
    void AddMinf2_cll(mcomplex*);
    void GetNminf_cll(mint*);
    void Getminf2_cll(mcomplex[]);
    void clearminf2_cll();
    
    int GetNc_cll(mint*, mint*);
    
    void GetAccFlag_cll(int*);
    void InitAccFlag_cll();
    
    void GetErrFlag_cll(int*);
    void InitErrFlag_cll();
    void SwitchOffErrStop_cll();

    void DB_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mint*, double[]);
    
    void A_cll(mcomplex[], mcomplex[], mcomplex*, mint*, double[], mint*);
    void B_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mint*, double[], mint*);
    void C_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mint*, double[], mint*, double[]);
    void D_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mint*, double[], mint*, double[]);
    void E_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mint*, double[], mint*, double[]);
    void F_main_cll(mcomplex[], mcomplex[], mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mcomplex*, mint*, double[], mint*, double[]);

mcomplex result;
mcomplex* tnResult;
mcomplex* tnResultUV;

mint r,n1,n2,n3,n4,n5,requestedRank;
mcomplex s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15;
mcomplex m02,m12,m22,m32,m42,m52;
mbool onlyUV;
mint ouputElement;

/************************** COLLIER MESSAGE HANDLER ***************************/

const mcomplex cplxNAN = {0.0/0.0, 0.0/0.0};
int errFlag, accFlag;

void issueMessage(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res, mint denom, const char* messageName)
{
    mint ritmax;
    GetRitmax_cll(&ritmax); //used if issuing accuracy message
    
    const char* pvName;
    if (denom==1) {
        pvName = \"PVA\";
    } else if (denom==2) {
        pvName = \"PVB\";
    } else if (denom==3) {
        pvName = \"PVC\";
    } else if (denom==4) {
        pvName = \"PVD\";
    } else {
        pvName = \"PVX\";
    }
    
    mint i;
    int pvIndices[denom];
    long pvIndicesDims[1] = {denom};
    long pvIndicesDepth = 1;
    for (i=0; i<denom; i++) {
        pvIndices[i] = MArgument_getInteger(Args[i]);
    }
    
    double kinematicArgs[Argc-denom-1][2];
    long kinematicArgsDims[2] = {Argc-denom-1, 2};
    const char* kinematicArgsHeads[2] = {\"List\",\"Complex\"};
    long kinematicArgsDepth = 2;
    for (; i<Argc-1; i++) {
        kinematicArgs[i-denom][0] = mcreal(MArgument_getComplex(Args[i]));
        kinematicArgs[i-denom][1] = mcimag(MArgument_getComplex(Args[i]));
    }
    
    int pkt;
    MLINK link = libData->getMathLink(libData);
    MLPutFunction(link, \"EvaluatePacket\", 1);
    MLPutFunction(link, \"Message\", 3);
    MLPutFunction(link, \"MessageName\", 2);
    MLPutSymbol(link, \"COLLIER\");
    MLPutString(link, messageName);
    
    // Apply[Composition[HoldForm, \"pvName\"], Join[{-pvIndices-},Chop[{-kinematicArgs-}]]]
    MLPutFunction(link,\"Apply\",2);
    MLPutFunction(link,\"Composition\",2);
    MLPutSymbol(link,\"HoldForm\");
    MLPutSymbol(link,pvName);
    
    MLPutFunction(link,\"Join\",2);
    MLPutIntegerArray(link, pvIndices, pvIndicesDims, 0, pvIndicesDepth);
    
    MLPutFunction(link,\"Chop\",1);
    MLPutRealArray(link, &kinematicArgs[0][0], kinematicArgsDims, kinematicArgsHeads, kinematicArgsDepth);
    //
    
    MLPutInteger(link, ritmax);
    
    libData->processMathLink(link);
    pkt = MLNextPacket(link);
    if (pkt == RETURNPKT)
        MLNewPacket(link);
}


static inline void errAccFlagCheck(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res, mint denom)
{
    GetAccFlag_cll(&accFlag);
    GetErrFlag_cll(&errFlag);
    if (errFlag<0 || accFlag<0) {
        const char* messageName;
        if (errFlag<0) {
            if (errFlag==-1) {
                messageName = \"intcheck\";
            } else if (errFlag==-4){
                messageName = \"argcut\";
            } else if (errFlag==-5){
                messageName = \"critevent\";
            } else if (errFlag==-6){
                messageName = \"nored\";
            } else if (errFlag==-7){
                messageName = \"specnum\";
            } else if (errFlag==-9){
                messageName = \"intcons\";
            } else {
                messageName = \"nocase\";
            }
        }
        if (accFlag<0) {
            
            if (accFlag==-1) {
                messageName = \"reqacc\";
            } else {
                messageName = \"critacc\";
            }
        }
        issueMessage(libData, Argc, Args, Res, denom, messageName);
        if (errFlag <= -9 || accFlag <= -2) {
            MArgument_setComplex(Res, cplxNAN);
        }
    }
    InitAccFlag_cll();
    InitErrFlag_cll();
}

/****************************** HELPER FUNCTIONS ******************************/

//Integer power
mint ipow(mint base, mint exp)
{
    mint result = 1;
    while (exp)
    {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        base *= base;
    }
    return result;
}

//mcomplex square
mcomplex mcsquare(mcomplex z)
{
    double x = mcreal(z);
    double y = mcimag(z);
    mcomplex ilist = {x*x - y*y, 2.*x*y};
    return ilist;
}

/********************** STANDARD LIBRARYLINK FUNCTIONS ************************/



DLLEXPORT mint WolframLibrary_getVersion(){return WolframLibraryVersion;}

DLLEXPORT int WolframLibrary_initialize(WolframLibraryData libData){
    mint initDenom = 6; mint initRank = 6;
    Init_cll(&initDenom,&initRank);
    
    free(tnResult);
    free(tnResultUV);
    tnResult =   (mcomplex*) malloc((initRank/2+1)*ipow(initRank+1,initDenom-1)*sizeof(mcomplex));
    tnResultUV = (mcomplex*) malloc((initRank/2+1)*ipow(initRank+1,initDenom-1)*sizeof(mcomplex));
    
    mint initMode = 1;
    SetMode_cll(&initMode);
    
    double initDeltaUV = 0.0;
    SetDeltaUV_cll(&initDeltaUV);
    
    double initMuUV2 = 1.0;
    SetMuUV2_cll(&initMuUV2);
  
    // \[Pi]^2/12 shift on 1/Eps^2 to match Package-X conventions
    double initDeltaIR1 = 0.0;
    double initDeltaIR2 = 0.8224670334241131;
    SetDeltaIR_cll(&initDeltaIR1, &initDeltaIR2);
    
    double initMuIR2 = 1.0;
    SetMuIR2_cll(&initMuIR2);
    
    mint ninf = 0;
    double _Complex initMinf2[0] = {};
    Setminf2_cll(&ninf, initMinf2);
    
    double initReqAcc = 1.0E-8;
    SetReqAcc_cll(&initReqAcc);
    
    mint initRitMax = 14;
    SetRitmax_cll(&initRitMax);

    SwitchOffErrStop_cll();
    return 0;
}

DLLEXPORT char* WolframCompileLibrary_wrapper() {return \"Function[Slot[1]]\";}

DLLEXPORT void WolframLibrary_uninitialize(WolframLibraryData libData){
    free(tnResult);
    free(tnResultUV);
    return;
}

/****************************** COLLIER SETTINGS *******************************/

EXTERN_C DLLEXPORT int cllInit(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    mint I1=MArgument_getInteger(Args[1]);
    
    Init_cll(&I0,&I1);
    
    //tnResult =   new mcomplex[(I1/2+1)*ipow(I1+1,I0-1)];
    //tnResultUV = new mcomplex[(I1/2+1)*ipow(I1+1,I0-1)];
    
    free(tnResult);
    free(tnResultUV);
    tnResult =   (mcomplex*) malloc((I1/2+1)*ipow(I1+1,I0-1)*sizeof(mcomplex));
    tnResultUV = (mcomplex*) malloc((I1/2+1)*ipow(I1+1,I0-1)*sizeof(mcomplex));;
    
    //Must switch off error stop to prevent Mathematica Kernel from crashing.
    SwitchOffErrStop_cll();
    
    return LIBRARY_NO_ERROR;
}

//SET MODE
EXTERN_C DLLEXPORT int cllSetMode(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    
    SetMode_cll(&I0);
    GetMode_cll(&I0);
    
    MArgument_setInteger(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

//SET ULTRAVIOLET MU^2
EXTERN_C DLLEXPORT int cllSetMuUV2(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){

    double I0=MArgument_getReal(Args[0]);
    
    SetMuUV2_cll(&I0);
    GetMuUV2_cll(&I0);
    
    MArgument_setReal(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

//SET INFRARED MU^2
EXTERN_C DLLEXPORT int cllSetMuIR2(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    double I0=MArgument_getReal(Args[0]);
    
    SetMuIR2_cll(&I0);
    GetMuIR2_cll(&I0);
    
    MArgument_setReal(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

//SET ULTRAVIOLET 1/EPS
EXTERN_C DLLEXPORT int cllSetDeltaUV(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    double I0=MArgument_getReal(Args[0]);
    
    SetDeltaUV_cll(&I0);
    GetDeltaUV_cll(&I0);
    
    MArgument_setReal(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

//SET INFRARED 1/EPS AND 1/EPS^2
EXTERN_C DLLEXPORT int cllSetDeltaIR(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    MTensor I0=MArgument_getMTensor(Args[0]);
    mreal* input = libData->MTensor_getRealData(I0);
    MTensor out;
    
    SetDeltaIR_cll(&input[0], &input[1]);
    GetDeltaIR_cll(&input[0], &input[1]);
    
    mint outdims[1] = {2};
    
    int err = libData->MTensor_new(/*type*/MType_Real, /*rank*/1, outdims, &out);
    mint i1 = 1;
    mint i2 = 2;
    
    err = libData->MTensor_setReal(out, &i1, input[0]);
    err = libData->MTensor_setReal(out, &i2, input[1]);
    
    MArgument_setMTensor(Res,out);
    
    return LIBRARY_NO_ERROR;
}

//SET SMALL MASSES
EXTERN_C DLLEXPORT int cllSetMinf2(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    mint numberOfSmallMasses = MArgument_getInteger(Args[0]);
    MTensor I1 = MArgument_getMTensor(Args[1]);
    mcomplex* listOfMassesInput = libData->MTensor_getComplexData(I1);
    mcomplex* listOfMassSquares;
    listOfMassSquares = (mcomplex*) malloc(numberOfSmallMasses * sizeof(mcomplex));
    
	int i;
    for (i=0; i<numberOfSmallMasses; i++) {
        listOfMassSquares[i] = mcsquare(listOfMassesInput[i]);
    }
    
    mcomplex* listOfMassSquaresOutput;
    listOfMassSquaresOutput = (mcomplex*) malloc(numberOfSmallMasses * sizeof(mcomplex));
    
    MTensor T1;
    
    Setminf2_cll(&numberOfSmallMasses, listOfMassSquares);
    Getminf2_cll(listOfMassSquaresOutput);
    
    mint outdims[1] = {numberOfSmallMasses};
    int err = libData->MTensor_new(/*type*/MType_Complex, /*rank*/1, outdims, &T1);
    
	mint j;
    for (j=1; j<=numberOfSmallMasses && !err; j++) {
        err = libData->MTensor_setComplex(T1, &j, listOfMassSquaresOutput[j-1]);
    };
    
    free(listOfMassSquaresOutput);
    
    MArgument_setMTensor(Res,T1);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllSetReqAcc(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    double I0=MArgument_getReal(Args[0]);
    
    SetReqAcc_cll(&I0);
    GetReqAcc_cll(&I0);
    
    MArgument_setReal(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllSetCritAcc(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    double I0=MArgument_getReal(Args[0]);
    
    SetCritAcc_cll(&I0);
    GetCritAcc_cll(&I0);
    
    MArgument_setReal(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllSetRitmax(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    
    SetRitmax_cll(&I0);
    GetRitmax_cll(&I0);
    
    MArgument_setInteger(Res,I0);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllGetErrFlag(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    GetErrFlag_cll(&errFlag);
    mint out = errFlag;
    MArgument_setInteger(Res,out);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllGetAccFlag(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    GetAccFlag_cll(&accFlag);
    mint out = accFlag;
    MArgument_setInteger(Res,out);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int cllInitErrFlag(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    InitErrFlag_cll();
    
    //MArgument_setInteger(Res,out);
    
    return LIBRARY_NO_ERROR;
}

/*********************************** CACHE ************************************/

//cllInitCacheSystem
EXTERN_C DLLEXPORT int cllInitCacheSystem(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    mint I1=MArgument_getInteger(Args[1]);
    InitCacheSystem_cll(&I0,&I1);
    return LIBRARY_NO_ERROR;
}

//cllAddNewCache
EXTERN_C DLLEXPORT int cllAddNewCache(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    mint O0=0;
    AddNewCache_cll(&O0, &I0);
    MArgument_setInteger(Res,O0);
    return LIBRARY_NO_ERROR;
}

//cllInitEvent
EXTERN_C DLLEXPORT int cllInitEvent(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    mint I0=MArgument_getInteger(Args[0]);
    InitEvent_cll(&I0);
    return LIBRARY_NO_ERROR;
}
//cllSwitchOffCacheSystem
EXTERN_C DLLEXPORT int cllSwitchOffCacheSystem(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    SwitchOffCacheSystem_cll();
    return LIBRARY_NO_ERROR;
}
//cllSwitchOnCacheSystem
EXTERN_C DLLEXPORT int cllSwitchOnCacheSystem(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    SwitchOnCacheSystem_cll();
    return LIBRARY_NO_ERROR;
}
 
/****************** PASSARINO-VELTMAN COEFFICIENT FUNCTIONS *******************/

EXTERN_C DLLEXPORT int Acll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    requestedRank = 2*r;
    m02 = MArgument_getComplex(Args[1]);
    onlyUV = MArgument_getBoolean(Args[2]);
    
    A_cll(tnResult,tnResultUV,&m02,&requestedRank,0,0);
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[r]);
    }else{
        MArgument_setComplex(Res,tnResult[r]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 1);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int Bcll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    requestedRank = 2*r+n1;
    s1 = MArgument_getComplex(Args[2]);
    m02 = MArgument_getComplex(Args[3]);
    m12 = MArgument_getComplex(Args[4]);
    onlyUV = MArgument_getBoolean(Args[5]);
    
    B_main_cll(tnResult,tnResultUV,&s1,&m02,&m12,&requestedRank,0,0);
    
    ouputElement = r + (requestedRank/2+1)*n1;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 2);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int DBcll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    requestedRank = 2*r+n1;
    s1 = MArgument_getComplex(Args[2]);
    m02 = MArgument_getComplex(Args[3]);
    m12 = MArgument_getComplex(Args[4]);
    onlyUV = MArgument_getBoolean(Args[5]);
    
    DB_main_cll(tnResult,tnResultUV,&s1,&m02,&m12,&requestedRank,0);
    
    ouputElement = r + (requestedRank/2+1)*n1;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 2);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int Ccll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    n2 = MArgument_getInteger(Args[2]);
    requestedRank = 2*r+n1+n2;
    s1 = MArgument_getComplex(Args[3]);
    s2 = MArgument_getComplex(Args[4]);
    s3 = MArgument_getComplex(Args[5]);
    m02 = MArgument_getComplex(Args[6]);
    m12 = MArgument_getComplex(Args[7]);
    m22 = MArgument_getComplex(Args[8]);
    onlyUV = MArgument_getBoolean(Args[9]);
    
    C_main_cll(tnResult,tnResultUV,&s1,&s2,&s3,&m02,&m12,&m22,&requestedRank,0,0,0);
    
    ouputElement = r + (requestedRank/2+1)*n1 + (requestedRank/2+1)*(requestedRank+1)*n2;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 3);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int Dcll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    n2 = MArgument_getInteger(Args[2]);
    n3 = MArgument_getInteger(Args[3]);
    requestedRank = 2*r+n1+n2+n3;
    s1 = MArgument_getComplex(Args[4]);
    s2 = MArgument_getComplex(Args[5]);
    s3 = MArgument_getComplex(Args[6]);
    s4 = MArgument_getComplex(Args[7]);
    s5 = MArgument_getComplex(Args[8]);
    s6 = MArgument_getComplex(Args[9]);
    m02 = MArgument_getComplex(Args[10]);
    m12 = MArgument_getComplex(Args[11]);
    m22 = MArgument_getComplex(Args[12]);
    m32 = MArgument_getComplex(Args[13]);
    onlyUV = MArgument_getBoolean(Args[14]);
    
    D_main_cll(tnResult,tnResultUV,&s1,&s2,&s3,&s4,&s5,&s6,&m02,&m12,&m22,&m32,&requestedRank,0,0,0);
    
    ouputElement = r + (requestedRank/2+1)*n1 + (requestedRank/2+1)*(requestedRank+1)*n2 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*n3;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 4);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int Ecll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    n2 = MArgument_getInteger(Args[2]);
    n3 = MArgument_getInteger(Args[3]);
    n4 = MArgument_getInteger(Args[4]);
    requestedRank = 2*r+n1+n2+n3+n4;
    s1 = MArgument_getComplex(Args[5]);
    s2 = MArgument_getComplex(Args[6]);
    s3 = MArgument_getComplex(Args[7]);
    s4 = MArgument_getComplex(Args[8]);
    s5 = MArgument_getComplex(Args[9]);
    s6 = MArgument_getComplex(Args[10]);
    s7 = MArgument_getComplex(Args[11]);
    s8 = MArgument_getComplex(Args[12]);
    s9 = MArgument_getComplex(Args[13]);
    s10 = MArgument_getComplex(Args[14]);
    m02 = MArgument_getComplex(Args[15]);
    m12 = MArgument_getComplex(Args[16]);
    m22 = MArgument_getComplex(Args[17]);
    m32 = MArgument_getComplex(Args[18]);
    m42 = MArgument_getComplex(Args[19]);
    onlyUV = MArgument_getBoolean(Args[20]);
    
    E_main_cll(tnResult,tnResultUV,&s1,&s2,&s3,&s4,&s5,&s6,&s7,&s8,&s9,&s10,&m02,&m12,&m22,&m32,&m42,&requestedRank,0,0,0);
    
    ouputElement = r + (requestedRank/2+1)*n1 + (requestedRank/2+1)*(requestedRank+1)*n2 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*n3 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*(requestedRank+1)*n4;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 5);
    
    return LIBRARY_NO_ERROR;
}

EXTERN_C DLLEXPORT int Fcll(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
    
    r = MArgument_getInteger(Args[0]);
    n1 = MArgument_getInteger(Args[1]);
    n2 = MArgument_getInteger(Args[2]);
    n3 = MArgument_getInteger(Args[3]);
    n4 = MArgument_getInteger(Args[4]);
    n5 = MArgument_getInteger(Args[5]);
    requestedRank = 2*r+n1+n2+n3+n4+n5;
    s1 = MArgument_getComplex(Args[6]);
    s2 = MArgument_getComplex(Args[7]);
    s3 = MArgument_getComplex(Args[8]);
    s4 = MArgument_getComplex(Args[9]);
    s5 = MArgument_getComplex(Args[10]);
    s6 = MArgument_getComplex(Args[11]);
    s7 = MArgument_getComplex(Args[12]);
    s8 = MArgument_getComplex(Args[13]);
    s9 = MArgument_getComplex(Args[14]);
    s10 = MArgument_getComplex(Args[15]);
    s11 = MArgument_getComplex(Args[16]);
    s12 = MArgument_getComplex(Args[17]);
    s13 = MArgument_getComplex(Args[18]);
    s14 = MArgument_getComplex(Args[19]);
    s15 = MArgument_getComplex(Args[20]);
    m02 = MArgument_getComplex(Args[21]);
    m12 = MArgument_getComplex(Args[22]);
    m22 = MArgument_getComplex(Args[23]);
    m32 = MArgument_getComplex(Args[24]);
    m42 = MArgument_getComplex(Args[25]);
    m52 = MArgument_getComplex(Args[26]);
    onlyUV = MArgument_getBoolean(Args[27]);
    
    F_main_cll(tnResult,tnResultUV,&s1,&s2,&s3,&s4,&s5,&s6,&s7,&s8,&s9,&s10,&s11,&s12,&s13,&s14,&s15,&m02,&m12,&m22,&m32,&m42,&m52,&requestedRank,0,0,0);
    
    ouputElement = r + (requestedRank/2+1)*n1 + (requestedRank/2+1)*(requestedRank+1)*n2 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*n3 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*(requestedRank+1)*n4 + (requestedRank/2+1)*(requestedRank+1)*(requestedRank+1)*(requestedRank+1)*(requestedRank+1)*n5;
    
    if (onlyUV) {
        MArgument_setComplex(Res,tnResultUV[ouputElement]);
    }else{
        MArgument_setComplex(Res,tnResult[ouputElement]);
    }
    
    errAccFlagCheck(libData, Argc, Args, Res, 6);
    
    return LIBRARY_NO_ERROR;
}

";


(* ::Subsubsection::Closed:: *)
(*CreateLibrary*)


$CollierLinkDirectory = ParentDirectory[DirectoryName[FindFile["CollierLink`"]]];
AppendTo[$LibraryPath,FileNameJoin[{$CollierLinkDirectory,"LibraryResources",$SystemID}]];

If[UnsameQ[$CollierLibraryFile=FindLibrary["libcollierX"],$Failed],

  $libMathVer=ToString[NumberForm[$VersionNumber,{4,1},NumberPadding->{"","0"},NumberPoint->"-"],OutputForm];
  $CollierLinkLibraryFile = FindLibrary["collierlink-"<>$libMathVer];
  (*$CollierLinkSourceFile = FileNameJoin[{$CollierLinkDirectory,"collierlink.c"}];*)

  Quiet[DeleteDirectory[FileNameJoin[{$TemporaryDirectory,"collierlink"}],DeleteContents->True],DeleteDirectory::nodir];

  If[$CollierLinkLibraryFile===$Failed,
	Block[{$ContextPath},Needs["CCompilerDriver`"]];
	$CollierLinkLibraryFile=
	  CCompilerDriver`CreateLibrary[(*Import[$CollierLinkSourceFile,"String"]*)collierLinkSource,"collierlink-"<>$libMathVer
		,"Debug"->False
		,"Libraries"->$CollierLibraryFile
		,"Language"->Automatic
		,"TargetDirectory"->FileNameJoin[{$CollierLinkDirectory,"LibraryResources",$SystemID}]
		,"WorkingDirectory"->FileNameJoin[{$TemporaryDirectory,"collierlink"}]
		,"CleanIntermediate"->Full
		,"PostCompileCommands"->If[$SystemID==="MacOSX-x86-64","install_name_tool -id \"@loader_path/collierlink-"<>$libMathVer<>".dylib\" collierlink-"<>$libMathVer<>".dylib",""]
		(*,"ShellCommandFunction"->Echo*)]
  ]
  (*;Export[FileNameJoin[{$CollierLinkDirectory,"collierlink.c"}],collierLinkSource,"String"]*);
  ,
  Message[LibraryFunction::nolib, "libcollierX"]
];
Remove[collierLinkSource];


(* ::Subsubsection::Closed:: *)
(*LibraryFunctionLoad, PVA, PVB, PVC, PVD, PVX*)


If[UnsameQ[$CollierLibraryFile,$Failed] && UnsameQ[$CollierLinkLibraryFile,$Failed],

  Internal`InheritedBlock[{LibraryFunctionLoad},

	$CollierLibraryVersion="1.2.1";
	SetOptions[LibraryFunctionLoad,"AutomaticDelete"->False];

	cllInit=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllInit",{Integer,Integer},"Void"];

	cllSetMode=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetMode",{Integer},Integer];
	cllSetMuUV2=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetMuUV2",{Real},Real];
	cllSetMuIR2=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetMuIR2",{Real},Real];
	cllSetDeltaUV=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetDeltaUV",{Real},Real];
	cllSetDeltaIR=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetDeltaIR",{{Real,1}},{Real,1}];
	cllSetMinf2=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetMinf2",{Integer,{Complex,1}},{Complex,1}];
	cllSetReqAcc=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetReqAcc",{Real},Real];
	cllSetCritAcc=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetCritAcc",{Real},Real];
	cllSetRitmax=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSetRitmax",{Integer},Integer];

	cllInitCacheSystem=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllInitCacheSystem",{Integer,Integer},"Void"];
	cllAddNewCache=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllAddNewCache",{Integer},Integer];

	(*cllInitEvent=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllInitEvent",{Integer},"Void"];
	cllSwitchOffCacheSystem=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSwitchOffCacheSystem",{},"Void"];
	cllSwitchOnCacheSystem=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllSwitchOnCacheSystem",{},"Void"];*)

	(*Acll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Acll",{Integer,Complex,"Boolean"},Complex];*)
	(*Bcll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Bcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex];*)
	(*DBcll=LibraryFunctionLoad[$CollierLinkLibraryFile,"DBcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex];*)
	(*Ccll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Ccll",{Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex];*)
	(*Dcll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Dcll",{Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex];*)
	(*Ecll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Ecll",{Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex];*)
	(*Fcll=LibraryFunctionLoad[$CollierLinkLibraryFile,"Fcll",{Integer,Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex];*)

	(*TNcll=LibraryFunctionLoad[$CollierLinkLibraryFile,"TNcll",{{Complex,1,"Constant"},{Complex,1,"Constant"},Integer},{Complex,2}];*)

	(*Other functions for debugging*)

	(*cllGetErrFlag=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllGetErrFlag",{},Integer];
	cllInitErrFlag=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllInitErrFlag",{},"Void"];

	A0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"A0cll",{Complex},Complex];
	B0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"B0cll",{Complex,Complex,Complex},Complex];
	C0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"C0cll",{Complex,Complex,Complex,Complex,Complex,Complex},Complex];
	D0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"D0cll",{Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex},Complex];
	E0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"E0cll",{Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex},Complex];
	F0cll=LibraryFunctionLoad[$CollierLinkLibraryFile,"F0cll",{Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex},Complex];*)

	cllGetErrFlag=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllGetErrFlag",{},Integer];
	cllGetAccFlag=LibraryFunctionLoad[$CollierLinkLibraryFile,"cllGetAccFlag",{},Integer];

	SetAttributes[{cllInit,cllSetMode,cllSetMuUV2,cllSetMuIR2,cllSetDeltaUV,cllSetDeltaIR,cllSetMinf2,cllSetReqAcc,cllSetCritAcc,cllSetRitmax(*,Acll,Bcll,DBcll,Ccll,Dcll,Ecll,Fcll*)},{Protected,ReadProtected,Locked}];

	Unprotect[PVA,PVB,PVC,PVD,PVX];
	SetAttributes[{PVA,PVB,PVC,PVD,PVX},NumericFunction];

	HoldPattern[expr: PVA[r_Integer?NonNegative,m0_?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r<= $MaxRank = 
	(*Acll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Acll",{Integer,Complex,"Boolean"},Complex][r,m0^2,False];

	HoldPattern[expr: PVB[PatternSequence[r_Integer,n1_Integer]?NonNegative,
			s_?Internal`RealValuedNumericQ,PatternSequence[m0_,m1_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1<=$MaxRank = 
	(*Bcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Bcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex][r,n1,s,m0^2,m1^2,False];

	HoldPattern[expr: Derivative[0,0,1,0,0][PVB][PatternSequence[r_Integer,n1_Integer]?NonNegative,
			s_?Internal`RealValuedNumericQ,PatternSequence[m0_,m1_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1<=$MaxRank = 
	(*DBcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"DBcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex][r,n1,s,m0^2,m1^2,False];

	HoldPattern[expr: PVC[PatternSequence[r_Integer,n1_Integer,n2_Integer]?NonNegative,
			PatternSequence[s1_,s2_,s3_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2<=$MaxRank = 
	(*Ccll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Ccll",{Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,s1,s2,s3,m0^2,m1^2,m2^2,False];

	HoldPattern[expr: PVD[PatternSequence[r_Integer,n1_Integer,n2_Integer,n3_Integer]?NonNegative,
			PatternSequence[s1_,s2_,s3_,s4_,s12_,s23_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_,m3_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3<=$MaxRank = 
	(*Dcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Dcll",{Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,s1,s2,s3,s4,s12,s23,m0^2,m1^2,m2^2,m3^2,False];

	HoldPattern[expr: PVX[PatternSequence[r_Integer,n1_Integer,n2_Integer,n3_Integer,n4_Integer]?NonNegative,
			PatternSequence[s1_,s2_,s3_,s4_,s5_,s6_,s7_,s8_,s9_,s10_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_,m3_,m4_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3+n4<=$MaxRank = 
	(*Ecll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Ecll",{Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,n4,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,m0^2,m1^2,m2^2,m3^2,m4^2,False];

	HoldPattern[expr: PVX[PatternSequence[r_Integer,n1_Integer,n2_Integer,n3_Integer,n4_Integer,n5_Integer]?NonNegative,
			PatternSequence[s1_,s2_,s3_,s4_,s5_,s6_,s7_,s8_,s9_,s10_,s11_,s12_,s13_,s14_,s15_]?Internal`RealValuedNumericQ,
			m0_?NumericQ,m1_?NumericQ,m2_?NumericQ,m3_?NumericQ,m4_?NumericQ,m5_?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3+n4+n5<=$MaxRank = 
	(*Fcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Fcll",{Integer,Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,n4,n5,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,m0^2,m1^2,m2^2,m3^2,m4^2,m5^2,False];

	(*UV Divergent Parts*)
	HoldPattern[expr: UVDiv[PVA][r_?NonNegative,m0_?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r<=$MaxRank && (Last[Internal`TestIntegerQ[r]]) = 
	(*Acll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Acll",{Integer,Complex,"Boolean"},Complex][r,m0^2,True];

	HoldPattern[expr: UVDiv[PVB][PatternSequence[r_,n1_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			s_?Internal`RealValuedNumericQ,PatternSequence[m0_,m1_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1<=$MaxRank = 
	(*Bcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Bcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex][r,n1,s,m0^2,m1^2,True];
	HoldPattern[expr: Derivative[0,0,1,0,0][UVDiv[PVB]][PatternSequence[r_,n1_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			s_?Internal`RealValuedNumericQ,PatternSequence[m0_,m1_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1<=$MaxRank = 
	(*DBcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"DBcll",{Integer,Integer,Complex,Complex,Complex,"Boolean"},Complex][r,n1,s,m0^2,m1^2,True];

	HoldPattern[expr: UVDiv[PVC][PatternSequence[r_,n1_,n2_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			PatternSequence[s1_,s2_,s3_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2<=$MaxRank = 
	(*Ccll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Ccll",{Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,s1,s2,s3,m0^2,m1^2,m2^2,True];

	HoldPattern[expr: UVDiv[PVD][PatternSequence[r_,n1_,n2_,n3_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			PatternSequence[s1_,s2_,s3_,s4_,s12_,s23_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_,m3_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3<=$MaxRank = 
	(*Dcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Dcll",{Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,s1,s2,s3,s4,s12,s23,m0^2,m1^2,m2^2,m3^2,True];

	HoldPattern[expr: UVDiv[PVX][PatternSequence[r_,n1_,n2_,n3_,n4_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			PatternSequence[s1_,s2_,s3_,s4_,s5_,s6_,s7_,s8_,s9_,s10_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_,m3_,m4_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3+n4<=$MaxRank = 
	(*Ecll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Ecll",{Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,n4,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,m0^2,m1^2,m2^2,m3^2,m4^2,True];

	HoldPattern[expr: UVDiv[PVX][PatternSequence[r_,n1_,n2_,n3_,n4_,n5_]?(TrueQ[NonNegative[#]]&&Last[Internal`TestIntegerQ[#]]&),
			PatternSequence[s1_,s2_,s3_,s4_,s5_,s6_,s7_,s8_,s9_,s10_,s11_,s12_,s13_,s14_,s15_]?Internal`RealValuedNumericQ,
			PatternSequence[m0_,m1_,m2_,m3_,m4_,m5_]?NumericQ]] /; Precision[Hold[expr]] =!=\[Infinity] && 2r+n1+n2+n3+n4+n5<=$MaxRank = 
	(*Fcll*)LibraryFunctionLoad[$CollierLinkLibraryFile,"Fcll",{Integer,Integer,Integer,Integer,Integer,Integer,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,Complex,"Boolean"},Complex][r,n1,n2,n3,n4,n5,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,m0^2,m1^2,m2^2,m3^2,m4^2,m5^2,True];
  ];

  N[PVA[r_,m0_],prec_.]:=With[{nargs=N[{m0},prec]},PVA[r,#]& @@ nargs /; nargs=!={m0}];
  N[PVB[r_,n1_,s_,m0_,m1_],prec_.]:=With[{nargs=N[{s,m0,m1},prec]},PVB[r,n1,##]& @@ nargs /; nargs=!={s,m0,m1}];
  N[PVC[r_,n1_,n2_,s1_,s2_,s3_,m0_,m1_,m2_],prec_.]:=With[{nargs=N[{s1,s2,s3,m0,m1,m2},prec]},PVC[r,n1,n2,##]& @@ nargs /; nargs=!={s1,s2,s3,m0,m1,m2}];
  N[PVD[r_,n1_,n2_,n3_,s1_,s2_,s3_,s4_,s12_,s23_,m0_,m1_,m2_,m3_],prec_.]:=With[{nargs=N[{s1,s2,s3,s4,s12,s23,m0,m1,m2,m3},prec]},PVD[r,n1,n2,n3,##]& @@ nargs /; nargs=!={s1,s2,s3,s4,s12,s23,m0,m1,m2,m3}];

  Protect[PVA,PVB,PVC,PVD,PVX];

];


(* ::Subsection::Closed:: *)
(*CollierLink Options*)


CollierLinkOptions::clopt = SetCollierLinkOptions::clopt = "`1` is not a known CollierLinkOption.";
SetCollierLinkOptions::rep = "`1` is not a valid replacement rule.";
SetCollierLinkOptions::mode = "Value of CollierLink option `1` is not '1' (for COLI\[Hyphen]implementation), '2' (for DD\[Hyphen]implementation), or '3' (for check COLI\[Hyphen] against DD\[Hyphen]implementation).";
SetCollierLinkOptions::zeromu = "Value of CollierLink option `1` is not a non-zero real number.";
SetCollierLinkOptions::invepsir = "Value of CollierLink option `1` is not a list of two real numbers.";
SetCollierLinkOptions::invepsuv = "Value of CollierLink option `1` is not a real number.";
SetCollierLinkOptions::maxdenom = "Value of CollierLink option \"MaxDenominators\" is locked at 6, and cannot be modified.";
SetCollierLinkOptions::maxrank = "Value of CollierLink option `1` is not a positive integer.";
SetCollierLinkOptions::infmass = "Value of CollierLink option `1` is not a list of non-zero complex numbers.";
SetCollierLinkOptions::prec = "Value of CollierLink option `1` is not a positive machine-sized integer or real.";
SetCollierLinkOptions::iter = "Value of CollierLink option `1` is not a positive integer larger than `2`.";
SetCollierLinkOptions::reset = "Warning: modifying the value of global CollierLink option MaxRank resets all other CollierLink options to their default values.";


Options[$CollierLinkDefault] = {"Mode"->1, "InvEpsUV"->0.0, "MuUV"->1.0,
								"InvEpsIR"->{0.0, 0.0}, "MuIR"->1.0,
								"SmallMasses"->{}, "ReqAcc"->N[10^-8], "RitMax"->14};
SetAttributes[$CollierLinkDefault,{Protected,ReadProtected,Locked}];

$MaxRank=6;
Options[$CollierLink] = {"MaxDenominators"->6(*FROZEN*), "MaxRank"->$MaxRank,
						 "Mode"->1, "InvEpsUV"->0.0, "MuUV"->1.0, "InvEpsIR"->{0.0, 0.0},
						 "MuIR"->1.0,  "SmallMasses"->{}, "ReqAcc"->N[10^-8], "RitMax"->14};


(*This really needs to be cleaned up*)
resetCollierCache[]:=
(
	cllInitCacheSystem[0,1]; (*Clear old cache*)
	cllAddNewCache[Last[#]]& /@ $ccfCaches; (*Add back all the caches*)
	Through[$ccfInit[]] (*Re-prime the caches*)
);

resetCollierOptions[maxDenom:6,maxRank_]:=
(
	cllInit[maxDenom,maxRank];
	$MaxRank = maxRank;
	cllSetMode[1];
	cllSetDeltaUV[0.0];
	cllSetMuUV2[1.0];
	cllSetDeltaIR[N[{0,\[Pi]^2/12}]]; (*\[Pi]^2/12 shift on 1/Eps^2 to match Package-X conventions.*)
	cllSetMuIR2[1.0];
	cllSetMinf2[0,{}];
	cllSetReqAcc[N[10^-8]];
	cllSetRitmax[Max[14,maxRank+4-maxDenom]];
	SetOptions[$CollierLink,Options[$CollierLinkDefault]];
	SetOptions[$CollierLink,"RitMax"->Max[14,maxRank+4-maxDenom]]
);


SetCollierLinkOptions[expr_List] := (SetCollierLinkOptions /@ expr; Options[$CollierLink]);

SetCollierLinkOptions[expr_] := 
RuleCondition[If[MatchQ[expr,Rule[_,_]],
  With[{setting = expr[[1]], value = expr[[2]]},
	Switch[
	  setting,
	  "MaxDenominators",
		Message[SetCollierLinkOptions::maxdenom, setting -> value],
	  "MaxRank",
		If[Head[value]===Integer && value>=1,
		  If[value!=OptionValue[$CollierLink,"MaxRank"],
			If[Options[$CollierLinkDefault]=!=FilterRules[Options[$CollierLink],Options[$CollierLinkDefault]],
			  Message[SetCollierLinkOptions::reset];
			]; 
			resetCollierOptions[OptionValue[$CollierLink,"MaxDenominators"],value];
			resetCollierCache[];
		  ];
		  SetOptions[$CollierLink, setting -> value]
		  ,
		  Message[SetCollierLinkOptions::maxrank, setting -> value];Fail],
	  "Mode",
		If[value===1 || value===2 || value===3,
		  (*If[value===2 || value===3, Message[SetCollierLinkOptions::ddwarn]; Off[SetCollierLinkOptions::ddwarn]];*)
		  cllSetMode[value]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> value]
		  ,
		  Message[SetCollierLinkOptions::mode, setting->value]; Fail
		],
	  "InvEpsUV",
		If[Internal`RealValuedNumericQ[value],
		  cllSetDeltaUV[N[value]]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> N[value]]
		  ,
		  Message[SetCollierLinkOptions::invepsuv, setting->value]; Fail
		],
	  "MuUV",
		If[Internal`RealValuedNumberQ[value] && !PossibleZeroQ[value],
		  cllSetMuUV2[N[value^2]]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> value]
		  ,
		  Message[SetCollierLinkOptions::zeromu, setting -> value]
		],
	  "InvEpsIR",
		If[MatchQ[value, {_?Internal`RealValuedNumericQ, _?Internal`RealValuedNumericQ}],
		  (*\[Pi]^2/12 shift to match Package-X conventions.*)
		  cllSetDeltaIR[N[value+{0,\[Pi]^2/12}]]; resetCollierCache[]; 
		  SetOptions[$CollierLink,setting->value]
		  ,
		  Message[SetCollierLinkOptions::invepsir, setting->value];Fail
		],
	  "MuIR",
		If[Internal`RealValuedNumberQ[value] && !PossibleZeroQ[value],
		  cllSetMuIR2[N[value^2]]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> value]
		  ,
		  Message[SetCollierLinkOptions::zeromu, setting -> value]
		],
	  "SmallMasses",
		If[MatchQ[value, {_?(NumericQ[#]&&!PossibleZeroQ[#]&)...}],
		  cllSetMinf2[Length[value],N[value]]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> value],
		  Message[SetCollierLinkOptions::infmass, setting -> value];Fail
		],
	  "ReqAcc",
	    If[Internal`RealValuedNumericQ[value],
		  cllSetReqAcc[N[value]]; resetCollierCache[];
		  (*cllSetCritAcc[10^(-value+1)];*)
		  SetOptions[$CollierLink, setting -> N[value]],
		  Message[SetCollierLinkOptions::prec, setting -> value];Fail
	    ],
	  "RitMax",
	    If[MatchQ[value,_Integer] && value >= 7 && value >= OptionValue[$CollierLink,"MaxRank"] + 4 -(OptionValue[$CollierLink,"MaxDenominators"]),
		  cllSetRitmax[value]; resetCollierCache[];
		  SetOptions[$CollierLink, setting -> value],
		  Message[SetCollierLinkOptions::iter, setting -> value, Max[7,(OptionValue[$CollierLink,"MaxRank"]) + 4 -(OptionValue[$CollierLink,"MaxDenominators"])]];Fail
	    ],
	  _, Message[SetCollierLinkOptions::clopt,setting]; Fail
	]
  ],Message[SetCollierLinkOptions::rep,expr]; Fail
]];



LHS_SetCollierLinkOptions:=RuleCondition[X`Internal`CheckArgumentCount[LHS,1,1];Fail];


CollierLinkOptions[name_] := RuleCondition[Quiet[Check[Options[$CollierLink, name],Message[CollierLinkOptions::clopt,name];Fail,{Options::optnf}],{Options::optnf}]];
CollierLinkOptions[] := Options[$CollierLink];

LHS_CollierLinkOptions:=RuleCondition[X`Internal`CheckArgumentCount[LHS,0,1];Fail];


(* ::Subsection::Closed:: *)
(*SeparateUV*)


(*Does not work if PV functions are wrapped in other functions other than Plus and Times, such as Conjugate.*)
(*It is anyway supposed to be used at the amplitude level, and not on its square.*)

SeparateUV::epspole = "Input expression exhibits a pole as `1`->4 and `2`->0 independent of Passarino\[Hyphen]Veltman functions.  A separation cannot be made.";
SeparateUV::nlinpv = "Input expression is not a linear function of Passarino-Veltman functions.  A separation cannot be made.";

SeparateUV[expr_] :=
  Module[{answer,lambda},

	If[!(FreeQ[expr,_PVA|_PVB|_PVC|_PVD|_PVX]||Internal`LinearQ[expr/.(e:_PVA|_PVB|_PVC|_PVD|_PVX:>lambda*e),lambda]),
	  Message[SeparateUV::nlinpv]; Return[$Failed,Module]
	];

	(*Set Dim = 4-2Eps*)
	answer = expr/.Dim->4-2*Eps;

	(*Expand to order Eps*)
	If[!TrueQ[Internal`PolynomialFunctionQ[answer,Eps]], 
	  answer = Series[answer,{Eps,0,1},Analytic->False];
	  If[Head[answer]===SeriesData && answer[[4]]<0,
		Message[SeparateUV::epspole,Dim,Eps]; Return[$Failed,Module],
		answer = Normal[answer]
	  ]
	];

	(*Replace any Eps multiplying PVX function with UVDiv[PVX], or zero if rank is not high enough*)
	(*Replace all remaining Eps to 0*)

	If[FreeQ[answer,Eps|Dim],answer,
	  Expand[answer,Eps] /. 
		{Eps*rest_ :> (Replace[#, 
		   {HoldPattern[c_. pv:(PVA|PVB|PVC|PVD|PVX)[___]] :> c*MapAt[UVDiv,pv,0],
			HoldPattern[c_. pv:Derivative[___][PVA|PVB|PVC|PVD|PVX][___]] :> c*MapAt[UVDiv,pv,{0,1}],
			_ :> 0},Switch[Head[#],Plus,{1},_,{0}]]&)[Expand[rest, _PVA|_PVB|_PVC|_PVD|_PVX]]
	    ,HoldPattern[Eps] :> 0}
	]

  ];

LHS_SeparateUV:=RuleCondition[X`Internal`CheckArgumentCount[LHS,1,1];Fail];


(* ::Section:: *)
(*Code generation*)


(* ::Subsection::Closed:: *)
(*Progress bar, checks, error message handler*)


$ccProgVal = -1;
$ccProgString = "";

ccMakeProgressCell[maxProgVal_Integer]:=
 ($ccProgVal = -1;
  $ccProgString = "";
  If[$Notebooks && $Output=!={},
  MathLink`CallFrontEnd[FrontEnd`PrintTemporaryPacket[]];
  $ccProgCell=MathLink`CallFrontEnd[ExpressionPacket[BoxData[FrameBox[
	StyleBox[
	  ToBoxes[
		Grid[
		  {{Dynamic[ProgressIndicator[$ccProgVal,{0,maxProgVal}]]},
		   {StringForm["`1` of `2`: `3`",Dynamic[$ccProgVal],maxProgVal,Dynamic[$ccProgString]]}}
		,Alignment->Left]]
	  ,FontFamily->"Verdana",FontSize->11,FontColor->RGBColor[0.2,0.4,0.6]]
	,Background->RGBColor[0.96,0.98,1.],FrameMargins->{{24,24},{8,8}},FrameStyle->RGBColor[0.2,0.4,0.6],StripOnInput->False]]]]]);

ccDestroyProgressCell[]:=If[$Notebooks && $Output=!={}, NotebookDelete[$ccProgCell]];

incrementProgressCell[message_String]:=(Increment[$ccProgVal];$ccProgString=message);


$currentCodeGenerationFunction = Null;

CollierCodeGenerate::fdup = CollierCompile::fdup = Compile::fdup;
CollierCodeGenerate::parlist = CollierCompile::parlist = "Parameter specification `1` is not a List.";
CollierCodeGenerate::lpar = CollierCompile::lpar = "Parameter specification `1` contains `2`, which is not a symbol.";
CollierCodeGenerate::dscope = CollierCompile::dscope = "Scoping construct `1` is too deep for CollierCompile to localize variables.";

(*DOC*)CollierCodeGenerate::dimdep = CollierCompile::dimdep = "Warning: input depends explicitly on `1`.  Assuming its value is 4.";
(*DOC*)CollierCodeGenerate::epsdep = CollierCompile::epsdep = "Input has explicit dependence on dimensional regularization parameter `1`, and cannot be compiled.";

CollierCodeGenerate::pvexotic = CollierCompile::pvexotic = "Passarino-Veltman function `1` `2` is not supported by the COLLIER library.";
CollierCodeGenerate::pvargs = CollierCompile::pvargs = "Passarino-Veltman function `1` does not exist; `2` arguments are expected.";
CollierCodeGenerate::pvargx = CollierCompile::pvargx = "Passarino-Veltman function `1` does not exist.";
CollierCodeGenerate::pvinds = CollierCompile::pvinds = "The indices of Passarino-Veltman function `1` should be non-negative machine integers.";

CollierCodeGenerate::cbset = CollierCompile::cbset = "Code block contains `1`, which is an assignment to `2`; only assignments to symbols are allowed.";
CollierCodeGenerate::argset = CollierCompile::argset = Compile::argset;

CollierCodeGenerate::unks = CollierCompile::unks = "While generating code, `1`, was encountered which is a `2`; no `2`s are supported.";
(*DOC*)CollierCodeGenerate::unksymb = CollierCompile::unksymb = "An unknown `1`, `2`, was found when generating code.";

CollierCodeGenerate::optlr = CollierCompile::optlr = "Value of option `1`->`2` is not a list of rules.";
CollierCodeGenerate::optnlr = CollierCompile::optnlr = "Value of option `1`->`2` contains `3`, which is not a rule.";
CollierCodeGenerate::optnlrs = CollierCompile::optnlrs = "Value of option `1`->`2` contains `3`, which is not a rule for a symbol.";
CollierCodeGenerate::optdup = CollierCompile::optdup = "Value of option `1`->`2` has a duplicate rule for `3`.";

CollierCodeGenerate::optnlrst = "Value of option `1` \[Rule] `2` contains a rule to convert `3` to `4`, which is not a string.";

CollierCodeGenerate::optcal = CollierCompile::optcal = "Value of option `1`->`2` contains a constant declaration for `3`, `4`, which is illegal.";
CollierCodeGenerate::optcnum = CollierCompile::optcnum = "Value of option `1`->`2` declares `3` to `4`, which is not a machine-sized real or complex number.";

CollierCompile::maxrank = "Warning: value of global CollierLink option \"MaxRank\"->`1` is too low to evaluate the generated CollierCompiledFunction; set MaxRank to at least `2`.";
CollierCompiledFunction::maxrank = "Value of global CollierLink option \"MaxRank\"->`1` is too low; set \"MaxRank\" to at least `2` to evaluate CollierCompiledFunction.";
CollierCompiledFunction::maxden = CollierCompile::maxden = "The input contains Passarino-Veltman functions with more than `1` denominator factors and an evaluatable compiled function cannot be created.";

CollierCodeGenerate::lang = "Language specification `1` is not \"Fortran\", \"C\" or \"C++\".";
CollierCodeGenerate::caseins = "Variable names `1` and `2` are indistiguishable in Fortran.  Choose a different set of variables, or set option \"VariableNames\" \[Rule] Automatic.";
CollierCodeGenerate::vnms = "VariableNames specification `1` is not Automatic, Verbatim, or a length\[Hyphen]three list of Automatic or Verbatim.";
CollierCodeGenerate::lvnstr = "Value of option `1` is not a string or an expression that evaluates to a string.";
CollierCodeGenerate::lvname = "\"`1`\" is not a valid `2` variable/function name.";


SetAttributes[checkCodeGenerateInputCommon,HoldAll];
(*Options[checkCodeGenerateInputCommon]:=Union[Options[CollierCompile],Options[CollierCodeGenerate]];*)
checkCodeGenerateInputCommon[activeCodeGen_, inputVars_,expr_, opts:OptionsPattern[{CollierCompile,CollierCodeGenerate}]] := 
(
  (*First argument must be a list of symbols only, without duplicates*)
  If[!MatchQ[Unevaluated[inputVars],{___Symbol}],
	If[Head[Unevaluated[inputVars]]=!=List,
	  Message[activeCodeGen::parlist,HoldForm[inputVars]],
	  Message[activeCodeGen::lpar,HoldForm[inputVars],First@Cases[Unevaluated[inputVars],e:Except[_Symbol]:>HoldForm[e],1,1]]
	];
	Throw[$Failed,"CollierCodeGenerate"]
  ];
  If[!DuplicateFreeQ[inputVars],Message[activeCodeGen::fdup,First@Cases[Tally[inputVars],{var_,Except[1]}:>var,1,1],inputVars];Throw[$Failed,"CollierCodeGenerate"]];

  (*OptionValue[Constants]*)
  If[!(MatchQ[OptionValue[Constants], {((Rule|RuleDelayed)[Except[Alternatives@@inputVars,_Symbol],_?NumberQ])...}] && DuplicateFreeQ[OptionValue[Constants][[All,1]]]),
	If[!MatchQ[OptionValue[Constants], _List], Message[activeCodeGen::optlr,Constants,OptionValue[Constants]],
	  With[{badForm=Cases[OptionValue[Constants],Except[((Rule|RuleDelayed)[Except[Alternatives@@inputVars,_Symbol],_?NumberQ])],{1},1]},
		If[badForm=!={},
		  Switch[First@badForm,
			Except[_Rule|_RuleDelayed], Message[activeCodeGen::optnlr,Constants, OptionValue[Constants], First@badForm],
			Except[(Rule|RuleDelayed)[_Symbol,_]], Message[activeCodeGen::optnlrs, Constants, OptionValue[Constants], First@badForm],
			Except[(Rule|RuleDelayed)[Except[Alternatives@@inputVars,_Symbol],_]], Message[activeCodeGen::optcal, Constants, OptionValue[Constants], First[First@badForm], "an argument"],
			_, Message[activeCodeGen::optcnum, Constants, OptionValue[Constants], First[First@badForm], Last[First@badForm]]
		  ],
		  Message[activeCodeGen::optdup, Constants, OptionValue[Constants], First@Cases[Tally[OptionValue[Constants][[All,1]]],{cvar_,Except[1]}:>cvar,1,1]]
		]
	  ]
	];
	Throw[$Failed,"CollierCodeGenerate"]
  ];

  (*OptionValue["InlineExternalDefinitions"], OptionValue["ExpressionOptimization"], and OptionValue["UseCacheSystem"]*)
  If[!MemberQ[{True,False},OptionValue["InlineExternalDefinitions"]],Message[activeCodeGen::opttf, "\"InlineExternalDefinitions\"", OptionValue["InlineExternalDefinitions"]];Throw[$Failed,"CollierCodeGenerate"]];
  If[!MemberQ[{True,False,Automatic},OptionValue["ExpressionOptimization"]],Message[activeCodeGen::opttfa, "\"ExpressionOptimization\"", OptionValue["ExpressionOptimization"]];Throw[$Failed,"CollierCodeGenerate"]];

  (*Correctly constructed Scoping constructs Block and Module in body*)
  If[Head[Unevaluated[expr]]=!=Experimental`OptimizedExpression && !FreeQ[Unevaluated[expr],_Module|_Block],
	With[{scope=Cases[Unevaluated[expr],s:_Module|_Block:>Hold[s],{0,Infinity},Heads->True]},
	  Check[ReleaseHold[Replace[ReplacePart[#,{1,2}:>Null],Set:>SetDelayed,{4},Heads->True]]& /@ scope,Throw[$Failed,"CollierCodeGenerate"]]
	]
  ]
  
);


SetAttributes[msgBadPV,HoldRest];
msgBadPV[activeCodeGen_, expr:(pv:PVA|PVB|PVC|PVD|PVX)[args___]]:=
Which[
  !FreeQ[Hold[args],HoldPattern[Dimensions->_]],Message[activeCodeGen::pvexotic,HoldForm[expr],"defined away from 4 dimensions"],
  !FreeQ[Hold[args],HoldPattern[Weights->_List]],Message[activeCodeGen::pvexotic,HoldForm[expr],"with weights"],
  True, Switch[pv,
	PVA, Which[Length[Hold[args]]!=2, Message[activeCodeGen::pvargs,HoldForm[expr],2],
		  !MatchQ[Hold[args][[1;;1]],Hold[__Integer]], Message[activeCodeGen::pvinds,HoldForm[expr]],
		  True,Message[activeCodeGen::pvexotic,HoldForm[expr],"with negative indices"]],
	PVB, Which[Length[Hold[args]]!=5, Message[activeCodeGen::pvargs,HoldForm[expr],5],
		  !MatchQ[Hold[args][[1;;2]],Hold[__Integer]], Message[activeCodeGen::pvinds,HoldForm[expr]],
		  True,Message[activeCodeGen::pvexotic,HoldForm[expr],"with negative indices"]],
	PVC, Which[Length[Hold[args]]!=9, Message[activeCodeGen::pvargs,HoldForm[expr],9],
		  !MatchQ[Hold[args][[1;;3]],Hold[__Integer]], Message[activeCodeGen::pvinds,HoldForm[expr]],
		  True,Message[activeCodeGen::pvexotic,HoldForm[expr],"with negative indices"]],
	PVD, Which[Length[Hold[args]]!=14, Message[activeCodeGen::pvargs,HoldForm[expr],14],
		  !MatchQ[Hold[args][[1;;4]],Hold[__Integer]], Message[activeCodeGen::pvinds,HoldForm[expr]],
		  True,Message[activeCodeGen::pvexotic,HoldForm[expr],"with negative indices"]],
	PVX, With[{numDenom=(-3+Sqrt[9+8*Length[Hold[args]]])/2},
		  Which[!IntegerQ[numDenom], Message[activeCodeGen::pvargx,HoldForm[expr]],
		   !MatchQ[Hold[args][[1;;numDenom]],Hold[__Integer]], Message[activeCodeGen::pvinds,HoldForm[expr]],
		   True,Message[activeCodeGen::pvexotic,HoldForm[expr],"with negative indices"]
		  ]]
  ]
];

SetAttributes[msgBadSet,HoldRest];
msgBadSet[activeCodeGen_,badSet_,inputVars_]:=
Which[
  Part[Unevaluated[badSet],1,0]=!=Symbol, Message[activeCodeGen::cbset,HoldForm[badSet],Part[Unevaluated[badSet],1,0]],
  MemberQ[inputVars,Part[Unevaluated[badSet],1]], Message[activeCodeGen::argset,Part[Unevaluated[badSet],1]]
];

SetAttributes[msgBadFunc,HoldRest];
msgBadFunc[activeCodeGen_,badFunc_] :=
Switch[
  badFunc,
	Do|While|For|Table|Return|Break|Continue|Goto|Label|Throw|Check|Abort|Interrupt|CheckAbort|AbortProtect, Message[activeCodeGen::unks,HoldForm[badFunc],"flow control statement"],
	If|Which|Switch|Equal|Unequal|Greater|Less|GreaterEqual|LessEqual, Message[activeCodeGen::unks,HoldForm[badFunc],"conditional statement"],
	Print|Echo|Input|InputString|Beep|EmitSound|Import|Export, Message[activeCodeGen::unks,HoldForm[badFunc],"standard input/output statement"],
	_Symbol?(MemberQ[Attributes[#],NumericFunction]&), Message[activeCodeGen::unksymb,"function",HoldForm[badFunc]],
	_,Message[activeCodeGen::unksymb,"code element",HoldForm[badFunc]]
];

SetAttributes[msgBadSymb,HoldRest];
msgBadSymb[activeCodeGen_,badSymb_] :=
Switch[
  badSymb,
	Eps, Message[activeCodeGen::epsdep,Eps],
	Dim, Message[activeCodeGen::dimdep,Dim],
	_, Message[activeCodeGen::unksymb,"symbol",HoldForm[badSymb]]
];


(* ::Subsection:: *)
(*Code generator*)


(* ::Subsubsection::Closed:: *)
(*Code block processing functions*)


preprocessCodeBlock[expr_, optExprOptimization_] := 
  If[TrueQ[optExprOptimization] || (optExprOptimization===Automatic && !MatchQ[Head[Unevaluated[expr]],Block|Module|CompoundExpression|Experimental`OptimizedExpression]),
	If[Head[Unevaluated[expr]]===Experimental`OptimizedExpression,
	  {Hold@@(Experimental`OptimizeExpression[Unevaluated[#], "OptimizationLevel"->2, "OptimizationSymbol"->Compile`optVar]& @@ expr), True},
	  {Hold@@Experimental`OptimizeExpression[Unevaluated[expr], "OptimizationLevel"->2, "OptimizationSymbol"->Compile`optVar], True}
	]
	,
	If[Head[Unevaluated[expr]]===Experimental`OptimizedExpression,
	  {Hold@@Unevaluated[expr], True},
	  {Hold@expr, False}
	]
  ];


getLocalVarsAndInstructionlines[heldExpr_] :=
  Reap[ReplaceRepeated[heldExpr,
	{Hold[CompoundExpression[statements__]]:>(Sow[Hold[],"LocalVariables"];Hold[statements]),
	 Hold[(Block|Module)[{lvs___},CompoundExpression[statements__]]]:>(Sow[Hold[lvs],"LocalVariables"];Hold[statements]),
	 Hold[(Block|Module)[{lvs___},statements_]]:>(Sow[Hold[lvs],"LocalVariables"];Hold[statements]),
	 Hold[statements_]:>(Sow[Hold[],"LocalVariables"];Hold[statements])
	}
],"LocalVariables",{Join@@#2,Replace[Join@@#2, HoldPattern[(Set|SetDelayed)[lhs_Symbol,rhs_]] :> lhs, 1]}&];


makeInstructionLines[inputVars_, heldLocalVarSpec_, instructionLines_, optimizedExpressionQ_, optInlineRules_] :=
  Replace[
	Join[
	  DeleteCases[heldLocalVarSpec,_Symbol]
	  ,Replace[instructionLines,
		badset: ((Set|SetDelayed)[Except[_Symbol],_]|(Set|SetDelayed)[Alternatives@@inputVars,_]) :> RuleCondition[(msgBadSet[$currentCodeGenerationFunction,badset,inputVars]; Throw[$Failed,"CollierCodeGenerate"])],1]
	  ,If[MatchQ[instructionLines[[-1,0]], Set|SetDelayed], Hold[#]& @ instructionLines[[-1,-1]], Hold[]]
	]
  ,If[optInlineRules,Join@@ToExpression[Names["Global`*"],StandardForm,OwnValues],{}],{1,Infinity},Heads->False];


getAndProcessPVXcalls[instructionLines_] :=
  Module[{newInstructions,pvxCases,maxDenom,pvxList,indexList,denomList,dbList,maxRank,dbCases},

	(*Processes the input by replacing PV functions with PVX[{extInvList},{massSqList},denom_Integer,index_Integer]*)
	(*Along the way, Reaps indices to later determine maxRank, and denominators to later determine maxDenom*)
	(*Reaps list of denominators  *)

	newInstructions = instructionLines /. 
	  {UVDiv[h: PVA|PVB|PVC|PVD|PVX][args___]:>CollierLink`Private`UVDiv[h[args]],
	   Derivative[0,0,1,0,0][UVDiv[PVB|PVX]][args:PatternSequence[_,_,_,_,_]]:>CollierLink`Private`UVDiv[Derivative[0,0,1,0,0][PVB][args]]};

	{newInstructions,{denomList,indexList,pvxList,dbList}} = Reap[newInstructions /. {
	  HoldPattern[(PVA|PVX)[indices_Integer?NonNegative,intMasses_]] :> 
		RuleCondition@Sow[PVXcall[Hold[],Hold[intMasses], Sow[1,"denom"], Sow[{indices},"index"]],"pvx"],
	  HoldPattern[(PVB|PVX)[indices:PatternSequence[_Integer?NonNegative,_Integer?NonNegative],extInv_,intMasses:PatternSequence[_,_]]] :> 
		RuleCondition@Sow[PVXcall[Hold[extInv],Hold[intMasses], Sow[2,"denom"], Sow[{indices},"index"]],"pvx"],
	  HoldPattern[Derivative[0,0,1,0,0][(PVB|PVX)][indices:PatternSequence[_Integer?NonNegative,_Integer?NonNegative],extInv_,intMasses:PatternSequence[_,_]]] :> 
		RuleCondition@Sow[DBcall[Hold[extInv],Hold[intMasses], Sow[2,"denom"], Sow[{indices},"index"]],"db"],
	  HoldPattern[(PVC|PVX)[indices:PatternSequence[_Integer?NonNegative,_Integer?NonNegative,_Integer?NonNegative],extInv:PatternSequence[_,_,_],intMasses:PatternSequence[_,_,_]]] :> 
		RuleCondition@Sow[PVXcall[Hold[extInv],Hold[intMasses], Sow[3,"denom"], Sow[{indices},"index"]],"pvx"],
	  HoldPattern[(PVD|PVX)[indices:PatternSequence[_Integer?NonNegative,_Integer?NonNegative,_Integer?NonNegative,_Integer?NonNegative],extInv:PatternSequence[_,_,_,_,_,_],intMasses:PatternSequence[_,_,_,_]]]:> 
		RuleCondition@Sow[PVXcall[Hold[extInv],Hold[intMasses], Sow[4,"denom"], Sow[{indices},"index"]],"pvx"],
	  HoldPattern[PVX[args___]]:> 
		With[{numDenom=(-3+Sqrt[9+8*Length[Hold[args]]])/2}, With[{indices=Hold[args][[1;;numDenom]],extInv=Hold[args][[1+numDenom;;(-1+numDenom)numDenom/2+numDenom]],intMasses=Hold[args][[-numDenom;;]]}, 
		  Evaluate@(Sow[PVXcall[extInv,intMasses, Sow[numDenom,"denom"], Sow[List@@indices,"index"]],"pvx"])/;MatchQ[indices,Hold[___Integer?NonNegative]]]  /; IntegerQ[numDenom]],
	  HoldPattern[(pv:PVA|PVB|PVC|PVD|PVX)[args___]] :> 
		RuleCondition[(msgBadPV[$currentCodeGenerationFunction,pv[args]];Throw[$Failed,"CollierCodeGenerate"])]
	},{"denom","index","pvx","db"}];

	denomList=Flatten[denomList,1];
	indexList=Flatten[indexList,1];
	pvxList=Flatten[pvxList,1];
	dbList=Flatten[dbList,1];

	maxDenom = Max[denomList,{0}];
	maxRank = Max[2*First[#]+Total[Rest[#]]& /@ indexList,{0}];

	pvxCases = ReplacePart[#,{-1->idxList_}]& /@ DeleteDuplicates[pvxList,(#1[[1;;2]]===#2[[1;;2]])&];
	dbCases = ReplacePart[#,{-1->idxList_}]& /@ DeleteDuplicates[dbList,(#1[[1;;2]]===#2[[1;;2]])&];

	{newInstructions, {maxDenom,maxRank,pvxCases,dbCases}}

  ];


(* ::Subsubsection::Closed:: *)
(*Code generating helpers*)


pvxMassSquare = Replace[#,{0:>0,HoldPattern[Sqrt[m_]|Power[m_,1/2]]:>m,m_:>Power[m,2]},{1}]&;


pvxIdxList[denom_,maxRank_]:=pvxIdxList[denom,maxRank]=
  With[{
	tableArg=Join[{r},Table[n[i],{i,1,denom-2}],If[denom==1,{},{rank-2r-Sum[n[j],{j,1,denom-2}]}]],
	iterators=Join[If[denom==1,{{r,0,Floor[maxRank/2]}},{{rank,0,maxRank},{r,Floor[rank/2],0,-1}}],Table[{n[i],rank-2r-Sum[n[j-1],{j,2,i}],0,-1},{i,1,denom-2}]]},
  Flatten[Table[tableArg,##]&@@iterators,denom-1]];

pvxIdxPosition[indices_List, maxRank_]:=First@First@Position[pvxIdxList[Length[indices],maxRank],indices,1];

dbIdxPosition[{r_,n1_},maxRank_]:=r+(Quotient[maxRank,2]+1)*n1+1;


SetAttributes[{openwrite,writeline,close},HoldFirst];
$indentLevel = 0;
raiseIndentation[n_] := (AddTo[$indentLevel,n];Null);
lowerIndentation[n_] := (SubtractFrom[$indentLevel,n];Null);
openwrite[stream_] := ($indentLevel = 0;stream = {};Null);
writeline[stream_,string_] := (stream = {stream,Map[{ConstantArray[" ",$indentLevel],#,"\n"}&,string,{-1}]};Null);
close[stream_] := ($indentLevel = 0; StringDrop[StringJoin[stream],-1]);


oInsert[list_,val_,pos_]:=Join[val,list][[Ordering@Join[pos,Range@Length@list]]];


SetAttributes[{cNum,cPar,cForm},HoldAllComplete];

(*Parenthesize*)
cPar[x_(*String*)] := "(" <> x <> ")";

(*Leaves*)
cNum[Pi] := "M_PI";  (*<math.h>*)
cNum[E] := "M_E";   (*<math.h>*)
cNum[I] := "CMPLX(0.0,1.0)";
cNum[Eps] := (msgBadSymb[$currentCodeGenerationFunction,Eps];Throw[$Failed,"CollierCodeGenerate"]);
cNum[Dim] := (msgBadSymb[$currentCodeGenerationFunction,Dim];"4.");

cNum[x_String?AtomQ] := x;
cNum[x:(_Real|_Integer)?AtomQ]:=ToString[NumberForm[N[x],16,NumberPadding->{"",""},NumberFormat->(If[(#3==""),#1,#1<>"e"<>#3]&)],OutputForm];
cNum[Complex[x_, y_]?AtomQ]:="CMPLX("<>cNum[x]<>","<>cNum[y]<>")";
cNum[Rational[a_,b_]?AtomQ]:=cPar[cNum[a]<>"/"<>cNum[b]];
cNum[f_Symbol] := (msgBadSymb[$currentCodeGenerationFunction,f];Throw[$Failed,"CollierCodeGenerate"]);

(*Branches*)
cForm[(Set|SetDelayed)[x_String,y_]] := x <> " = " <> cNum[y];

cForm[Times[-1,x_String]] := cPar["-"<>x];

cForm[Conjugate[x_]] := "conj("<> cNum[x] <>")";
cForm[Re[x_]] := "creal("<> cNum[x] <>")";
cForm[Im[x_]] := "cimag("<> cNum[x] <>")";
cForm[Abs[x_]] := "cabs("<> cNum[x] <>")";
cForm[Arg[x_]] := "carg("<> cNum[x] <>")";
cForm[Internal`AbsSquare[x_]] := "cnorm("<> cNum[x] <>")";

(* 
(*C library evaluates on different branch for x>1 than Mathematica*)
cForm[ArcCos[x_]] := "cacos("<> cNum[x] <>")";
cForm[ArcCosh[x_]] := "cacosh("<> cNum[x] <>")";
cForm[ArcSin[x_]] := "casin("<> cNum[x] <>")";
cForm[ArcSinh[x_]] := "casinh("<> cNum[x] <>")";
cForm[ArcTan[x_]] := "catan("<> cNum[x] <>")";
cForm[ArcTanh[x_]] := "catanh("<> cNum[x] <>")";
*)

cForm[Cos[x_]] := "ccos("<> cNum[x] <>")";
cForm[Exp[x_]] := "cexp("<> cNum[x] <>")";
cForm[Log[x_]] := "clog("<> cNum[x] <>")";
cForm[Sin[x_]] := "csin("<> cNum[x] <>")";

cForm[Power[x_,-2]] := cPar["1/csquare(" <> cNum[x] <> ")"];
cForm[Power[x_,-1]] := cPar["1/"<>cPar[cNum[x]]];
cForm[Power[x_,1]] := cPar[cNum[x]];
cForm[Power[x_,2]] := "csquare("<> cNum[x] <>")";
cForm[Power[x_,Rational[1,2]]] := "csqrt" <> cPar[cNum[x]];
cForm[Sqrt[x_]] := "csqrt" <> cPar[cNum[x]];
cForm[Power[x_,Rational[-1,2]]] := cPar["1/csqrt(" <> cNum[x] <> ")"];
cForm[Power[x_,y_]] := "cpow(" <> cNum[x] <> "," <> cNum[y] <> ")";
cForm[Divide[x_,y_]] := cPar[cPar[cNum[x]]<>"/"<>cPar[cNum[y]]];
cForm[Subtract[x_,y_]] := cPar[cPar[cNum[x]]<>"-"<>cPar[cNum[y]]];

cForm[(f: Except[Times|Plus])[___]] := (msgBadFunc[$currentCodeGenerationFunction,f];Throw[$Failed,"CollierCodeGenerate"]);

cForm[Times[factors___]] := cPar[StringJoin@@Riffle[List@@(Replace[Hold[factors],e_:>RuleCondition[cNum[e]],{1}]), "*"]];
cForm[Plus[terms___]] := cPar[StringJoin@@Riffle[List@@(Replace[Hold[terms],e_:>RuleCondition[cNum[e]],{1}]), "+"]];

SetAttributes[makeCString,HoldAllComplete];
makeCString[expr_] := cNum @@ Replace[Hold[expr],e_:>RuleCondition[cForm[e]],{1,-2}];


SetAttributes[{cppNum,cppPar,cppForm},HoldAllComplete];

(*Parenthesize*)
cppPar[x_(*String*)] := "(" <> x <> ")";

(*Leaves*)
cppNum[Pi] := "M_PI";  (*<math>*)
cppNum[E] := "M_E";   (*<math>*)
cppNum[I] := "std::complex<double>(0.0,1.0)";
cppNum[Eps] := (msgBadSymb[$currentCodeGenerationFunction,Eps];Throw[$Failed,"CollierCodeGenerate"]);
cppNum[Dim] := (msgBadSymb[$currentCodeGenerationFunction,Dim];"4.");

cppNum[x_String?AtomQ] := x;
cppNum[x:(_Real|_Integer)?AtomQ]:=ToString[NumberForm[N[x],16,NumberPadding->{"",""},NumberFormat->(If[(#3==""),#1,#1<>"e"<>#3]&)],OutputForm];
cppNum[Complex[x_, y_]?AtomQ]:="std::complex<double>("<>cppNum[x]<>","<>cppNum[y]<>")";
cppNum[Rational[a_,b_]?AtomQ]:=cppPar[cppNum[a]<>"/"<>cppNum[b]];
cppNum[f_Symbol] := (msgBadSymb[$currentCodeGenerationFunction,f];Throw[$Failed,"CollierCodeGenerate"]);

(*Branches*)
cppForm[(Set|SetDelayed)[x_String,y_]] := x <> " = " <> cppNum[y];

cppForm[Times[-1,x_String]] := cppPar["-"<>x];

cppForm[Conjugate[x_]] := "conj("<> cppNum[x] <>")";
cppForm[Re[x_]] := "real("<> cppNum[x] <>")";
cppForm[Im[x_]] := "imag("<> cppNum[x] <>")";
cppForm[Abs[x_]] := "abs("<> cppNum[x] <>")";
cppForm[Arg[x_]] := "arg("<> cppNum[x] <>")";
cppForm[Internal`AbsSquare[x_]] := "norm("<> cppNum[x] <>")";

cppForm[Cos[x_]] := "cos("<> cppNum[x] <>")";
cppForm[Exp[x_]] := "exp("<> cppNum[x] <>")";
cppForm[Log[x_]] := "log("<> cppNum[x] <>")";
cppForm[Sin[x_]] := "sin("<> cppNum[x] <>")";

cppForm[Power[x_,-2]] := cppPar["1/square(" <> cppNum[x] <> ")"];
cppForm[Power[x_,-1]] := cppPar["1/"<>cppPar[cppNum[x]]];
cppForm[Power[x_,1]] := cppPar[cppNum[x]];
cppForm[Power[x_,2]] := "square("<> cppNum[x] <>")";
cppForm[Power[x_,Rational[1,2]]] := "sqrt" <> cppPar[cppNum[x]];
cppForm[Sqrt[x_]] := "sqrt" <> cppPar[cppNum[x]];
cppForm[Power[x_,Rational[-1,2]]] := cppPar["1/sqrt(" <> cppNum[x] <> ")"];
cppForm[Power[x_,y_]] := "pow(" <> cppNum[x] <> "," <> cppNum[y] <> ")";
cppForm[Divide[x_,y_]] := cppPar[cppPar[cppNum[x]]<>"/"<>cppPar[cppNum[y]]];
cppForm[Subtract[x_,y_]] := cppPar[cppPar[cppNum[x]]<>"-"<>cppPar[cppNum[y]]];

cppForm[(f: Except[Times|Plus])[___]] := (msgBadFunc[$currentCodeGenerationFunction,f];Throw[$Failed,"CollierCodeGenerate"]);

cppForm[Times[factors___]] := cppPar[StringJoin@@Riffle[List@@(Replace[Hold[factors],e_:>RuleCondition[cppNum[e]],{1}]), "*"]];
cppForm[Plus[terms___]] := cppPar[StringJoin@@Riffle[List@@(Replace[Hold[terms],e_:>RuleCondition[cppNum[e]],{1}]), "+"]];

SetAttributes[makeCppString,HoldAllComplete];
makeCppString[expr_] := cppNum @@ Replace[Hold[expr],e_:>RuleCondition[cppForm[e]],{1,-2}];


SetAttributes[{fNum,fPar,fForm},HoldAllComplete];

(*Parenthesize*)
fPar[x_(*String*)] := "(" <> x <> ")";

(*Leaves*)
fNum[x_String?AtomQ] := x;
fNum[x:(_Real|_Integer)?AtomQ]:=ToString[NumberForm[N[x],16,NumberPadding->{"",""},NumberFormat->(If[(#3==""),#1<>"d0"<>#3,#1<>"d"<>#3]&)],OutputForm];
fNum[Complex[x_, y_]?AtomQ]:="DCMPLX("<>fNum[x]<>","<>fNum[y]<>")";
fNum[Rational[a_,b_]?AtomQ]:=fPar[fNum[a]<>"/"<>fNum[b]];
(*fNum[Pi] := "PI";
fNum[E] := "EE";*)
fNum[I] := "DCMPLX(0d0,1d0)";
fNum[Eps] := (msgBadSymb[CollierCodeGenerate,Eps];Throw[$Failed,"CollierCodeGenerate"]);
fNum[Dim] := (msgBadSymb[CollierCodeGenerate,Dim];"4.");
fNum[f_Symbol] := (msgBadSymb[CollierCodeGenerate,f];Throw[$Failed,"CollierCodeGenerate"]);

fNum[x_String?AtomQ,"DCMPLX"] := x;
fNum[0,"DCMPLX"] := "DCMPLX(0d0,0d0)";
fNum[x:(_Real|_Integer)?AtomQ,"DCMPLX"]:="DCMPLX("<>fNum[x]<>",0d0)";
fNum[Complex[x_, y_]?AtomQ,"DCMPLX"]:="DCMPLX("<>fNum[x]<>","<>fNum[y]<>")";
fNum[Rational[a_,b_]?AtomQ,"DCMPLX"]:=fPar["DCMPLX("<>fNum[a]<>",0d0)/DCMPLX("<>fNum[b]<>",0d0)"];
(*fNum[\[Pi],"DCMPLX"] := "DCMPLX(pi,0d0)";
fNum[E,"DCMPLX"] := "DCMPLX(ee,0d0)";*)
fNum[Eps,"DCMPLX"] := (msgBadSymb[CollierCodeGenerate,Eps];Throw[$Failed,"CollierCodeGenerate"]);
fNum[Dim,"DCMPLX"] := (msgBadSymb[CollierCodeGenerate,Dim];"DCMPLX(4d0,0d0)");
fNum[f_Symbol,"DCMPLX"] := (msgBadSymb[CollierCodeGenerate,f];Throw[$Failed,"CollierCodeGenerate"]);

(*Branches*)
fForm[(Set|SetDelayed)[x_String,y_]] := x <> " = " <> fNum[y];
fForm[Times[-1,x_String]] := fPar["-"<>x];

fForm[Conjugate[x_]] := "DCONJG("<> fNum[x] <>")";
fForm[Re[x_]] := "DREAL("<> fNum[x] <>")";
fForm[Im[x_]] := "DIMAG("<> fNum[x] <>")";
fForm[Abs[x_]] := "CDABS("<> fNum[x] <>")";
fForm[Arg[x_]] := "DATAN2(DREAL("<> fNum[x] <> ")," <> "DIMAG(" <> fNum[x] <> "))";
fForm[Internal`AbsSquare[x_]] := "(CDABS("<> fNum[x] <>")**2)";

fForm[Sin[x_]] := "CDSIN("<> fNum[x] <>")";
fForm[Cos[x_]] := "CDCOS("<> fNum[x] <>")";
fForm[Exp[x_]] := "CDEXP("<> fNum[x] <>")";
fForm[Log[x_]] := "CDLOG("<> fNum[x] <>")";

fForm[Power[x_,-1]] := fPar["1/"<>fPar[fNum[x]]];
fForm[Power[x_,1]] := fPar[fNum[x]];
fForm[Power[x_,y_Integer?Negative]] := fPar[fNum[x] <> "**" <> fPar[ToString[y]]];
fForm[Power[x_,y_Integer]] := fPar[fNum[x] <> "**" <> ToString[y]];
fForm[Power[x_,Rational[1,2]]] := "CDSQRT" <> fPar[fNum[x]];
fForm[Sqrt[x_]] := "CDSQRT" <> fPar[fNum[x]];
fForm[Power[x_,Rational[-1,2]]] := fPar["1/CDSQRT" <> fPar[fNum[x]]];
fForm[Power[x_,y_]] := fPar[fNum[x] <> "**" <> fNum[y]];
fForm[Divide[x_,y_]] := fPar[fPar[fNum[x]]<>"/"<>fPar[fNum[y]]];
fForm[Subtract[x_,y_]] := fPar[fPar[fNum[x]]<>"-"<>fPar[fNum[y]]];

fForm[(f: Except[Times|Plus|List])[___]] := (msgBadFunc[CollierCodeGenerate,f];Throw[$Failed,"CollierCodeGenerate"]);

fForm[Times[factors___]] := fPar[StringJoin@@Riffle[List@@(Replace[Hold[factors],e_:>RuleCondition[fNum[e]],{1}]), "*"]];
fForm[Plus[terms___]] := fPar[StringJoin@@Riffle[List@@(Replace[Hold[terms],e_:>RuleCondition[fNum[e]],{1}]), "+"]];
fForm[List[items___]] := "(/" <> StringJoin@@Riffle[List@@(Replace[Hold[items],e_:>RuleCondition[fNum[e,"DCMPLX"]],{1}]), "+"] <> "/)";

(*fForm[times_Times] := fPar[StringJoin@@Riffle[List@@(fNum/@Unevaluated[times]), "*"]];
fForm[plus_Plus] := fPar[StringJoin@@Riffle[List@@(fNum/@Unevaluated[plus]), "+"]];
fForm[list_List] := "(/" <> StringJoin@@Riffle[(fNum[#,"DCMPLX"]&)/@Unevaluated[list], ","] <> "/)";*)

SetAttributes[makeFortranString,HoldAllComplete];
makeFortranString[expr_] := fNum[#,"DCMPLX"]& @@ Replace[Hold[expr],e_:>RuleCondition[fForm[e]],{1,-2}];


(* ::Subsection:: *)
(*CollierCodeGenerate*)


(* ::Subsubsection::Closed:: *)
(*common*)


stringPadRight[string_,len_,char_]:=FromCharacterCode[PadRight[ToCharacterCode[string],len,ToCharacterCode[char]]];
bannerRow[strings_,width_]:=StringJoin@@(stringPadRight[#,Floor[width/Length[strings]]," "]&/@strings);

pXver=If[#==={},"(???)",First[#]["Version"]]&[PacletManager`PacletFind["X"]];

makeCodeBanner[langName_,functionName_,inputVars_,{},maxDenom_,maxRank_,width_]:=
((StringJoin[If[langName==="Fortran","!!","//"],stringPadRight[#,width-5," "],If[langName==="Fortran","!!","//"]]&)/@
  {
	stringPadRight["",width-5,"*"],
	" This code was automatically created using Package-X v"<>pXver<>" CollierLink ",
	"  routine CollierCodeGenerate[] by Hiren H. Patel, and requires the",
	"  Fortran library COLLIER v"<>$CollierLibraryVersion<>" by A. Denner, S. Dittmaier, L. Hofer",
	"  for numerical evaluation.",
	stringPadRight["",width-5,"-"],
	bannerRow[{"  Language: "<>langName,"Creation date: "<>DateString[{"MonthNameShort","-","Day","-","Year"," ","Hour",":","Minute"}]},width-5],
	bannerRow[{"  Function name: "<>functionName,"Arguments ("<>ToString[Length[inputVars]]<>"): {"<>StringJoin@@Riffle[SymbolName/@inputVars,","]<>"}"},width-5],
	"  Author: "<>$UserName,
	"  Initialization requirement: "<>If[langName==="Fortran","Init_cll","__collier_init_MOD_init_cll"]<>"("<>ToString[maxDenom]<>","<>ToString[maxRank]<>",'')",
	stringPadRight["",width-5,"*"]
  });

makeCodeBanner[langName_,functionName_,inputVars_,externals_,maxDenom_,maxRank_,width_]:=
((StringJoin[If[langName==="Fortran","!!","//"],stringPadRight[#,width-5," "],If[langName==="Fortran","!!","//"]]&)/@
  {
	stringPadRight["",width-5,"*"],
	" This code was automatically created using Package-X v"<>pXver<>" CollierLink ",
	"  routine CollierCodeGenerate[] by Hiren H. Patel, and requires the",
	"  Fortran library COLLIER v"<>$CollierLibraryVersion<>" by A. Denner, S. Dittmaier, L. Hofer",
	"  for numerical evaluation.",
	stringPadRight["",width-5,"-"],
	bannerRow[{"  Language: "<>langName,"Creation date: "<>DateString[{"MonthNameShort","-","Day","-","Year"," ","Hour",":","Minute"}]},width-5],
	bannerRow[{"  Function name: "<>functionName,"Arguments ("<>ToString[Length[inputVars]]<>"): {"<>StringJoin@@Riffle[SymbolName/@inputVars,","]<>"}"},width-5],
	"  Author: "<>$UserName,
	"  Minimum initialization requirement: "<>If[langName==="Fortran","Init_cll","__collier_init_MOD_init_cll"]<>"("<>ToString[maxDenom]<>","<>ToString[maxRank]<>",'')",
	stringPadRight["",width-5,"-"],
	"  Required external definitions: ",
	Sequence@@StringSplit["    "<>StringReplace[ToString[externals,InputForm,PageWidth->(width-20)],{"\""|"{"|"}"->"","\n"->"\n    "}],"\n"],
	stringPadRight["",width-5,"*"]
  });


makePVXcomment = Switch[Length[#[[2]]],1,"PVA[",2,"PVB[",3,"PVC[",4,"PVD[",_,"PVX["]<>
  StringReplace[Riffle[ConstantArray["_",Length[#[[2]]]],","]<>","
  <>If[Length[#[[1]]]>0,StringJoin@@Riffle[List@@Replace[#[[1]],arg_:>RuleCondition[ToString[arg,InputForm]],{1}],","]<>",",""]<>
  StringJoin@@Riffle[List@@Replace[#[[2]],arg_:>RuleCondition[ToString[arg,InputForm]],{1}],","]," ":>""]<>"]"&;

makeDBcomment = "PVB'["<>
  StringReplace[Riffle[ConstantArray["_",Length[#[[2]]]],","]<>","
  <>If[Length[#[[1]]]>0,StringJoin@@Riffle[List@@Replace[#[[1]],arg_:>RuleCondition[ToString[arg,InputForm]],{1}],","]<>",",""]<>
  StringJoin@@Riffle[List@@Replace[#[[2]],arg_:>RuleCondition[ToString[arg,InputForm]],{1}],","]," ":>""]<>"]"&;


makeVariableNames[inputVars_, localVars_, constVars_, optVarNames_] :=
  Module[{autoInputVarNames,autoLocalVarNames,autoConstVarNames,inputVarNames,localVarNames,constVarNames},
	{autoInputVarNames,autoLocalVarNames,autoConstVarNames} = Which[
	  optVarNames===Automatic, {True,True,True},
	  optVarNames===Verbatim, {False,False,False},
	  True, PadRight[Switch[#,Automatic,True,_,False]&/@optVarNames,3,True]
	];

	inputVarNames = If[autoInputVarNames,("inputVar"<>ToString[#]&) /@ Range[Length[inputVars]],SymbolName /@ inputVars];
	localVarNames = If[autoLocalVarNames,("localVar"<>ToString[#]&) /@ Range[Length[localVars]],SymbolName /@ localVars];
	constVarNames = If[autoConstVarNames,("constVar"<>ToString[#]&) /@ Range[Length[constVars]],SymbolName /@ constVars];

	{{autoInputVarNames,autoLocalVarNames,autoConstVarNames},{inputVarNames,localVarNames,constVarNames}}

];

validVariableNameQ[name_,"Fortran"] := StringMatchQ[name,(*LetterCharacter~~((WordCharacter|"_")...)*)RegularExpression["(?i)[a-z]([a-z0-9_]{0,30})"]];
validVariableNameQ[name_,"C"|"C++"] := StringMatchQ[name,(*(LetterCharacter|"_")~~((WordCharacter|"_")...)*)RegularExpression["(?i)[a-z]([a-z0-9_]*)"]];


insertLineBreaks[line_,_,Infinity] := line;
insertLineBreaks[line_(*String*),"Fortran",length_(*Integer*)] := StringInsert[line,"&\n&",Range[length,StringLength[line],length]];
insertLineBreaks[line_(*String*),"C"|"C++",length_(*Integer*)] := StringInsert[line,"\\\n",Range[length,StringLength[line],length]];


(* ::Subsubsection::Closed:: *)
(*generateCollierCppCode*)


generateCollierCppCode[inputVars_,localVars_,instructionLines_,{maxDenom_,maxRank_,pvxCases_,dbCases_},functionName_,opts:OptionsPattern[CollierCodeGenerate]] :=
Module[{stream,instructions,maxLineLength,
		autoInputVarNames,inputVarNames,
		autoLocalVarNames,localVarNames,
		autoConstVarNames,constVarNames,
		varsToCodeVars,
		pvCalcCode,pvCalcPosition,
		cppPVXcases,cppPVXuvrules,cppPVXrules,
		cppDBcases,cppDBuvrules,cppDBrules},

  maxLineLength=If[OptionValue["MaxCharactersPerLine"]===Automatic, Infinity, OptionValue["MaxCharactersPerLine"]];

  Internal`InheritedBlock[{cppForm,cppNum},

	Do[
	  (PrependTo[DownValues[cppForm],HoldPattern[cppForm[#1[args___]]]:>#2<>cPar[StringJoin@@Riffle[cppNum/@(List@@Unevaluated[{args}]), ","]]]&)@@(OptionValue["Externals"][[i]]);
	  (PrependTo[DownValues[cppNum],HoldPattern[cppNum[#1]]:>#2]&)@@(OptionValue["Externals"][[i]]);
	,{i,1,Length[OptionValue["Externals"]]}
	];

	{{autoInputVarNames,autoLocalVarNames,autoConstVarNames},
	 {inputVarNames,localVarNames,constVarNames}}=makeVariableNames[inputVars, localVars, OptionValue[Constants][[All,1]], OptionValue["VariableNames"]];

	(*Check if names are valid*)
	(If[!validVariableNameQ[#,"C"],Message[CollierCodeGenerate::lvname,#,"C"];Throw[$Failed,"CollierCodeGenerate"]]&)/@(Join@@Pick[{inputVarNames,localVarNames,constVarNames,OptionValue["Externals"][[All,2]],{functionName}},{autoInputVarNames,autoLocalVarNames,autoConstVarNames,False,False},False]);

	varsToCodeVars = 
	  Join[
		MapThread[Rule,{inputVars,inputVarNames}],
		MapThread[Rule,{localVars,localVarNames}],
		MapThread[Rule,{OptionValue[Constants][[All,1]],constVarNames}]
	  ];

	cppPVXuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("pvx"<>ToString[First[#2]]<>"uv["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];
	cppPVXrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("pvx"<>ToString[First[#2]]<>"["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];

	cppDBuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("db"<>ToString[First[#2]]<>"uv["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];
	cppDBrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("db"<>ToString[First[#2]]<>"["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];

	cppPVXcases = Replace[pvxCases, PVXcall[heldExtInv_,heldIntMass_,rest__] :> PVXcall[List[ReleaseHold[(makeCppString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCppString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];
	cppDBcases = Replace[dbCases, DBcall[heldExtInv_,heldIntMass_,rest__] :> DBcall[List[ReleaseHold[(makeCppString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCppString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];

	instructions = instructionLines;

	(*Begin writing code here*)

	openwrite[stream];

	writeline[stream,makeCodeBanner[OptionValue["Language"],functionName,inputVars,OptionValue["Externals"][[All,2]],maxDenom,maxRank,80]];

	writeline[stream,""];

	writeline[stream,"#include \"collier.h\"     //  Found in "<>FileNameJoin[{"CollierLink","LibraryResources",""}]];
	writeline[stream, OptionValue["PreambleLines"]];

	writeline[stream,""];

	writeline[stream,"std::complex<double> "<>functionName<>"("];
	raiseIndentation[2];
	If[autoInputVarNames,
	  Do[writeline[stream,StringJoin["std::complex<double> ",inputVarNames[[i]],If[i==Length[inputVarNames],"  ",", "],"// ",SymbolName[inputVars[[i]]]]],{i,1,Length[inputVarNames]}],
	  Do[writeline[stream,StringJoin["std::complex<double> ",inputVarNames[[i]],If[i==Length[inputVarNames],"",","]]],{i,1,Length[inputVarNames]}]
	];
	lowerIndentation[2];
	writeline[stream,"){"];
	
	writeline[stream,""];

	raiseIndentation[4];

	If[Length[cppPVXcases]+Length[cppDBcases]>0,
	  writeline[stream,"//Allocate memory for arguments of TN_cll calls:"];
	  writeline[stream,"//  Arrays of Passarino-Veltman coefficient functions and their UV divergent parts,"];
	  writeline[stream,"//  input kinematic variables, number of denominator factors, and tensor rank"];
	  Do[
		With[{numCoeffsString=ToString@Length[pvxIdxList[cppPVXcases[[i,-2]],maxRank]]},
		  writeline[stream,"static std::complex<double> pvx"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", pvx"<>ToString[i]<>"uv["<>numCoeffsString<>"];" <> "  // " <> makePVXcomment[pvxCases[[i]]]]
		];
		writeline[stream,"static std::complex<double> "<>
		  If[Length[cppPVXcases[[i,1]]]>0,"extInv"<>ToString[i]<>"["<>ToString[Length[cppPVXcases[[i,1]]]]<>"],",""]<>
		  "massSq"<>ToString[i]<>"["<>ToString[cppPVXcases[[i,3]]]<>"];"];
		writeline[stream,"static const int den"<>ToString[i]<>" = "<>ToString[cppPVXcases[[i,3]]]<>";"];
	  ,{i,1,Length[cppPVXcases]}];

	  Do[
		With[{numCoeffsString=ToString[(1+Quotient[maxRank,2]) (1+maxRank)]},
		  writeline[stream,"static std::complex<double> db"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", db"<>ToString[i]<>"uv["<>numCoeffsString<>"];" <> " // " <> makeDBcomment[dbCases[[i]]]];
	    ];
		writeline[stream,"static std::complex<double> "<>
		  If[Length[cppDBcases[[i,1]]]>0,"extInvDB"<>ToString[i]<>"["<>ToString[Length[cppDBcases[[i,1]]]]<>"],",""]<>
		  "massSqDB"<>ToString[i]<>"["<>ToString[cppDBcases[[i,3]]]<>"];"];
	  ,{i,1,Length[cppDBcases]}];

	  writeline[stream,"static const int maxRank = "<>ToString[maxRank]<>";"];
	];

	writeline[stream,""];
	writeline[stream,"//Return variable"];
	writeline[stream,"static std::complex<double> result;"];

	If[Length[localVars]>0,
	  writeline[stream,""];
	  writeline[stream,"//Local variables"];
	  If[autoLocalVarNames,
		Do[writeline[stream,"static std::complex<double> "<>localVarNames[[i]]<>";  // "<>SymbolName[localVars[[i]]]],{i,1,Length[localVars]}],
		Do[writeline[stream,"static std::complex<double> "<>localVarNames[[i]]<>";"],{i,1,Length[localVars]}]
	  ]
	];

	If[Length[OptionValue[Constants]]>0,
	  writeline[stream,""];
	  writeline[stream,"//Constants"];
	  If[autoConstVarNames,
		Do[writeline[stream,"static const std::complex<double> "<>constVarNames[[i]]<>" = "<>(cppNum[#]&)@Evaluate[OptionValue[Constants][[i,2]]]<>";  // "<>SymbolName[OptionValue[Constants][[i,1]]]],{i,1,Length[OptionValue[Constants]]}],
		Do[writeline[stream,"static const std::complex<double> "<>constVarNames[[i]]<>" = "<>(cppNum[#]&)@Evaluate[OptionValue[Constants][[i,2]]]<>";"],{i,1,Length[OptionValue[Constants]]}]
	  ]
	];

	writeline[stream,""];
	writeline[stream,"//Evaluation code"];

	pvCalcCode=
	  Table[
		Join[
		  Table["extInv"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cppPVXcases[[i,1,j]] <> ";",{j,1,Length[cppPVXcases[[i,1]]]}],
		  Table["massSq"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cppPVXcases[[i,2,j]] <> ";",{j,1,Length[cppPVXcases[[i,2]]]}],
		  {If[cppPVXcases[[i,3]]==1,
			"__collier_coefs_MOD_t1_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0);",
			"__collier_coefs_MOD_tn_main_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,extInv"<>ToString[i]<>",massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0,0);"
		  ]}
		]
	  ,{i,1,Length[cppPVXcases]}] ~ Join ~
	  Table[
		Join[
		  Table["extInvDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cppDBcases[[i,1,j]] <> ";",{j,1,Length[cppDBcases[[i,1]]]}],
		  Table["massSqDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cppDBcases[[i,2,j]] <> ";",{j,1,Length[cppDBcases[[i,2]]]}],
		  {"__collier_coefs_MOD_db_arrays_cll(db"<>ToString[i]<>",db"<>ToString[i]<>"uv,extInvDB"<>ToString[i]<>",massSqDB"<>ToString[i]<>",&maxRank,0);"}
		]
	  ,{i,1,Length[cppDBcases]}];


	pvCalcPosition = (Position[instructions,#[[1]],{0,Infinity},1]& /@ Join[cppPVXrules,cppDBrules])[[All,1,1]];
	instructions = instructions/.Join[cppPVXuvrules, cppPVXrules, cppDBuvrules, cppDBrules]; (*Slow*)

	instructions = Replace[instructions, varsToCodeVars,{1,Infinity},Heads->False];
	instructions = Replace[instructions, e_ :> RuleCondition[makeCppString[e]]<>";", 1]; (*Slow*)

	instructions=oInsert[instructions,Hold@@pvCalcCode,pvCalcPosition];

	(*Do[
	  writeline[stream, instructions[[i]]]
	,{i,1,Length[instructions]-1}];

	writeline[stream, "result = "<> Last[instructions]];
	writeline[stream, "return result;"];*)
	
	Do[
	  writeline[stream, insertLineBreaks[#, "C++", maxLineLength]&/@instructions[[i]]]
	,{i,1,Length[instructions]-1}];
	
	writeline[stream, insertLineBreaks["result = "<> Last[instructions], "C++", maxLineLength]];
	writeline[stream, insertLineBreaks["return result;", "C++", maxLineLength]];

	lowerIndentation[4];
	writeline[stream,""];

	writeline[stream, "}"];

	(*writeline[stream,""];*)

	writeline[stream, OptionValue["PostambleLines"]];

	close[stream]

  ]
];


(* ::Subsubsection::Closed:: *)
(*generateCollierCCode*)


generateCollierCCode[inputVars_,localVars_,instructionLines_,{maxDenom_,maxRank_,pvxCases_,dbCases_},functionName_,opts:OptionsPattern[CollierCodeGenerate]] :=
Module[{stream,instructions,maxLineLength,
		autoInputVarNames,inputVarNames,
		autoLocalVarNames,localVarNames,
		autoConstVarNames,constVarNames,
		varsToCodeVars,
		pvCalcCode,pvCalcPosition,
		cPVXcases,cPVXuvrules,cPVXrules,
		cDBcases,cDBuvrules,cDBrules},

  maxLineLength=If[OptionValue["MaxCharactersPerLine"]===Automatic, Infinity, OptionValue["MaxCharactersPerLine"]];

  Internal`InheritedBlock[{cForm,cNum},

	Do[
	  (PrependTo[DownValues[cForm],HoldPattern[cForm[#1[args___]]]:>#2<>cPar[StringJoin@@Riffle[cNum/@(List@@Unevaluated[{args}]), ","]]]&)@@(OptionValue["Externals"][[i]]);
	  (PrependTo[DownValues[cNum],HoldPattern[cNum[#1]]:>#2]&)@@(OptionValue["Externals"][[i]]);
	,{i,1,Length[OptionValue["Externals"]]}
	];

	{{autoInputVarNames,autoLocalVarNames,autoConstVarNames},
	 {inputVarNames,localVarNames,constVarNames}}=makeVariableNames[inputVars, localVars, OptionValue[Constants][[All,1]], OptionValue["VariableNames"]];

	(*Check if names are valid*)
	(If[!validVariableNameQ[#,"C"],Message[CollierCodeGenerate::lvname,#,"C"];Throw[$Failed,"CollierCodeGenerate"]]&)/@(Join@@Pick[{inputVarNames,localVarNames,constVarNames,OptionValue["Externals"][[All,2]],{functionName}},{autoInputVarNames,autoLocalVarNames,autoConstVarNames,False,False},False]);

	varsToCodeVars = 
	  Join[
		MapThread[Rule,{inputVars,inputVarNames}],
		MapThread[Rule,{localVars,localVarNames}],
		MapThread[Rule,{OptionValue[Constants][[All,1]],constVarNames}]
	  ];

	cPVXuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("pvx"<>ToString[First[#2]]<>"uv["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];
	cPVXrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("pvx"<>ToString[First[#2]]<>"["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];

	cDBuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("db"<>ToString[First[#2]]<>"uv["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];
	cDBrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("db"<>ToString[First[#2]]<>"["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];

	cPVXcases = Replace[pvxCases, PVXcall[heldExtInv_,heldIntMass_,rest__] :> PVXcall[List[ReleaseHold[(makeCString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];
	cDBcases = Replace[dbCases, DBcall[heldExtInv_,heldIntMass_,rest__] :> DBcall[List[ReleaseHold[(makeCString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];

	instructions = instructionLines;

	(*Begin writing code here*)

	openwrite[stream];

	writeline[stream,makeCodeBanner[OptionValue["Language"],functionName,inputVars,OptionValue["Externals"][[All,2]],maxDenom,maxRank,80]];

	writeline[stream,""];

	writeline[stream,"#include \"collier.h\"     //  Found in "<>FileNameJoin[{"CollierLink","LibraryResources",""}]];
	writeline[stream, OptionValue["PreambleLines"]];

	writeline[stream,""];

	writeline[stream,"double _Complex "<>functionName<>"("];
	raiseIndentation[2];
	If[autoInputVarNames,
	  Do[writeline[stream,StringJoin["double _Complex ",inputVarNames[[i]],If[i==Length[inputVarNames],"  ",", "],"// ",SymbolName[inputVars[[i]]]]],{i,1,Length[inputVarNames]}],
	  Do[writeline[stream,StringJoin["double _Complex ",inputVarNames[[i]],If[i==Length[inputVarNames],"",","]]],{i,1,Length[inputVarNames]}]
	];
	lowerIndentation[2];
	writeline[stream,"){"];
	
	writeline[stream,""];

	raiseIndentation[4];

	If[Length[cPVXcases]+Length[cDBcases]>0,
	  writeline[stream,"//Allocate memory for arguments of TN_cll calls:"];
	  writeline[stream,"//  Arrays of Passarino-Veltman coefficient functions and their UV divergent parts,"];
	  writeline[stream,"//  input kinematic variables, number of denominator factors, and tensor rank"];
	  Do[
		With[{numCoeffsString=ToString@Length[pvxIdxList[cPVXcases[[i,-2]],maxRank]]},
		  writeline[stream,"static double _Complex pvx"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", pvx"<>ToString[i]<>"uv["<>numCoeffsString<>"];" <> "  // " <> makePVXcomment[pvxCases[[i]]]]
		];
		writeline[stream,"static double _Complex "<>
		  If[Length[cPVXcases[[i,1]]]>0,"extInv"<>ToString[i]<>"["<>ToString[Length[cPVXcases[[i,1]]]]<>"],",""]<>
		  "massSq"<>ToString[i]<>"["<>ToString[cPVXcases[[i,3]]]<>"];"];
		writeline[stream,"static const int den"<>ToString[i]<>" = "<>ToString[cPVXcases[[i,3]]]<>";"];
	  ,{i,1,Length[cPVXcases]}];

	  Do[
		With[{numCoeffsString=ToString[(1+Quotient[maxRank,2]) (1+maxRank)]},
		  writeline[stream,"static double _Complex db"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", db"<>ToString[i]<>"uv["<>numCoeffsString<>"];" <> " // " <> makeDBcomment[dbCases[[i]]]];
	    ];
		writeline[stream,"static double _Complex "<>
		  If[Length[cDBcases[[i,1]]]>0,"extInvDB"<>ToString[i]<>"["<>ToString[Length[cDBcases[[i,1]]]]<>"],",""]<>
		  "massSqDB"<>ToString[i]<>"["<>ToString[cDBcases[[i,3]]]<>"];"];
	  ,{i,1,Length[cDBcases]}];

	  writeline[stream,"static const int maxRank = "<>ToString[maxRank]<>";"];
	];

	writeline[stream,""];
	writeline[stream,"//Return variable"];
	writeline[stream,"static double _Complex result;"];

	If[Length[localVars]>0,
	  writeline[stream,""];
	  writeline[stream,"//Local variables"];
	  If[autoLocalVarNames,
		Do[writeline[stream,"static double _Complex "<>localVarNames[[i]]<>";  // "<>SymbolName[localVars[[i]]]],{i,1,Length[localVars]}],
		Do[writeline[stream,"static double _Complex "<>localVarNames[[i]]<>";"],{i,1,Length[localVars]}]
	  ]
	];

	If[Length[OptionValue[Constants]]>0,
	  writeline[stream,""];
	  writeline[stream,"//Constants"];
	  If[autoConstVarNames,
		Do[writeline[stream,"static const double _Complex "<>constVarNames[[i]]<>" = "<>(cNum[#]&)@Evaluate[OptionValue[Constants][[i,2]]]<>";  // "<>SymbolName[OptionValue[Constants][[i,1]]]],{i,1,Length[OptionValue[Constants]]}],
		Do[writeline[stream,"static const double _Complex "<>constVarNames[[i]]<>" = "<>(cNum[#]&)@Evaluate[OptionValue[Constants][[i,2]]]<>";"],{i,1,Length[OptionValue[Constants]]}]
	  ]
	];

	writeline[stream,""];
	writeline[stream,"//Evaluation code"];

	pvCalcCode=
	  Table[
		Join[
		  Table["extInv"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cPVXcases[[i,1,j]] <> ";",{j,1,Length[cPVXcases[[i,1]]]}],
		  Table["massSq"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cPVXcases[[i,2,j]] <> ";",{j,1,Length[cPVXcases[[i,2]]]}],
		  {If[cPVXcases[[i,3]]==1,
			"__collier_coefs_MOD_t1_checked_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0);",
			"__collier_coefs_MOD_tn_main_checked_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,extInv"<>ToString[i]<>",massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0,0);"
		  ]}
		]
	  ,{i,1,Length[cPVXcases]}] ~ Join ~
	  Table[
		Join[
		  Table["extInvDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cDBcases[[i,1,j]] <> ";",{j,1,Length[cDBcases[[i,1]]]}],
		  Table["massSqDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> cDBcases[[i,2,j]] <> ";",{j,1,Length[cDBcases[[i,2]]]}],
		  {"__collier_coefs_MOD_db_arrays_cll(db"<>ToString[i]<>",db"<>ToString[i]<>"uv,extInvDB"<>ToString[i]<>",massSqDB"<>ToString[i]<>",&maxRank,0);"}
		]
	  ,{i,1,Length[cDBcases]}];


	pvCalcPosition = (Position[instructions,#[[1]],{0,Infinity},1]& /@ Join[cPVXrules,cDBrules])[[All,1,1]];
	instructions = instructions/.Join[cPVXuvrules, cPVXrules, cDBuvrules, cDBrules]; (*Slow*)

	instructions = Replace[instructions, varsToCodeVars,{1,Infinity},Heads->False];
	instructions = Replace[instructions, e_ :> RuleCondition[makeCString[e]]<>";", 1]; (*Slow*)

	instructions=oInsert[instructions,Hold@@pvCalcCode,pvCalcPosition];

	(*Do[
	  writeline[stream, instructions[[i]]]
	,{i,1,Length[instructions]-1}];

	writeline[stream, "result = "<> Last[instructions]];
	writeline[stream, "return result;"];*)
	
	Do[
	  writeline[stream, insertLineBreaks[#, "C", maxLineLength]&/@instructions[[i]]]
	,{i,1,Length[instructions]-1}];
	
	writeline[stream, insertLineBreaks["result = "<> Last[instructions], "C", maxLineLength]];
	writeline[stream, insertLineBreaks["return result;", "C", maxLineLength]];

	lowerIndentation[4];
	writeline[stream,""];

	writeline[stream, "}"];

	(*writeline[stream,""];*)

	writeline[stream, OptionValue["PostambleLines"]];

	close[stream]

  ]
];


(* ::Subsubsection::Closed:: *)
(*generateCollierFortranCode*)


generateCollierFortranCode[inputVars_,localVars_,instructionLines_,{maxDenom_,maxRank_,pvxCases_,dbCases_},functionName_,opts:OptionsPattern[CollierCodeGenerate]] :=
Module[{stream,instructions,maxLineLength,
		autoInputVarNames,inputVarNames,
		autoLocalVarNames,localVarNames,
		autoConstVarNames,constVarNames,
		varsToCodeVars,
		pvCalcCode,pvCalcPosition,
		fortranPVXcases,fortranPVXuvrules,fortranPVXrules,
		fortranDBcases,fortranDBuvrules,fortranDBrules},

  maxLineLength=If[OptionValue["MaxCharactersPerLine"]===Automatic, 110, OptionValue["MaxCharactersPerLine"]];

  Internal`InheritedBlock[{fNum,fForm},

	Do[
	  (PrependTo[DownValues[fForm],HoldPattern[fForm[#1[args___]]]:>#2<>fPar[StringJoin@@Riffle[fNum/@(List@@Unevaluated[{args}]), ","]]]&)@@(OptionValue["Externals"][[i]]);
	  (PrependTo[DownValues[fNum],HoldPattern[fNum[#1]]:>#2]&)@@(OptionValue["Externals"][[i]]);
	,{i,1,Length[OptionValue["Externals"]]}
	];

	{{autoInputVarNames,autoLocalVarNames,autoConstVarNames},
	 {inputVarNames,localVarNames,constVarNames}}=makeVariableNames[inputVars, localVars, OptionValue[Constants][[All,1]], OptionValue["VariableNames"]];

	Function[{listOfNames},
	  (*Check if names are valid*)
	  (If[!validVariableNameQ[#,"Fortran"],Message[CollierCodeGenerate::lvname,#,"Fortran"];Throw[$Failed,"CollierCodeGenerate"]]&)/@listOfNames;
	  (*Check for duplicate variable names due to Fortran case-insensitivity*)
	  If[!DuplicateFreeQ[ToLowerCase/@listOfNames],
		Message[CollierCodeGenerate::caseins,Sequence@@Part[listOfNames,First@Cases[GatherBy[Range@Length[listOfNames],ToLowerCase[listOfNames][[#]]&],{_,__},{1},1]]];
		Throw[$Failed,"CollierCodeGenerate"]
	  ]
	][Join@@Pick[{inputVarNames,localVarNames,constVarNames,OptionValue["Externals"][[All,2]],{functionName}},{autoInputVarNames,autoLocalVarNames,autoConstVarNames,False,False},False]];

	varsToCodeVars = 
	  Join[
		MapThread[Rule,{inputVars,inputVarNames}],
		MapThread[Rule,{localVars,localVarNames}],
		MapThread[Rule,{OptionValue[Constants][[All,1]],constVarNames}]
	  ];

	fortranPVXuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("pvx"<>ToString[First[#2]]<>"uv("<>ToString[pvxIdxPosition[idxList,maxRank]]<>")")]] &, pvxCases];
	fortranPVXrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("pvx"<>ToString[First[#2]]<>"("<>ToString[pvxIdxPosition[idxList,maxRank]]<>")")]] &, pvxCases];

	fortranDBuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("db"<>ToString[First[#2]]<>"uv("<>Riffle[ToString/@idxList,","]<>")")]] &, dbCases];
	fortranDBrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("db"<>ToString[First[#2]]<>"("<>Riffle[ToString/@idxList,","]<>")")]] &, dbCases];

	fortranPVXcases = Replace[pvxCases, PVXcall[heldExtInv_,heldIntMass_,rest__] :> PVXcall[List[ReleaseHold[(makeFortranString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeFortranString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];
	fortranDBcases = Replace[dbCases, DBcall[heldExtInv_,heldIntMass_,rest__] :> DBcall[List[ReleaseHold[(makeFortranString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeFortranString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];

	instructions = instructionLines;

	(*Begin writing code here*)

	openwrite[stream];

	writeline[stream,makeCodeBanner[OptionValue["Language"],functionName,inputVars,OptionValue["Externals"][[All,2]],maxDenom,maxRank,80]];
	writeline[stream,""];

	writeline[stream, OptionValue["PreambleLines"]];

	raiseIndentation[2];

	
	(*writeline[stream,With[{line="DOUBLE COMPLEX FUNCTION "<>functionName<>"("<>StringJoin@Riffle[inputVarNames,", "]<>")"}, StringInsert[line,"&\n&",Range[110,StringLength[line],110]]]];*)
	writeline[stream,insertLineBreaks["DOUBLE COMPLEX FUNCTION "<>functionName<>"("<>StringJoin@Riffle[inputVarNames,", "]<>")", "Fortran", maxLineLength]];

	raiseIndentation[2];

	writeline[stream,""];
	writeline[stream,"USE COLLIER"];
	writeline[stream,"IMPLICIT NONE"];
	writeline[stream,""];

	If[autoInputVarNames,
	  Do[writeline[stream,"DOUBLE COMPLEX, INTENT(IN) :: " <> inputVarNames[[i]] <>"  ! "<>SymbolName[inputVars[[i]]]],{i,1,Length[inputVars]}],
	  Do[writeline[stream,"DOUBLE COMPLEX, INTENT(IN) :: " <> inputVarNames[[i]]],{i,1,Length[inputVars]}]
	];

	If[Length[fortranPVXcases]+Length[fortranDBcases]>0,
	  writeline[stream,""];
	  writeline[stream,"!Allocate memory for calculated results of Passarino-Veltman"];
	  writeline[stream,"!   coefficient functions, and their UV divergent parts"];
	  Do[With[{numCoeffsString=ToString@Length[pvxIdxList[fortranPVXcases[[i,-2]],maxRank]]},
		writeline[stream,"DOUBLE COMPLEX :: pvx"<>ToString[i]<>"("<>numCoeffsString<>")"<>", pvx"<>ToString[i]<>"uv("<>numCoeffsString<>")" <> "  ! " <> makePVXcomment[pvxCases[[i]]]]
	  ],{i,1,Length[fortranPVXcases]}];

	  Do[
		writeline[stream,"DOUBLE COMPLEX :: db"<>ToString[i]<>"(0:"<>ToString[Quotient[maxRank,2]]<>",0:"<>ToString[maxRank]<>")"<>", db"<>ToString[i]<>"uv(0:"<>ToString[Quotient[maxRank,2]]<>",0:"<>ToString[maxRank]<>")" <> "  ! " <> makeDBcomment[dbCases[[i]]]]
	  ,{i,1,Length[fortranDBcases]}]
	];

	If[Length[localVars]>0,
	  writeline[stream,""];
	  writeline[stream, "!Local variables"];
	  If[autoLocalVarNames,
		Do[writeline[stream,"DOUBLE COMPLEX :: "<>localVarNames[[i]]<>"  ! "<>SymbolName[localVars[[i]]]],{i,1,Length[localVars]}],
		Do[writeline[stream,"DOUBLE COMPLEX :: "<>localVarNames[[i]]],{i,1,Length[localVars]}]
	  ]
	];

	If[Length[OptionValue[Constants]]>0,
	  writeline[stream,""];
	  writeline[stream,"!Constants"];
	  If[autoConstVarNames,
		Do[writeline[stream,"DOUBLE COMPLEX, PARAMETER :: "<>constVarNames[[i]]<>" = "<>(fNum[#,"DCMPLX"]&)[Evaluate[OptionValue[Constants][[i,2]]]]<>"  ! "<>SymbolName[OptionValue[Constants][[i,1]]]],{i,1,Length[OptionValue[Constants]]}],
		Do[writeline[stream,"DOUBLE COMPLEX, PARAMETER :: "<>constVarNames[[i]]<>" = "<>(fNum[#,"DCMPLX"]&)[Evaluate[OptionValue[Constants][[i,2]]]]],{i,1,Length[OptionValue[Constants]]}]
	  ]
	];

	writeline[stream,""];
	writeline[stream,"!Evaluation code"];

	
	pvCalcCode=
	  Table[
		If[fortranPVXcases[[i,3]]==1,
		  "CALL TN_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,"<>"(/"<>StringJoin[Riffle[fortranPVXcases[[i,2]],","]]<>"/)"<>",1,"<>ToString[maxRank]<>")",
		  "CALL TN_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,"<>"(/"<>StringJoin[Riffle[fortranPVXcases[[i,1]],","]]<>"/),(/"<>StringJoin[Riffle[fortranPVXcases[[i,2]],","]]<>"/)"<>","<>ToString[fortranPVXcases[[i,3]]]<>","<>ToString[maxRank]<>")"
		]
	  ,{i,1,Length[fortranPVXcases]}] ~Join~
	  Table[
		"CALL DB_cll(db"<>ToString[i]<>",db"<>ToString[i]<>"uv,"<>"(/"<>StringJoin[Riffle[fortranDBcases[[i,1]],","]]<>"/),(/"<>StringJoin[Riffle[fortranDBcases[[i,2]],","]]<>"/)"<>","<>ToString[maxRank]<>")"
	  ,{i,1,Length[fortranDBcases]}];

	pvCalcPosition = (Position[instructions,#[[1]],{0,Infinity},1]& /@ Join[fortranPVXrules,fortranDBrules])[[All,1,1]];
	instructions = instructions/.Join[fortranPVXuvrules,fortranPVXrules,fortranDBuvrules,fortranDBrules]; (*Slow*)

	instructions = Replace[instructions, varsToCodeVars,{1,Infinity},Heads->False];
	instructions = Replace[instructions, e_ :> RuleCondition[makeFortranString[e]], 1]; (*Slow*)

	instructions = oInsert[instructions,Hold@@pvCalcCode,pvCalcPosition];

	(*Do[
	  writeline[stream, With[{line=instructions[[i]]}, StringInsert[line,"&\n&",Range[110,StringLength[line],110]]]]
	,{i,1,Length[instructions]-1}];*)
	
	Do[
	  writeline[stream, insertLineBreaks[instructions[[i]], "Fortran", maxLineLength]]
	,{i,1,Length[instructions]-1}];

	(*writeline[stream, With[{line=functionName<>" = "<> Last[instructions]}, StringInsert[line,"&\n&",Range[110,StringLength[line],110]]]];*)
	writeline[stream, insertLineBreaks[functionName<>" = "<> Last[instructions], "Fortran", maxLineLength]];

	lowerIndentation[2];
	writeline[stream,""];

	writeline[stream, "END FUNCTION"];

	(*writeline[stream,""];*)
	lowerIndentation[2];
	writeline[stream, OptionValue["PostambleLines"]];

	close[stream]

  ]
];


(* ::Subsubsection::Closed:: *)
(*CollierCodeGenerate*)


(*Need to strip away innocuous Weights and Dimensions*)
SetAttributes[CollierCodeGenerate,HoldAll];
CollierCodeGenerate[inputVars_, expr_, opts:OptionsPattern[]] :=
 Catch[CheckAbort[
 ($currentCodeGenerationFunction=CollierCodeGenerate;
  Check[X`Internal`ValidOptionsQ[CollierCodeGenerate] /@ {opts}, Throw[$Failed,"CollierCodeGenerate"]];
  checkCodeGenerateInputCommon[CollierCodeGenerate, inputVars, expr, opts];
  Block[inputVars,
  Module[{functionName,optimizedExpressionQ, heldLocalVarSpec, heldLocalVars, instructionLines, heldExpr, pvxCalls, source},
  Internal`InheritedBlock[{ToString},

	SetOptions[ToString,FormatType->OutputForm];

	functionName=First@First@Last@Reap[checkCollierCodeGenerateOptions[opts],"FunctionName"];

	If[LeafCount[expr]>100000,ccMakeProgressCell[4]];
	incrementProgressCell["Initializing"];

	incrementProgressCell["Processing code block"];
	{heldExpr, optimizedExpressionQ} = preprocessCodeBlock[Unevaluated[expr], OptionValue["ExpressionOptimization"]];
	{instructionLines,{{heldLocalVarSpec, heldLocalVars}}} = getLocalVarsAndInstructionlines[heldExpr];

	(*Check if local variable specification also appears as a constant*)
	With[{dupl=Cases[heldLocalVars,Alternatives@@OptionValue[Constants][[All,1]],{1},1]},
	  If[dupl=!={},Message[CollierCompile::optcal, OptionValue[Constants], First@dupl, "a local variable"]; Throw[$Failed,"CollierCompile"]]
	];
	(*Check if scoping constructs are still present; they are too deep*)
	With[{dScope=Cases[instructionLines,s:_Module|_Block:>Hold[s],{1,Infinity},1,Heads->True]},
	  If[dScope=!={}, Unevaluated[dScope]/.{Hold[scope_]}:>Message[CollierCompile::dscope,HoldForm[scope]]; Throw[$Failed,"CollierCompile"]]
	];

	(*Blocked local variables*)
	Replace[heldLocalVars, Hold[lvars___] :> 
	Block[List[lvars],
	  
	  instructionLines = makeInstructionLines[inputVars, heldLocalVarSpec, instructionLines, optimizedExpressionQ, OptionValue["InlineExternalDefinitions"]];

	  incrementProgressCell["Processing "<> ToString[Count[instructionLines,_PVA|_PVB|_PVC|_PVD|_PVX,{0,Infinity}]] <>" PV functions"];
	  {instructionLines, pvxCalls} = getAndProcessPVXcalls[instructionLines]; (*{instructionLines, {maxDenom,maxRank,pvxCases,dbCases}}*)

	  incrementProgressCell["Creating code"];

	  Switch[OptionValue["Language"],
		"Fortran",source = generateCollierFortranCode[inputVars, List@@heldLocalVars, instructionLines, pvxCalls, functionName, opts],
		"C",source = generateCollierCCode[inputVars, List@@heldLocalVars, instructionLines, pvxCalls, functionName, opts],
		"C++",source = generateCollierCppCode[inputVars, List@@heldLocalVars, instructionLines, pvxCalls, functionName, opts]
	  ]
	]];

	Throw[source,"CollierCodeGenerate"];
	Null

  ]]]
),Throw[$Failed,"CollierCodeGenerate"]],"CollierCodeGenerate",(ccDestroyProgressCell[];#1)&];

LHS_CollierCodeGenerate:=RuleCondition[X`Internal`CheckArgumentCount[LHS,2,2];Fail];


checkCollierCodeGenerateOptions[opts:OptionsPattern[CollierCodeGenerate]] := 
(
  If[!MatchQ[OptionValue["VariableNames"],Automatic|Verbatim|{Automatic|Verbatim,Automatic|Verbatim,Automatic|Verbatim}],Message[CollierCodeGenerate::vnms,OptionValue["VariableNames"]];Throw[$Failed,"CollierCodeGenerate"]];
  If[!MemberQ[{"Fortran","C","C++"},OptionValue["Language"]],Message[CollierCodeGenerate::lang,OptionValue["Language"]];Throw[$Failed,"CollierCodeGenerate"]];

  If[!MatchQ[OptionValue["MaxCharactersPerLine"],Automatic|Infinity] && !MatchQ[OptionValue["MaxCharactersPerLine"],_Integer?Positive], Message[CollierCodeGenerate::ioppfa,"MaxCharactersPerLine",OptionValue["MaxCharactersPerLine"]];Throw[$Failed,"CollierCodeGenerate"]];

  If[Head[Sow[OptionValue["FunctionName"],"FunctionName"]]=!=String,Message[CollierCodeGenerate::lvnstr,First[Cases[opts,(Rule|RuleDelayed)["FunctionName",_],{0,1},1]]];Throw[$Failed,"CollierCodeGenerate"]];

  (*OptionValue["Externals"]*)
  If[!(MatchQ[OptionValue["Externals"], {((Rule|RuleDelayed)[_Symbol,_String])...}] && DuplicateFreeQ[OptionValue["Externals"][[All,1]]]),
	If[!MatchQ[OptionValue["Externals"], _List], Message[CollierCodeGenerate::optlr,"Externals",OptionValue["Externals"]],
	  With[{badForm=Cases[OptionValue["Externals"],Except[((Rule|RuleDelayed)[_Symbol,_String])],{1},1]},
		If[badForm=!={},
		  Switch[First@badForm,
			Except[_Rule|_RuleDelayed], Message[CollierCodeGenerate::optnlr, "Externals", OptionValue["Externals"], First@badForm],
			Except[(Rule|RuleDelayed)[_Symbol,_]], Message[CollierCodeGenerate::optnlrs, "Externals", OptionValue["Externals"], First@badForm],
			_, Message[CollierCodeGenerate::optnlrst, "Externals", OptionValue["Externals"], First[First@badForm], Last[First@badForm]]
		  ],
		  Message[CollierCodeGenerate::optdup, "Externals", OptionValue["Externals"], First@Cases[Tally[OptionValue["Externals"][[All,1]]],{cvar_,Except[1]}:>cvar,1,1]]
		]
	  ]
	];
	Throw[$Failed,"CollierCodeGenerate"]
  ];

  If[!MatchQ[OptionValue["PreambleLines"],_String|{_String...}],Message[CollierCodeGenerate::opstl,"PreambleLines",OptionValue["PreambleLines"]];Throw[$Failed,"CollierCodeGenerate"]];
  If[!MatchQ[OptionValue["PostambleLines"],_String|{_String...}],Message[CollierCodeGenerate::opstl,"PostambleLines",OptionValue["PostambleLines"]];Throw[$Failed,"CollierCodeGenerate"]];
);


(* ::Subsection:: *)
(*CollierCompile*)


(* ::Subsubsection::Closed:: *)
(*CollierCompiledFunction*)


SetAttributes[CollierCompiledFunction,HoldAll];

(*Created by Compress[Import["collier-teal.jpg"]]*)
ccfimg = 
  Image[Uncompress@"1:eJztnN1uHEUQRq04SAjxEjwK4QLlNuYFHLSJkEKCHAfku7wLr8M7wQ4ry+vdnZmu7p7ur6rPkWw59v5UfXWmp92W8sPbT2/evby6uvr8zf7T699v3+/evZj++e3+05vbv368u7t9uJke8Orhfvf2ev/FP/uPv/cf0zfBzvXXr/8+fvSuBcYGF6E3xw7iI/QCD0EFHAQV8BBUYF0EFdgrghL4CErw+zQogY+gBj6CEvgISuAiKIGPoAAeggLsF6E3nOuAAngICuAhKICDoAAeggp4CCrgIajAughKsGcEFTjPATVwEpTAx/aQ7zL4eJnaOZBvGrj4nNpZcL3bIKsDW3mDj+mQ0fa+4OMy5HOgVQ7kfRlyOdA6B3J/gvOcJ3rlQP54eEzvHHq/f0/w8AmVHFTqaMmIPU9c6lMtC7V6tmakXo857Vd17qp1bcEIPZ4ytydRzUK9vlp4mkktPPbspc5HcurztkaU4rlXDzXn1JXioIferXjvTbn+lHpKvIvmaIQ+FHto5VgUNz3XfopSH7098+iuQg218JRpTl25vXhwMYJ/p3jysPQ9WtTYIrtoDj7ixUOVrHvXqppLDXpkqrbOWOlVq3ImtWiVa66Dirm3rlk9j1qc9le7by9+WWl1HUXLbY3T/mr1H9HBY7b2MXJ2FkpziO7hI3O9lfY/QnYWcvIYxcFj5nrMzWK0/FKx5DKihymUZtiyVnVS8iHDZVKuUzJMw7JPJ8PLkGE9yLAO5JgP13JdWB/zILf6WDMl27zMetfsgVwXR853LgeyKsPiGxkfsLrYs1ZvWDIk6+X/h2H0bGpgyZC8x/y/GFQZ3cfR+1dj5Fngohajz2Pk3nvDGc9zRu+/B5w3Xmb0/lvD+fcyI/fekjXf8BEXW7Hm2GjrI/eEfuT8DSbSXNif6DCX89wcoswGB/XImYf3GeGfJjlz8T4z7/VHJmdt8DxLz7XDOZ7n6bl2OMfzfc5z7XAZz/PEx1h4niUu+iPy+UeEHkYh+llwlD6iM8rfJaL0ERXrWbf3OUbpIyIps4nk4kSUPqKR46H3OUboISLWvaLnOUboIToW9zzOMdL1FB3L+udtlnjoF+v+sXV9qeDgGKjPFQfHQXm+ODgWqnPGw/FQnTUexmVupqrzxsVYeD9jxMcYRPjbi4caYZkcD1Xn7KlWOGdtbt7m661eeCJlXh7nipP+WJqVt3v0KV7rHpVI+8U5PNc+GtFdnPBc+4iseed1nt6vIzjH4zwjrOlwjrd54mFcPM0UD2PjZa54GB8Ps8VDv6Se2XiZr5c64TmWc0QPM/ZQI5xjPdf2MGMPNcI5qeufp/2XhxrhnLW5efNwwlu9cCBlZt5m63EthwOWPaOXeUbqZSQiuvhIxJ6iE9XFY6L2FRXPZzkWcNEvUWcWta+oRF0/ovYVmagzi9qXJ6x7pYjzwsP+WH+XjDqzqH15IefMJuLMIvbkDesZYtSZRe3LE5Z7cdTzt4g9eWRtBtE9nIjalzdS5hDZw4mofXnEsmeMOK/IvXljZA8nrNdi1ByUGHUGOS5GzkOJEbPHR31Gyx0XNSHzecilHVz/85BNOZb8yPoy3KvLSd33kPEyuFgGvyPWgazKwcM6kFc5rIt1IKtySlwk4wNkNY81A0t2ZPwcy+95o+VV0n/qc0bO95iUHEb1sfQeYXn8iPkeY+l/RB9L9yxbraPRqHXfufTcCFnO9Zd77aY+bjQfS3teyy5ClinX2lKPufuekZys2ae3HGvdY62epdThKccabNGflxxz6ktdG5feo+R1FXOswdZ9qftYw8U579Yeu/Sa1jp751hKq35Uc0zxyeJjSZ+W91uqoSSPXrTso9a8tq5r7ftrzy/py7ImWn+uSI/5564fuXXlzv/0sbmvkdtHyet4Wh97rkOlLpbMw7quzf0st7/aWVmea33vrdli3dmSLbzNnWGOy6WZls5JdbY15tSTVj7OPXbpuVtnaX1d9Rl79vASLdfG2q+/Fer1WWrtXV9Nat/f1GfsqdaUenvWtgUlvXqfa2ofKvX2rqkFNe636pkt1aXWh1o9LYnm3SWW6kx1tHWdc+t3izp6cdp3JAcnUj1MWS9b1ekl29qs9e49n7V1JtfVLWv0mHMNRui/ZH3f2hE8fGKEDEr2GVt6gofPGSWHkv3uFhnh4TlksU7tjPDwMuSxTs2M8HAeMlmnVkZ4uAy5LFPbHfKeh2zWIZ/tSDlvI3toAR6CCrgISuAiqICHoAIughJ4CCrgIiiBi6ACHoIKuAgq4CKogIugAi6CCrgIKuAiqICLoAIuggq4CCrgIqiAi6ACLoIKuAgq4CKogIugAi6CCrgIKuAiqICL9bl5uf/06uF+9+7F/ovP07/efPmw+/zd/oufPn34dHfzx+2vu5vr6fs/vzp50Pf7L15/vN/dfdjd/vnbx/f//+SXuy+7/wDrcuH1",
  ImageSize->If[$VersionNumber<11,25,22]];
topologyName=Switch[#,1,"1 (tadpole)",2,"2 (bubble)",3,"3 (triangle)",4,"4 (box)",5,"5 (pentagon)",6,"6 (hexagon)",7,"7 (heptagon)",8,"8 (octagon)", _, #]&;
fileSizeForm[size_Integer]:=
  Which[size<1000,ToString[size,OutputForm]<>" B",
	size<1000^2,ToString[NumberForm[N[size/1000],{6,2}],OutputForm]<>" kB",
	size<1000^3,ToString[NumberForm[N[size/1000^2],{6,2}],OutputForm]<>" MB",
	True,ToString[NumberForm[N[size/1000^3],{6,2}],OutputForm]<>" GB"
  ];

MakeBoxes[obj: CollierCompiledFunction[data:{_,_,_,_,_,_,_},_LibraryFunction]?AtomQ,fmt_] ^:=
  Condition[Module[{shown,hidden},

	shown=
	  {{BoxForm`MakeSummaryItem[{"Variables ("<>ToString[Length[data[[1]]],OutputForm]<>"): ", Short[data[[1]],3/4]},fmt],SpanFromLeft},
	  {Row[{BoxForm`MakeSummaryItem[{"Denom: ", topologyName[data[[2]]]},fmt],BoxForm`MakeSummaryItem[{"Rank: ", data[[3]]},fmt]},Spacer[5]],SpanFromLeft}};

	hidden=
	  {{BoxForm`MakeSummaryItem[{"TN_cll calls: ", data[[4]]},fmt],BoxForm`MakeSummaryItem[{"cache_no: ", data[[5]]},fmt]},
	   {BoxForm`MakeSummaryItem[{"Code lines: ", data[[6]]},fmt],BoxForm`MakeSummaryItem[{"File size: ", fileSizeForm[data[[7]]]},fmt]}};

	BoxForm`ArrangeSummaryBox[CollierCompiledFunction,obj,ccfimg,shown,hidden,fmt,"Interpretable"->False]
  ],"IconicElidedForms"/.("TypesetOptions"/.SystemOptions[])];

MakeBoxes[CollierCompiledFunction[{args_,_,_,_,_,_,_},_],_] ^:= 
  TagBox[RowBox[{"CollierCompiledFunction","[",RowBox[{MakeBoxes[Short[args,3/4]],",","\"-CompiledCode-\""}],"]"}],False,Editable->False];

Format[CollierCompiledFunction[{args_,_,_,_,_,_,_},_],OutputForm] := "CollierCompiledFunction[" <> ToString[Short[args,3/4],OutputForm] <> "," <>" -CompiledCode- ]";


CollierCompiledFunction[data_List,lib_LibraryFunction][args___?NumericQ] := lib[args] /; Length[data[[1]]]===Length[{args}];


LibraryFunctionInformation[CollierCompiledFunction[{_,_,_,_,_,_,_},lib_LibraryFunction]?AtomQ] ^:= LibraryFunctionInformation[lib];


(* ::Subsubsection::Closed:: *)
(*ccfPreamble*)


ccfPreambleCode=
"#include \"mathlink.h\"
#include <complex.h>
#include \"WolframLibrary.h\"
#include <stdlib.h>

#define M_PI 3.14159265358979323846
#define M_E 2.71828182845904523536

    int GetNmax_cll();
    int Getrmax_cll();

    void InitEvent_cll(mint*);
    //void SwitchOffCacheSystem_cll();
    //void SwitchOnCacheSystem_cll();
    void SwitchOnCache_cll(mint*);
    void SwitchOffCache_cll(mint*);

    void GetRitmax_cll(mint*);

    void GetAccFlag_cll(int*);
    void InitAccFlag_cll();
    
    void GetErrFlag_cll(int*);
    void InitErrFlag_cll();

    void DB_arrays_cll(double _Complex[], double _Complex[], double _Complex[], double _Complex[], const mint*, double[]);
    void T1_checked_cll(double _Complex[], double _Complex[], double _Complex[], const mint*, const mint*, double[], mint*);
    void TN_main_checked_cll(double _Complex[], double _Complex[], double _Complex[], double _Complex[], const mint*, const mint*, double[], mint*, double[]);

double _Complex csquare(double _Complex z) {return z*z;}

double cnorm(double _Complex z)
{
    const double r = creal(z);
    const double i = cimag(z);
    return r*r + i*i;
}

static inline mcomplex to_mcomplex(double _Complex c )
{
    const mcomplex ilist = {creal(c), cimag(c)};
    return ilist;
}

static inline double _Complex to_complex(mcomplex c)
{
    return CMPLX(mcreal(c), mcimag(c));
}
";

ccfMessageHandlerCode = "/************************** COLLIER MESSAGE HANDLER ***************************/

const mcomplex cplxNAN = {0.0/0.0, 0.0/0.0};
int errFlag, accFlag;

void issueRankDenomMessage(WolframLibraryData libData)
{
    // Message[MessageName[CollierCompile,\"maxrank\"],OptionValue[$CollierLink, MaxRank],maxRank]
    int pkt;
    MLINK link = libData->getMathLink(libData);
    MLPutFunction(link, \"EvaluatePacket\", 1);
    MLPutFunction(link, \"Message\", 3);
    MLPutFunction(link, \"MessageName\", 2);
    MLPutSymbol(link, \"CollierCompiledFunction\");

    if (maxDenom>GetNmax_cll()) {
        MLPutString(link, \"maxden\");
        MLPutFunction(link, \"OptionValue\", 2);
        MLPutSymbol(link, \"CollierLink`Private`$CollierLink\");
        MLPutString(link, \"MaxDenominators\");
        MLPutInteger(link, maxDenom);
        
    } else {
        MLPutString(link, \"maxrank\");
        MLPutFunction(link, \"OptionValue\", 2);
        MLPutSymbol(link, \"CollierLink`Private`$CollierLink\");
        MLPutString(link, \"MaxRank\");
        MLPutInteger(link, maxRank);
    }
    
    libData->processMathLink(link);
    pkt = MLNextPacket(link);
    if (pkt == RETURNPKT)
        MLNewPacket(link);
}

void issueErrAccMessage(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res, const char* messageName)
{
    mint ritmax;
    GetRitmax_cll(&ritmax); //used if issuing accuracy message
    
    double kinematicArgs[Argc][2];
    long kinematicArgsDims[2] = {Argc, 2};
    const char* kinematicArgsHeads[2] = {\"List\",\"Complex\"};
    long kinematicArgsDepth = 2;
    int i;
    for (i=0; i<Argc; i++) {
        kinematicArgs[i][0] = mcreal(MArgument_getComplex(Args[i]));
        kinematicArgs[i][1] = mcimag(MArgument_getComplex(Args[i]));
    }
    
    int pkt;
    MLINK link = libData->getMathLink(libData);
    MLPutFunction(link, \"EvaluatePacket\", 1);
    MLPutFunction(link, \"Message\", 3);
    MLPutFunction(link, \"MessageName\", 2);
    MLPutSymbol(link, \"CollierCompiledFunction\");
    MLPutString(link, messageName);
    
    // Chop[{-kinematicArgs-}]
    MLPutFunction(link,\"Chop\",1);
    MLPutRealArray(link, &kinematicArgs[0][0], kinematicArgsDims, kinematicArgsHeads, kinematicArgsDepth);
    //
    MLPutInteger(link, ritmax);
    
    libData->processMathLink(link);
    pkt = MLNextPacket(link);
    if (pkt == RETURNPKT)
        MLNewPacket(link);
}

static inline void errAccFlagCheck(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res)
{
    GetAccFlag_cll(&accFlag);
    GetErrFlag_cll(&errFlag);
    if (errFlag<0 || accFlag<0) {
        const char* messageName;
        if (errFlag<0) {
            if (errFlag==-1) {
                messageName = \"intcheck\";
            } else if (errFlag==-4){
                messageName = \"argcut\";
            } else if (errFlag==-5){
                messageName = \"critevent\";
            } else if (errFlag==-6){
                messageName = \"nored\";
            } else if (errFlag==-7){
                messageName = \"specnum\";
            } else if (errFlag==-9){
                messageName = \"intcons\";
            } else {
                messageName = \"nocase\";
            }
        }
        if (accFlag<0) {
            
            if (accFlag==-1) {
                messageName = \"reqacc\";
            } else {
                messageName = \"critacc\";
            }
        }
        issueErrAccMessage(libData, Argc, Args, Res, messageName);
        if (errFlag <= -9 || accFlag <= -2) {
            MArgument_setComplex(Res, cplxNAN);
        }
    }
    InitAccFlag_cll();
    InitErrFlag_cll();
}";


(* ::Subsubsection::Closed:: *)
(*ccfMakeSource*)


ccfMakeWrapperFunction[data__]:=
  StringReplace[
	ToString[Unevaluated[FullForm[
	  Function[CollierCompiledFunction[Evaluate[List[data]],Slot[1]]]
	]],OutputForm]
  ,{"\\"->"\\\\","\""->"\\\""}];


ccfMakeSource[inputVars_,heldLocalVars_,instructionLines_,{maxDenom_,maxRank_,pvxCases_,dbCases_},functionName_,libFileName_,opts:OptionsPattern[CollierCompile]] :=
  Module[{stream,instructions,varsToCodeVars,pvCalcCode,pvCalcPosition,ccfPVXcases,ccfPVXuvrules,ccfPVXrules,ccfDBcases,ccfDBuvrules,ccfDBrules,useCacheQ=(OptionValue["UseCacheSystem"] && Length[pvxCases]>0)},

	varsToCodeVars = 
	  Join[
		(*Variables of compiled function*)(inputVars[[#]]->("inputVar"<>ToString[#]))& /@ Range[Length[inputVars]],
		(*Localized variables*)(heldLocalVars[[#]]->("localVar"<>ToString[#]))& /@ Range[Length[heldLocalVars]],
		(*Constant variables*)(OptionValue[Constants][[#,1]]->("constVar"<>ToString[#]))& /@ Range[Length[OptionValue[Constants]]]
	  ];

	(*CHANGED HERE*)
	ccfPVXuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("pvx"<>ToString[First[#2]]<>"uv["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];
	ccfPVXrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("pvx"<>ToString[First[#2]]<>"["<>ToString[pvxIdxPosition[idxList,maxRank]-1]<>"]")]] &, pvxCases];

	ccfDBuvrules = MapIndexed[RuleDelayed[HoldPattern[CollierLink`Private`UVDiv[#1]], RuleCondition[("db"<>ToString[First[#2]]<>"uv["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];
	ccfDBrules = MapIndexed[RuleDelayed[HoldPattern[#1], RuleCondition[("db"<>ToString[First[#2]]<>"["<>ToString[dbIdxPosition[idxList,maxRank]-1]<>"]")]] &, dbCases];

    ccfPVXcases = Replace[pvxCases, PVXcall[heldExtInv_,heldIntMass_,rest__] :> PVXcall[List[ReleaseHold[(makeCString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];
	ccfDBcases = Replace[dbCases, DBcall[heldExtInv_,heldIntMass_,rest__] :> DBcall[List[ReleaseHold[(makeCString/@(heldExtInv/.varsToCodeVars))]], List[ReleaseHold[makeCString/@pvxMassSquare[heldIntMass]/.varsToCodeVars]], rest], {1}];

	instructions = instructionLines;

	(*Begin writing code here*)

	openwrite[stream];

	writeline[stream,ccfPreambleCode];

	writeline[stream,"//Declare initialization variables"];
	writeline[stream,"const mint maxDenom="<>ToString[maxDenom]<>";"];
	writeline[stream,"const mint maxRank="<>ToString[maxRank]<>";"];

	writeline[stream,ccfMessageHandlerCode];

	writeline[stream,""];

	writeline[stream,"//Allocate memory for user variables; these are in order of input list"];
	Do[
	  writeline[stream,"double _Complex inputVar"<>ToString[i]<>"; // "<>ToString[inputVars[[i]]]]
	,{i,1,Length[inputVars]}];

	writeline[stream,""];
	writeline[stream,"/************************ CollierCompiledFunction Body ************************/"];
	writeline[stream,""];

	writeline[stream,"double _Complex "<>functionName<>"Body(" <> StringJoin@Riffle[Table["double _Complex inputVar" <> ToString[i],{i,1,Length[inputVars]}],", "] <> "){"];
	writeline[stream,""];

	raiseIndentation[4];

	

	writeline[stream,"//Allocate memory for coefficient functions, and final result"];
	Do[With[{numCoeffsString=ToString@Length[pvxIdxList[ccfPVXcases[[i,-2]],maxRank]]},
	  writeline[stream,"static double _Complex pvx"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", pvx"<>ToString[i]<>"uv["<>numCoeffsString<>"];"];
	  writeline[stream,"static const mint den"<>ToString[i]<>" = "<>ToString[ccfPVXcases[[i,3]]]<>";"]
	],{i,1,Length[ccfPVXcases]}];

	(*CHANGED HERE: ADDED THIS*)
	Do[With[{numCoeffsString=ToString[(1+Quotient[maxRank,2]) (1+maxRank)]},
	  writeline[stream,"static double _Complex db"<>ToString[i]<>"["<>numCoeffsString<>"]"<>", db"<>ToString[i]<>"uv["<>numCoeffsString<>"];"];
	],{i,1,Length[ccfDBcases]}];

	writeline[stream,"static double _Complex result;"];
	writeline[stream,""];

	writeline[stream,"//Allocate memory for local variables"];
	Do[
	  writeline[stream,"static double _Complex localVar"<>ToString[i]<>"; // "<>ToString[heldLocalVars[[i]]]]
	,{i,1,Length[heldLocalVars]}];

	writeline[stream,""];

	writeline[stream,"//Allocate memory for lists of kinematic variables"];
	Do[
	  If[Length[ccfPVXcases[[i,1]]]!=0,writeline[stream,"static double _Complex extInv"<>ToString[i]<>"["<>ToString[Length[ccfPVXcases[[i,1]]]]<>"];"]];
	  writeline[stream,"static double _Complex massSq"<>ToString[i]<>"["<>ToString[Length[ccfPVXcases[[i,2]]]]<>"];"]
	,{i,1,Length[ccfPVXcases]}];
	(*CHANGED HERE: ADDED THIS*)
	Do[
	  If[Length[ccfDBcases[[i,1]]]!=0,writeline[stream,"static double _Complex extInvDB"<>ToString[i]<>"["<>ToString[Length[ccfDBcases[[i,1]]]]<>"];"]];
	  writeline[stream,"static double _Complex massSqDB"<>ToString[i]<>"["<>ToString[Length[ccfDBcases[[i,2]]]]<>"];"]
	,{i,1,Length[ccfDBcases]}];

	writeline[stream,""];

	writeline[stream,"//Constants"];
	Do[
	  writeline[stream,"static const double _Complex constVar"<>ToString[i]<>" = "<>(cNum[#]&)@Evaluate[OptionValue[Constants][[i,2]]]<>";"],{i,1,Length[OptionValue[Constants]]}
	];
	writeline[stream,""];

	writeline[stream,"//Evaluation code"];

	pvCalcCode=
	  Table[
		Join[
		  Table["extInv"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> ccfPVXcases[[i,1,j]] <> ";",{j,1,Length[ccfPVXcases[[i,1]]]}],
		  Table["massSq"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> ccfPVXcases[[i,2,j]] <> ";",{j,1,Length[ccfPVXcases[[i,2]]]}],
		  {If[ccfPVXcases[[i,3]]==1,
			"T1_checked_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0);",
			"TN_main_checked_cll(pvx"<>ToString[i]<>",pvx"<>ToString[i]<>"uv,extInv"<>ToString[i]<>",massSq"<>ToString[i]<>",&den"<>ToString[i]<>",&maxRank,0,0,0);"
		  ]}
		]
	  ,{i,1,Length[ccfPVXcases]}] ~Join~
	(*CHANGED HERE*)
	  Table[
		Join[
		  Table["extInvDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> ccfDBcases[[i,1,j]] <> ";",{j,1,Length[ccfDBcases[[i,1]]]}],
		  Table["massSqDB"<>ToString[i]<>"["<>ToString[j-1]<>"] = " <> ccfDBcases[[i,2,j]] <> ";",{j,1,Length[ccfDBcases[[i,2]]]}],
		  {"DB_arrays_cll(db"<>ToString[i]<>",db"<>ToString[i]<>"uv,extInvDB"<>ToString[i]<>",massSqDB"<>ToString[i]<>",&maxRank,0);"}
		]
	  ,{i,1,Length[ccfDBcases]}];

	pvCalcPosition = (Position[instructions,#[[1]],{0,Infinity},1]& /@ Join[ccfPVXrules,ccfDBrules])[[All,1,1]];
	instructions = instructions /. Join[ccfPVXuvrules, ccfPVXrules, ccfDBuvrules, ccfDBrules]; (*Slow*)

	instructions = Replace[instructions,varsToCodeVars,{1,Infinity},Heads->False];
	instructions = Replace[instructions, e_ :> RuleCondition[makeCString[e]<>";"], 1]; (*Slow*)

	instructions=oInsert[instructions,Hold@@pvCalcCode,pvCalcPosition];

	Do[
	  writeline[stream, instructions[[i]]]
	,{i,1,Length[instructions]-1}];
	writeline[stream, "result = "<> Last[instructions]];
	writeline[stream, "return result;"];

	lowerIndentation[4];
	writeline[stream, "}"];

   (*From this point on, there should be no errors.*)

	If[useCacheQ,
	  AppendTo[$ccfCaches, {cllAddNewCache[maxDenom],maxDenom}];
	  writeline[stream,""];
	  writeline[stream,"mint cacheno = "<>ToString[Last[$ccfCaches][[1]]]<>";  //Cache number"]
	];

	writeline[stream,"
/**************************** Wolfram kernel entry ****************************/
EXTERN_C DLLEXPORT int "<>functionName<>"Main(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument Res){
"];

	raiseIndentation[4];
	writeline[stream,"//Check if Nmax and rmax are large enough
    if (maxRank>Getrmax_cll() || maxDenom>GetNmax_cll()) {
        issueRankDenomMessage(libData);
        MArgument_setComplex(Res, cplxNAN);
        return LIBRARY_NO_ERROR;
    }"];

	writeline[stream,"//Get user input variables from Kernel"];
	Do[
	  writeline[stream,"inputVar"<>ToString[i]<>" =  to_complex(MArgument_getComplex(Args["<>ToString[i-1]<>"]));"]
	,{i,1,Length[inputVars]}];

	writeline[stream,""];

	writeline[stream,"//Call ccfBody, and pass result back to Kernel"];
	If[useCacheQ,
	  (*AppendTo[$ccfCaches, {cllAddNewCache[maxDenom],maxDenom}];*)
	  (*writeline[stream,"SwitchOnCacheSystem_cll();"];*)
	  writeline[stream,"SwitchOnCache_cll(&cacheno);"];
	  writeline[stream,"InitEvent_cll(&cacheno);"]
	];
	writeline[stream,"MArgument_setComplex(Res, to_mcomplex("<>functionName<>"Body("<>Riffle[Table["inputVar" <> ToString[i],{i,1,Length[inputVars]}],", "]<>")));"];
	(*If[useCacheQ,writeline[stream,"SwitchOffCacheSystem_cll();"]];*)
	If[useCacheQ,writeline[stream,"SwitchOffCache_cll(&cacheno);"]];
	writeline[stream,""];
	writeline[stream, "//Error check"];
	writeline[stream, "errAccFlagCheck(libData, Argc, Args, Res);"];
	writeline[stream,""];
	writeline[stream,"return LIBRARY_NO_ERROR;"];

	lowerIndentation[4];
	writeline[stream,"}"];

	writeline[stream,""];

	(*Standard LibraryLink functions*)

	writeline[stream,"/***************** STANDARD LIBRARYLINK FUNCTIONS *****************/"];
	writeline[stream,"DLLEXPORT mint WolframLibrary_getVersion(){return WolframLibraryVersion;}"];

	writeline[stream,"DLLEXPORT int WolframLibrary_initialize(WolframLibraryData libData){"];
	raiseIndentation[4];
	If[useCacheQ && OptionValue["PrimeCacheSystem"],
	  (*writeline[stream,"SwitchOnCacheSystem_cll();"];*)
	  writeline[stream,"//Prime cache system"];
	  writeline[stream,"if (maxRank<=Getrmax_cll() && maxDenom<=GetNmax_cll()) {"];
	  raiseIndentation[4];
	  writeline[stream,"SwitchOnCache_cll(&cacheno);"];
	  writeline[stream,"int i;"];
	  writeline[stream,"for (i=1; i<=3; i++){"];
	  raiseIndentation[4];
	  writeline[stream,"InitEvent_cll(&cacheno);"];
	  writeline[stream,functionName<>"Body("<>Riffle[ConstantArray["10*((double)rand()+1)/((double)rand()+1)",Length[inputVars]],","]<>");"];
	  lowerIndentation[4];
	  writeline[stream,"}"];
	  lowerIndentation[4];
	  (*writeline[stream,"SwitchOffCacheSystem_cll();"];*)
	  writeline[stream,"SwitchOffCache_cll(&cacheno);"];
	  writeline[stream,"}"]
	];
	writeline[stream,"return 0;"];
	lowerIndentation[4];
	writeline[stream,"}"];

	(*writeline[stream,"DLLEXPORT int WolframLibrary_initialize(WolframLibraryData libData){return 0;}"];*)

	writeline[stream,"DLLEXPORT char* WolframCompileLibrary_wrapper() {return \""<>
	  ccfMakeWrapperFunction[inputVars,maxDenom,maxRank,Length[ccfPVXcases],If[useCacheQ,Last[$ccfCaches][[1]],None],Length[instructions],Unevaluated[FileByteCount[FindLibrary[libFileName]]]]<>"\";}"];

	close[stream]
  ];

	(*Echo[varsToCodeVars,"varsToCodeVars"];
	Echo[heldLocalVars,"heldLocalVars"];
	Echo[{maxDenom,maxRank},"maxDenom,maxRank"];
	Echo[ccfPVXcases,"ccfPVXcases"];
	Echo[ccfPVXuvrules,"ccfPVXuvrules"];
	Echo[ccfPVXrules,"ccfPVXrules"];
	Echo[instructions,"instructionLines"];
	Echo[pvCalcPosition,"Positions"];
	Abort[];*)


(* ::Subsubsection::Closed:: *)
(*CollierCompile*)


If[$VersionNumber<10.0,System`Private`SetNoEntry=Identity];
$ccfNumber = 0;
$ccfInit = {};   (*List of function initialization, to reprime caches*)
$ccfCaches = {}; (*List of {cache_no, Nmax}*)


makeAndLoadLib[source_,functionName_,libFileName_,inputVarsLength_]:=
  Module[{ccfLib},

	Block[{$ContextPath},Needs["CCompilerDriver`"]];

	ccfLib = Quiet[CCompilerDriver`CreateLibrary[source,libFileName,
	  "Debug"->False,
	  "Language"->Automatic,
	  "Libraries"->{$CollierLibraryFile},
	  "TargetDirectory"->FileNameJoin[{$CollierLinkDirectory,"LibraryResources",$SystemID}],
	  "WorkingDirectory"->FileNameJoin[{$TemporaryDirectory,"collierlink"}],
	  "CleanIntermediate"->False,
	  "PostCompileCommands"->If[$SystemID==="MacOSX-x86-64","install_name_tool -id \"@loader_path/"<>libFileName<>".dylib\" "<>libFileName<>".dylib",""],
	  "CompileOptions"->{"-O0"}],{CCompilerDriver`CreateLibrary::wddel, CCompilerDriver`CreateLibrary::wddirty}];

	If[ccfLib===$Failed,
	  Throw[$Failed, "CollierCompile"],
	  AppendTo[$ccfInit,Last[LibraryFunctionLoad[ccfLib,"WolframLibrary_initialize",{},Integer,"AutomaticDelete"->True]]];
	  LibraryFunctionLoad[ccfLib,functionName<>"Main",ConstantArray[Complex,inputVarsLength],Complex,"AutomaticDelete"->True]
	]
  ];


(*Need to strip away innocuous Weights and Dimensions*)
SetAttributes[CollierCompile,HoldAll];

CollierCompile[inputVars_, expr_, opts:OptionsPattern[]] :=
 Catch[CheckAbort[
 ($currentCodeGenerationFunction=CollierCompile;
  Check[X`Internal`ValidOptionsQ[CollierCompile] /@ {opts}, Throw[$Failed,"CollierCompile"]];
  checkCollierCompileOptions[opts];
  checkCodeGenerateInputCommon[CollierCompile, inputVars, expr, opts];
  Block[inputVars,
  Module[{optimizedExpressionQ, heldLocalVarSpec, heldLocalVars, instructionLines, heldExpr, functionName, libFileName, pvxCalls, source, ccfLibFunc},
  Internal`InheritedBlock[{ToString},
	
	SetOptions[ToString,FormatType->OutputForm];

	If[LeafCount[Unevaluated[expr]]>100000 || $ccfNumber==0, ccMakeProgressCell[5]]; (*Display progress bar first time since loading CCompilerDriver, etc takes time *)
	incrementProgressCell["Initializing"];

	functionName="ccf"<>ToString[PreIncrement[$ccfNumber]];
	incrementProgressCell["Processing code block"];
	{heldExpr, optimizedExpressionQ} = preprocessCodeBlock[Unevaluated[expr], OptionValue["ExpressionOptimization"]];
	{instructionLines,{{heldLocalVarSpec, heldLocalVars}}} = getLocalVarsAndInstructionlines[heldExpr];

	(*Check if local variable specification also appears as a constant*)
	With[{dupl=Cases[heldLocalVars,Alternatives@@OptionValue[Constants][[All,1]],{1},1]},
	  If[dupl=!={},Message[CollierCompile::optcal, OptionValue[Constants], First@dupl, "a local variable"]; Throw[$Failed,"CollierCompile"]]
	];
	(*Check if scoping constructs are still present; they are too deep*)
	With[{dScope=Cases[instructionLines,s:_Module|_Block:>Hold[s],{1,Infinity},1,Heads->True]},
	  If[dScope=!={}, Unevaluated[dScope]/.{Hold[scope_]}:>Message[CollierCompile::dscope,HoldForm[scope]]; Throw[$Failed,"CollierCompile"]]
	];

	(*Blocked local variables*)
	Replace[heldLocalVars, Hold[lvars___] :> 
	Block[List[lvars],
	  instructionLines = makeInstructionLines[inputVars, heldLocalVarSpec, instructionLines, optimizedExpressionQ, OptionValue["InlineExternalDefinitions"]];

	  incrementProgressCell["Processing "<> ToString[Count[instructionLines,_PVA|_PVB|_PVC|_PVD|_PVX,{0,Infinity}]] <>" PV functions"];
	  {instructionLines, pvxCalls} = getAndProcessPVXcalls[instructionLines]; (*{instructionLines, {maxDenom,maxRank,pvxCases,dbCases}}*)

	  If[pvxCalls[[1]] > OptionValue[$CollierLink, "MaxDenominators"], Message[CollierCompile::maxden,OptionValue[$CollierLink, "MaxDenominators"]];Throw[$Failed,"CollierCompile"]];
	  If[pvxCalls[[2]] > OptionValue[$CollierLink, MaxRank], Message[CollierCompile::maxrank,OptionValue[$CollierLink, MaxRank],pvxCalls[[2]]]];

	  incrementProgressCell["Creating C code"];
	  libFileName = functionName<>"Lib-"<>ToString[$ProcessID];
	  source = ccfMakeSource[inputVars, heldLocalVars, instructionLines, pvxCalls, functionName, libFileName, opts]
	]];

	incrementProgressCell["Compiling C code"];
	(*Export[FileNameJoin[{$CollierLinkDirectory,"ccf.c"}],source,"Text"];*)

	ccfLibFunc = makeAndLoadLib[source,functionName,libFileName,Length[inputVars]];

	Throw[System`Private`SetNoEntry[ccfLibFunc],"CollierCompile"];
	Null
  ]]]
),Throw[$Failed,"CollierCompile"]],"CollierCompile"|"CollierCodeGenerate",(ccDestroyProgressCell[];#1)&];

LHS_CollierCompile:=RuleCondition[X`Internal`CheckArgumentCount[LHS,2,2];Fail];


checkCollierCompileOptions[opts:OptionsPattern[CollierCompile]] := 
(
  If[!MemberQ[{True,False},OptionValue["UseCacheSystem"]],Message[CollierCompile::opttf, "\"UseCacheSystem\"", OptionValue["UseCacheSystem"]];Throw[$Failed,"CollierCompile"]]  
);


(* ::Subsection::Closed:: *)
(*End*)


SetAttributes[{CollierCompiledFunction},Unevaluated@{Protected,ReadProtected,Locked}];
SetAttributes[{COLLIER,CollierCompile,CollierCodeGenerate,CollierLinkOptions,SeparateUV,SetCollierLinkOptions,UVDiv},Unevaluated@{Protected,ReadProtected}];


End[];
