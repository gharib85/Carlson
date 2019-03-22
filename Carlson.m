
(* :Title: Carlson's Symmetric Integrals *)

(* :Author: J. M. *)

(* :Summary:

     This package implements the symmetric elliptic integrals of B. C. Carlson.

 *)

(* :Copyright:

     � 2014-2019 by J. M. (pleasureoffiguring(AT)gmail(DOT)com)
     This work is free. It comes without any warranty, to the extent permitted by applicable law.
     You can redistribute and/or modify it under the terms of the MIT License.

 *)

(* :Package Version: 1.0 *)

(* :Mathematica Version: 8.0 *)

(* :History:

     1.0 - initial release

*)

(* :Keywords:
     Carlson, elliptic integrals, hypergeometric functions, symmetric integrals *)

(* :References:

     Carlson B. C. (1965) On computing elliptic integrals and functions.
         J. Math. Phys. 44, pp. 36�51. doi:10.1002/sapm196544136

     Carlson B. C. (1977) Special Functions of Applied Mathematics. Academic Press, New York.

     Carlson B. C. (1979) Computing elliptic integrals by duplication.
         Numer. Math. 33 (1), pp. 1�16. doi:10.1007/BF01396491

     Carlson B. C. (1995) Numerical computation of real or complex elliptic integrals.
         Numer. Algorithms 10 (1-2), pp. 13�26. doi:10.1007/BF02198293

     Carlson B. C., FitzSimons J. (2000) Reduction theorems for elliptic integrands with the square root of two quadratic factors.
         J. Comput. Appl. Math. 118 (1-2), pp. 71�85. doi:10.1016/S0377-0427(00)00282-X

     Carlson B. C. (2002) Three improvements in reduction and computation of elliptic integrals.
         J. Res. Nat. Inst. Standards Tech. 107 (5), pp. 413�418. doi:10.6028/jres.107.034

 *)
 
 (* :Discussion:

     The package provides ten functions defined by Carlson, denoted RC, RD, RE, RF, RG, RH, RJ, RK, RL, and RM.
     These functions are intended to replace the classical Legendre-Jacobi elliptic integrals.
     The multiple transformation identities required by Legendre-Jacobi integrals are replaced by permutation symmetry identities in the Carlson integrals.
     The functions RF, RD, RG, RJ, and RH correspond to incomplete elliptic integrals, while RK, RE, RL, and RM correspond to complete integrals.
     RC corresponds to an elementary integral that is useful in expressing formulae involving other Carlson functions.
     The incomplete integrals are numerically evaluated using the duplication theorem, while the complete integrals use AGM-based methods.

 *)

BeginPackage["Carlson`"]
Unprotect[CarlsonRC, CarlsonRD, CarlsonRE, CarlsonRF, CarlsonRG, CarlsonRH, CarlsonRJ, CarlsonRK, CarlsonRL, CarlsonRM];

(* --- usage messages --- *)

CarlsonRC::usage = "\!\(\*RowBox[{\"CarlsonRC\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \"]\"}]\) gives the Carlson elementary integral \!\(\*RowBox[{SubscriptBox[\"R\", \"C\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \")\"}]\).";

CarlsonRD::usage = "\!\(\*RowBox[{\"CarlsonRD\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \"]\"}]\) gives the unsymmetric Carlson integral of the second kind \!\(\*RowBox[{SubscriptBox[\"R\", \"D\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \")\"}]\).";

CarlsonRE::usage = "\!\(\*RowBox[{\"CarlsonRE\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \"]\"}]\) gives the complete Carlson integral of the second kind \!\(\*RowBox[{SubscriptBox[\"R\", \"E\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \")\"}]\).";

CarlsonRF::usage = "\!\(\*RowBox[{\"CarlsonRF\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \"]\"}]\) gives the Carlson integral of the first kind \!\(\*RowBox[{SubscriptBox[\"R\", \"F\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \")\"}]\).";

CarlsonRG::usage = "\!\(\*RowBox[{\"CarlsonRG\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \"]\"}]\) gives the symmetric Carlson integral of the second kind \!\(\*RowBox[{SubscriptBox[\"R\", \"G\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"]}], \")\"}]\).";

CarlsonRH::usage = "\!\(\*RowBox[{\"CarlsonRH\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \"]\"}]\) gives the alternate Carlson integral of the third kind \!\(\*RowBox[{SubscriptBox[\"R\", \"H\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \")\"}]\).";

CarlsonRJ::usage = "\!\(\*RowBox[{\"CarlsonRJ\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \"]\"}]\) gives the Carlson integral of the third kind \!\(\*RowBox[{SubscriptBox[\"R\", \"J\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"z\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \")\"}]\).";

CarlsonRK::usage = "\!\(\*RowBox[{\"CarlsonRK\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \"]\"}]\) gives the complete Carlson integral of the first kind \!\(\*RowBox[{SubscriptBox[\"R\", \"K\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"]}], \")\"}]\).";

CarlsonRL::usage = "\!\(\*RowBox[{\"CarlsonRL\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \"]\"}]\) gives the alternate complete Carlson integral of the third kind \!\(\*RowBox[{SubscriptBox[\"R\", \"L\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \")\"}]\).";

CarlsonRM::usage = "\!\(\*RowBox[{\"CarlsonRM\", \"[\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \"]\"}]\) gives the complete Carlson integral of the third kind \!\(\*RowBox[{SubscriptBox[\"R\", \"M\"], \"(\", RowBox[{StyleBox[\"x\", \"TI\"], \",\", StyleBox[\"y\", \"TI\"], \",\", StyleBox[\"p\", \"TI\"]}], \")\"}]\).";

Begin["`Private`"]

(* --- internal settings --- *)

$scalingThreshold = Sqrt[$MaxNumber];
$tiny = 1/$scalingThreshold;
$agmLimit = 50;
$useComplete = False;

(* --- RC --- *)

(* duplication theorem for RC *)

iRC[x_?NumericQ, y_?NumericQ] /; Precision[{x, y}] < Infinity && Sign[x] != -1 && y != 0 :=
      Module[{prec = Internal`PrecAccur[{x, y}], w = 1, a, c, l, m, r, s0, s1, u, v},
                  {u, v} = N[{x, y}, prec];
                  {s0, s1} = Through[{Min, Max}[Abs[{u, v}]]];
                  If[s1 < $scalingThreshold,
                      If[0 < s0 < $tiny,
                         {u, v} = {u, v}/s0; w /= Sqrt[s0]],
                      {u, v} = {u, v}/s1; w /= Sqrt[s1]]; (* apply homogeneity *)
                  If[Sign[v] == -1, a = u; (* principal value for negative y *)
                      {u, v} = {u - v, -v}; w *= Sqrt[a/u]];
                  a = m = (u + 2 v)/3;
                  c = 1; r = Abs[m - u]/(10^(-prec/2));
                  While[l = 2 Sqrt[u] Sqrt[v] + v;
                           {u, v, m} = ({u, v, m} + l)/4;
                            c /= 4;
                            c r >= Abs[m]];
                  v = c (v - a)/m;
                  w ((v ((3/2 v) (v ((1/4 v) (3 v + 53/26) + 3/11) + 1/4) + 1/7) + 3/10) v^2 + 1)/Sqrt[m]]

(* special cases *)

CarlsonRC[x_, y_] /; x == y := 1/Sqrt[x]
CarlsonRC[x_, y_?NumericQ] /; x == 0 := If[TrueQ[Sign[y] != -1], Pi/(2 Sqrt[y]), 0]

(* numerical evaluation *)

CarlsonRC[x_, y_] := With[{res = iRC[x, y]}, res /; Head[res] =!= iRC]

(* derivatives *)

Derivative[1, 0][CarlsonRC] ^= Function[(1/Sqrt[#1] - CarlsonRC[#1, #2])/(2 (#1 - #2))]
Derivative[0, 1][CarlsonRC] ^= Function[(CarlsonRC[#1, #2] - Sqrt[#1]/#2)/(2 (#1 - #2))]

Except[HoldPattern[CarlsonRC][_, _], HoldPattern[CarlsonRC][a___]] := (ArgumentCountQ[CarlsonRC, Length[{a}], 2, 2]; 1 /; False)
SyntaxInformation[CarlsonRC] = {"ArgumentsPattern" -> {_, _}}
SetAttributes[CarlsonRC, {Listable, NumericFunction}]

(* --- complete integrals --- *)

(* AGM iteration for RK and RE *)

cek[x_?NumericQ, y_?NumericQ, rk : (True | False)] /; 
      Precision[{x, y}] < Infinity && (And @@ Thread[Sign[{x, y}] != -1]) :=
      Module[{prec = Internal`PrecAccur[{x, y}], j = 0, f = 1, g, g0, g1, s, v, w, nprec},
                 {v, w} = N[{x, y}, prec];
                  nprec = Round[Max[$MachinePrecision, 1.1 prec + 5]];
                 {v, w} = SetPrecision[{v, w}, nprec];
                 NumericalMath`FixedPrecisionEvaluate[
                               {g0, g1} = Through[{Min, Max}[Abs[{v, w}]]];
                               If[g1 < $scalingThreshold,
                                   If[! (0 < g0 < $tiny), g = 1,
                                       {v, w} = {v, w}/g0; g = Sqrt[g0]],
                                   {v, w} = {v, w}/g1; g = Sqrt[g1]]; (* apply homogeneity *)
                               {v, w} = {{1, 1}, {1, -1}}.Sqrt[{v, w}]/2;
                               s = v^2;
                               While[j++;
                                        v = (v + Sqrt[(v - w) (v + w)])/2;
                                        w = w^2/(4 v);
                                        f *= 2; s -= f w^2;
                                        Abs[w] > 10^(-prec) Abs[v] && j < $agmLimit],
                               nprec];
                  SetPrecision[If[TrueQ[rk], 1/g, g s]/v, prec] /; j < $agmLimit]

(* AGM + Bartky iteration for RL and RM *)

cel3[x_?NumericQ, y_?NumericQ, p_?NumericQ, rm : (True | False)] /; 
       Precision[{x, y, p}] < Infinity && (And @@ Thread[Sign[{x, y}] != -1]) :=
       Module[{prec = Internal`PrecAccur[{x, y, p}], j = 0, c, d, e, g, g0, g1, h, q, r, s, t, v, w, nprec},
                   {v, w, c} = N[{x, y, p}, prec];
                   nprec = Round[Max[$MachinePrecision, 1.1 prec + 5]];
                   {v, w, c} = SetPrecision[{v, w, c}, nprec];
                   NumericalMath`FixedPrecisionEvaluate[
                                 {g0, g1} = Through[{Min, Max}[Abs[{v, w, c}]]];
                                 If[g1 < $scalingThreshold,
                                     If[! (0 < g0 < $tiny), g = 1,
                                        {v, w, c} = {v, w, c}/g0; g = Sqrt[g0]],
                                     {v, w, c} = {v, w, c}/g1; g = Sqrt[g1]]; (* apply homogeneity *)
                                 If[Sign[c] != -1,
                                     r = Sqrt[d = c]; (* normal case *)
                                     h = 0; t = 1,
                                     {t, d} = c - {v, w}; (* Cauchy principal value *)
                                     r = Sqrt[w t/d]; h = 2; t = (v - w)/t];
                                 {v, w} = Sqrt[{v, w}]; s = q = 1;
                                 While[j++;
                                          {v, w} = {(v + w)/2, Sqrt[v w]};
                                          e = r^2 + w^2;
                                          q *= (r + w) (r - w)/(2 e); s += q;
                                          r = e/(2 r);
                                          Abs[q] >= Abs[s] 10^(-prec) && j < $agmLimit],
                                 nprec];
                   SetPrecision[If[TrueQ[rm], (h + t s)/(d g^2), 
                                          If[TrueQ[c == 0], 2, 2 - c (h + t s)/d]]/(g (v + w)/2), prec] /; j < $agmLimit]

(* -- RK -- *)

(* special cases *)

CarlsonRK[x_, y_] /; x == y := 1/Sqrt[x]
CarlsonRK[x_, y_] /; x == 0 || y == 0 := Infinity

(* numerical evaluation *)

CarlsonRK[x_, y_] := With[{res = cek[x, y, True]}, res /; Head[res] =!= cek]

(* CarlsonRK[x_, y_] := 1/ArithmeticGeometricMean[Sqrt[x], Sqrt[y]] *)

(* derivatives *)

Derivative[1, 0][CarlsonRK] ^= Function[(CarlsonRE[#1, #2] - #1 CarlsonRK[#1, #2])/(2 #1 (#1 - #2))]
Derivative[0, 1][CarlsonRK] ^= Function[(CarlsonRE[#1, #2] - #2 CarlsonRK[#1, #2])/(2 #2 (#2 - #1))]

Except[HoldPattern[CarlsonRK][_, _], HoldPattern[CarlsonRK][a___]] := (ArgumentCountQ[CarlsonRK, Length[{a}], 2, 2]; 1 /; False)
SyntaxInformation[CarlsonRK] = {"ArgumentsPattern" -> {_, _}}
SetAttributes[CarlsonRK, {Listable, NumericFunction, Orderless}]

(* -- RE -- *)

(* special cases *)

CarlsonRE[x_, y_] /; x == y := Sqrt[x]
CarlsonRE[x_, y_] /; x == 0 || y == 0 := 2 If[x == 0, Sqrt[y], Sqrt[x]]/Pi

(* numerical evaluation *)

CarlsonRE[x_, y_] := With[{res = cek[x, y, False]}, res /; Head[res] =!= cek]

(* derivatives *)

Derivative[1, 0][CarlsonRE] ^= Function[(CarlsonRE[#1, #2] - #2 CarlsonRK[#1, #2])/(2 (#1 - #2))]
Derivative[0, 1][CarlsonRE] ^= Function[(CarlsonRE[#1, #2] - #1 CarlsonRK[#1, #2])/(2 (#2 - #1))]

Except[HoldPattern[CarlsonRE][_, _], HoldPattern[CarlsonRE][a___]] := (ArgumentCountQ[CarlsonRE, Length[{a}], 2, 2]; 1 /; False)
SyntaxInformation[CarlsonRE] = {"ArgumentsPattern" -> {_, _}}
SetAttributes[CarlsonRE, {Listable, NumericFunction, Orderless}]

(* -- RM -- *)

(* special cases *)

CarlsonRM[y_, x_, p_] /; Order[y, x] == -1 := CarlsonRM[x, y, p]
CarlsonRM[x_, y_, p_] /; x == y == p := x^(-3/2)
CarlsonRM[x_, y_, p_] /; x == 0 || y == 0 || p == 0 := Infinity
CarlsonRM[x_, y_, p_] /; x == p || y == p :=
           If[TrueQ[x == p], 2 (CarlsonRE[x, y] - x CarlsonRK[x, y])/(x (y - x)), 2 (CarlsonRE[x, y] - y CarlsonRK[x, y])/(y (x - y))]
CarlsonRM[x_, y_, p_] /; x == y := 4/Pi (CarlsonRC[0, x] - CarlsonRC[0, p])/(p - x)

(* numerical evaluation *)

CarlsonRM[x_, y_, p_] := With[{res = cel3[x, y, p, True]}, res /; Head[res] =!= cel3]

(* derivatives *)

Derivative[1, 0, 0][CarlsonRM] ^=
           Function[(CarlsonRM[#1, #2, #3]/2 + (CarlsonRE[#1, #2] - #1 CarlsonRK[#1, #2])/(#1 (#1 - #2)))/(#3 - #1)]
Derivative[0, 1, 0][CarlsonRM] ^=
           Function[(CarlsonRM[#1, #2, #3]/2 + (CarlsonRE[#1, #2] - #2 CarlsonRK[#1, #2])/(#2 (#2 - #1)))/(#3 - #2)]
Derivative[0, 0, 1][CarlsonRM] ^=
          Function[(1/(#1 - #3) + 1/(#2 - #3) - 1/#3) CarlsonRM[#1, #2, #3]/2 + (#3 CarlsonRK[#1, #2] - CarlsonRE[#1, #2])/(#3 (#3 - #1) (#3 - #2))]

Except[HoldPattern[CarlsonRM][_, _, _], HoldPattern[CarlsonRM][a___]] := (ArgumentCountQ[CarlsonRM, Length[{a}], 3, 3]; 1 /; False)
SyntaxInformation[CarlsonRM] = {"ArgumentsPattern" -> {_, _, _}}
SetAttributes[CarlsonRM, {Listable, NumericFunction}]

(* -- RL -- *)

(* special cases *)

CarlsonRL[y_, x_, p_] /; Order[y, x] == -1 := CarlsonRL[x, y, p]
CarlsonRL[x_, y_, p_] /; x == y == p  := 1/Sqrt[x]
CarlsonRL[x_, y_, p_] /; x == 0 || y == 0 := 4 If[x == 0, CarlsonRC[y, p], CarlsonRC[x, p]]/Pi
CarlsonRL[x_, y_, p_] /; p == 0 := 2 CarlsonRK[x, y]
CarlsonRL[x_, y_, p_] /; x == p || y == p :=
           If[TrueQ[x == p], 2 (CarlsonRE[x, y] - y CarlsonRK[x, y])/(x - y), 2 (CarlsonRE[x, y] - x CarlsonRK[x, y])/(y - x)]
CarlsonRL[x_, y_, p_] /; x == y := 4/Pi (x CarlsonRC[0, x] - p CarlsonRC[0, p])/(x - p)

(* numerical evaluation *)

CarlsonRL[x_, y_, p_] := With[{res = cel3[x, y, p, False]}, res /; Head[res] =!= cel3]

(* derivatives *)

Derivative[1, 0, 0][CarlsonRL] ^=
           Function[(CarlsonRL[#1, #2, #3]/2 + (CarlsonRE[#1, #2] - #2 CarlsonRK[#1, #2])/(#2 - #1))/(#3 - #1)]
Derivative[0, 1, 0][CarlsonRL] ^=
           Function[(CarlsonRL[#1, #2, #3]/2 + (CarlsonRE[#1, #2] - #1 CarlsonRK[#1, #2])/(#1 - #2))/(#3 - #2)]
Derivative[0, 0, 1][CarlsonRL] ^=
           Function[(#1/(2 #3 (#1 - #3)) + 1/(2 (#2 - #3))) CarlsonRL[#1, #2, #3] + (#3 CarlsonRE[#1, #2] - #1 #2 CarlsonRK[#1, #2])/(#3 (#3 - #1) (#3 - #2))]

Except[HoldPattern[CarlsonRL][_, _, _], HoldPattern[CarlsonRL][a___]] := (ArgumentCountQ[CarlsonRL, Length[{a}], 3, 3]; 1 /; False)
SyntaxInformation[CarlsonRL] = {"ArgumentsPattern" -> {_, _, _}}
SetAttributes[CarlsonRL, {Listable, NumericFunction}]

(* --- incomplete integrals --- *)

(* subroutines using the duplication theorem *)

iRF[x_?NumericQ, y_?NumericQ, z_?NumericQ] /;
      Precision[{x, y, z}] < Infinity && Count[Thread[{x, y, z} == 0], True] <= 1 && (And @@ Thread[Sign[{x, y, z}] != -1]) := 
      Module[{prec = Internal`PrecAccur[{x, y, z}], a, c, e2, e3, l, m, q, s, s0, s1, u, v, w},
                  {u, v, w} = N[{x, y, z}, prec];
                  {s0, s1} = Through[{Min, Max}[Abs[{u, v, w}]]];
                  If[s1 < $scalingThreshold,
                      If[! (0 < s0 < $tiny), s = 1,
                         {u, v, w} = {u, v, w}/s0; s = 1/Sqrt[s0]],
                      {u, v, w} = {u, v, w}/s1; s = 1/Sqrt[s1]];  (* apply homogeneity *)
                  a = m = (u + v + w)/3;
                  c = 1; q = Max[Abs[m - {u, v, w}]]/(10^(-prec/2));
                  While[l = Sqrt[u] (Sqrt[v] + Sqrt[w]) + Sqrt[v] Sqrt[w];
                           {u, v, w, m} = ({u, v, w, m} + l)/4; c /= 4;
                           c q >= Abs[m]];
                  {u, v} = c (a - {u, v})/m; w = -u - v;
                  {e2, e3} = {u v - w^2, u v w};
                  s (((((1/2 e3 + 1/3) (1/2 e2) - 3/11 e3) e2 + (3 e3^2 - 5/2 e2^3)/26)/2 - 1/5 e2 + 1/7 e3)/2 + 1)/Sqrt[m]]

iRD[x_?NumericQ, y_?NumericQ, z_?NumericQ] /; 
      Precision[{x, y, z}] < Infinity && z != 0 && Count[Thread[{x, y} == 0], True] <= 1 && (And @@ Thread[Sign[{x, y, z}] != -1]) := 
      Module[{prec = Internal`PrecAccur[{x, y, z}], a, c, e2, e3, e4, e5, f, f0, f1, l, m, q, s, u, v, w},
                  {u, v, w} = N[{x, y, z}, prec];
                  {f0, f1} = Through[{Min, Max}[Abs[{u, v, w}]]];
                  If[f1 < $scalingThreshold,
                      If[! (0 < f0 < $tiny), f = 1,
                         {u, v, w} = {u, v, w}/f0; f = f0^(-3/2)],
                      {u, v, w} = {u, v, w}/f1; f = f1^(-3/2)];  (* apply homogeneity *)
                  a = m = (u + v + 3 w)/5; c = 1; s = 0;
                  q = Max[Abs[m - {u, v, w}]]/(10^(-prec/2));
                  While[l = Sqrt[u] Sqrt[v] + Sqrt[w] (Sqrt[u] + Sqrt[v]);
                           s += c/(Sqrt[w] (w + l));
                           {u, v, w, m} = ({u, v, w, m} + l)/4; c /= 4;
                           c q >= Abs[m]];
                  {u, v} = c (a - {u, v})/m; w = -(u + v)/3;
                  {e2, e3, e4, e5} = {u v - 6 w^2, (3 u v - 8 w^2) w, 3 (u v - w^2) w^2, u v w^3};
                  f (c (1 + (3 ((3 ((5/34 e3 + 1/11) e2^2/2 - 1/13 e2 e3 - 1/17 (e2 e5 + e3 e4)) +
                                       1/10 (e3^2 + 2 e2 e4))/2 - 1/7 e2 - 1/11 e4 + 1/13 e5) - 1/8 e2^3 + 1/3 e3)/2)/Sqrt[m]^3 + 3 s)]

(* Cauchy principal value case for RJ *)

iRJ[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] /;
     Precision[{x, y, z, p}] < Infinity && Sign[p] == -1 && Count[Thread[{x, y, z} == 0], True] <= 1 && (And @@ Thread[Sign[{x, y, z}] != -1]) :=
     Module[{prec = Internal`PrecAccur[{x, y, z, p}], f, g, g0, g1, q, u, v, w},
                 {u, v, w} = SortBy[N[{x, y, z}, prec], {Re}]; f = N[p, prec];
                 {g0, g1} = Through[{Min, Max}[Abs[{u, v, w, f}]]];
                 If[g1 < $scalingThreshold,
                     If[! (0 < g0 < $tiny), g = 1,
                         {u, v, w, f} = {u, v, w, f}/g0; g = g0^(-3/2)],
                     {u, v, w, f} = {u, v, w, f}/g1; g = g1^(-3/2)]; (* apply homogeneity *)
                 q = v + (w - v) (v - u)/(v - f);
                 g ((q - v) iRJ[u, v, w, q] - 3 iRF[u, v, w] + 3 Sqrt[u] Sqrt[v] Sqrt[w] iRC[u w - f q, -f q]/Sqrt[u w - f q])/(v - f)]

iRJ[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] /; 
     Precision[{x, y, z, p}] < Infinity && Count[Thread[{x, y, z} == 0], True] <= 1 && p != 0 && (And @@ Thread[Sign[{x, y, z, p}] != -1]) := 
     Module[{prec = Internal`PrecAccur[{x, y, z, p}], a, c, d, e2, e3, e4, e5, f, g, g0, g1, h, l, m, q, r, s, u, v, w},
                 {u, v, w, f} = N[{x, y, z, p}, prec];
                 {g0, g1} = Through[{Min, Max}[Abs[{u, v, w, f}]]];
                 If[g1 < $scalingThreshold,
                     If[! (0 < g0 < $tiny), g = 1,
                         {u, v, w, f} = {u, v, w, f}/g0; g = g0^(-3/2)],
                     {u, v, w, f} = {u, v, w, f}/g1; g = g1^(-3/2)]; (* apply homogeneity *)
                 a = m = (u + v + w + 2 f)/5;
                 h = Times @@ (f - {u, v, w});
                 q = Max[Abs[m - {u, v, w, f}]]/(10^(-prec/2));
                 c = 1;
                 While[l = Sqrt[u] Sqrt[v] + Sqrt[w] (Sqrt[u] + Sqrt[v]);
                          d = Times @@ (Sqrt[f] + Sqrt[{u, v, w}]);
                          If[c < 1, (* recurrence by FitzSimons *)
                              r = s (1 + Sqrt[1 + c h/s^2]);
                              s = (d r - h c^2)/(2 (c r + d)),
                              s = d/2];
                          {u, v, w, f, m} = ({u, v, w, f, m} + l)/4; c /= 4;
                          c q >= Abs[m]];
                 {u, v, w} = c (a - {u, v, w})/m; f = -(u + v + w)/2;
                 e2 = u v + w (u + v) - 3 f^2; e5 = u v w;
                 {e3, e4, e5} = {e5 + 2 f (e2 + 2 f^2), (2 e5 + f (e2 + 3 f^2)) f, e5 f^2};
                 g (c (1 + (3 ((3 ((5/34 e3 + 1/11) e2^2/2 - 1/13 e2 e3 - 1/17 (e2 e5 + e3 e4)) +
                                       1/10 (e3^2 + 2 e2 e4))/2 - 1/7 e2 - 1/11 e4 + 1/13 e5) - 1/8 e2^3 + 1/3 e3)/2)/Sqrt[m]^3 + 3 iRC[1, 1 + c h/s^2]/s)]

(* express RG and RH in terms of other Carlson integrals *)

iRG[x_?NumericQ, y_?NumericQ, z_?NumericQ] /; 
      Precision[{x, y, z}] < Infinity && Count[Thread[{x, y, z} == 0], True] <= 1 && (And @@ Thread[Sign[{x, y, z}] != -1]) := 
      Module[{args, mo, pl, pos, s, u, v, w},
                  args = N[{x, y, z}, Internal`PrecAccur[{x, y, z}]];
                  mo = Abs[args]; pos = Ordering[mo, All, LessEqual];
                  pl = Last[pos]; w = args[[pl]]; {u, v} = Delete[args, pl];
                  If[(s = mo[[pl]]) < $scalingThreshold,
                      If[! (0 < (s = mo[[First[pos]]]) < $tiny), s = 1,
                         {u, v, w} = {u, v, w}/s; s = Sqrt[s]],
                      {u, v, w} = {u, v, w}/s; s = Sqrt[s]];  (* apply homogeneity *)
                  s ((w iRF[u, v, w] - (w - u) (w - v) iRD[u, v, w]/3 + Sqrt[u] Sqrt[v]/Sqrt[w])/2)]

iRH[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] /; 
      Precision[{x, y, z, p}] < Infinity && Count[Thread[{x, y, z} == 0], True] <= 1 && (And @@ Thread[Sign[{x, y, z}] != -1]) := 
      Module[{f, s, s0, s1, u, v, w},
                  {u, v, w, f} = N[{x, y, z, p}, Internal`PrecAccur[{x, y, z, p}]];
                  {s0, s1} = Through[{Min, Max}[Abs[{u, v, w, f}]]];
                  If[s1 < $scalingThreshold,
                      If[! (0 < s0 < $tiny), s = 1,
                          {u, v, w, f} = {u, v, w, f}/s0; s = 1/Sqrt[s0]],
                      {u, v, w, f} = {u, v, w, f}/s1; s = 1/Sqrt[s1]];  (* apply homogeneity *)
                  s (3 iRF[u, v, w]/2 - If[TrueQ[f == 0], 0, f iRJ[u, v, w, f]/2])]

(* -- RF -- *)

(* special cases *)

CarlsonRF[x_, y_, z_] /; Signature[{x, y, z}] == 0 := If[TrueQ[y == z], CarlsonRC[x, y], CarlsonRC[z, y]]

CarlsonRF[x_, y_, z_] /; $useComplete && MemberQ[{x, y, z}, 0] := Pi Apply[CarlsonRK, DeleteCases[{x, y, z}, 0, 1]]/2

(* numerical evaluation *)

CarlsonRF[x_, y_, z_] := With[{res = iRF[x, y, z]}, res /; Head[res] =!= iRF]

(* derivatives *)

Derivative[1, 0, 0][CarlsonRF] ^= Function[-CarlsonRD[#2, #3, #1]/6]
Derivative[0, 1, 0][CarlsonRF] ^= Function[-CarlsonRD[#1, #3, #2]/6]
Derivative[0, 0, 1][CarlsonRF] ^= Function[-CarlsonRD[#1, #2, #3]/6]

Except[HoldPattern[CarlsonRF][_, _, _], HoldPattern[CarlsonRF][a___]] := (ArgumentCountQ[CarlsonRF, Length[{a}], 3, 3]; 1 /; False)
SyntaxInformation[CarlsonRF] = {"ArgumentsPattern" -> {_, _, _}}
SetAttributes[CarlsonRF, {Listable, NumericFunction, Orderless}]

(* -- RD -- *)

(* special cases *)

CarlsonRD[y_, x_, z_] /; Order[y, x] == -1 := CarlsonRD[x, y, z]
CarlsonRD[x_, y_, z_] /; x == y == z := x^(-3/2)
CarlsonRD[x_, y_, z_] /; x == y := 3 (CarlsonRC[z, x] - 1/Sqrt[z])/(z - x)
CarlsonRD[x_, y_, z_] /; x == z || y == z := 
           If[TrueQ[y == z], 3 (Sqrt[x]/y - CarlsonRC[x, y])/(2 (x - y)), 3 (Sqrt[y]/x - CarlsonRC[y, x])/(2 (y - x))]

CarlsonRD[x_, y_, z_] /; $useComplete && MemberQ[{x, y}, 0] := 
           With[{u = First[DeleteCases[{x, y}, 0, 1]]}, 3 Pi (CarlsonRE[u, z] - z CarlsonRK[u, z])/(2 z (u - z))]

(* numerical evaluation *)

CarlsonRD[x_, y_, z_] := With[{res = iRD[x, y, z]}, res /; Head[res] =!= iRD]

(* derivatives *)

Derivative[1, 0, 0][CarlsonRD] ^= Function[(CarlsonRD[#2, #3, #1] - CarlsonRD[#1, #2, #3])/(2 (#1 - #3))]
Derivative[0, 1, 0][CarlsonRD] ^= Function[(CarlsonRD[#1, #3, #2] - CarlsonRD[#1, #2, #3])/(2 (#2 - #3))]
Derivative[0, 0, 1][CarlsonRD] ^=
           Function[3 (1/(#3 - #1) - 1/(#3 - #2)) CarlsonRF[#1, #2, #3]/(2 (#1 - #2)) -
                         (1/(#3 - #1) + 1/(#3 - #2)) CarlsonRD[#1, #2, #3] - (3 Sqrt[#1] Sqrt[#2])/(2 #3^(3/2) (#3 - #1) (#3 - #2))]

Except[HoldPattern[CarlsonRD][_, _, _], HoldPattern[CarlsonRD][a___]] := (ArgumentCountQ[CarlsonRD, Length[{a}], 3, 3]; 1 /; False)
SyntaxInformation[CarlsonRD] = {"ArgumentsPattern" -> {_, _, _}}
SetAttributes[CarlsonRD, {Listable, NumericFunction}]

(* -- RG -- *)

(* special cases *)

CarlsonRG[x_, y_, z_] /; x == y == z := Sqrt[x]
CarlsonRG[x_, y_, z_] /; Signature[{x, y, z}] == 0 := If[TrueQ[y == z], (y CarlsonRC[x, y] + Sqrt[x])/2, (y CarlsonRC[z, y] + Sqrt[z])/2]

CarlsonRG[x_, y_, z_] /; $useComplete && MemberQ[{x, y, z}, 0] := Pi Apply[CarlsonRE, DeleteCases[{x, y, z}, 0, 1]]/4

(* numerical evaluation *)

CarlsonRG[x_, y_, z_] := With[{res = iRG[x, y, z]}, res /; Head[res] =!= iRG]

(* derivatives *)

Derivative[1, 0, 0][CarlsonRG] ^= Function[(3 CarlsonRF[#1, #2, #3] - #1 CarlsonRD[#2, #3, #1])/12]
Derivative[0, 1, 0][CarlsonRG] ^= Function[(3 CarlsonRF[#1, #2, #3] - #2 CarlsonRD[#3, #1, #2])/12]
Derivative[0, 0, 1][CarlsonRG] ^= Function[(3 CarlsonRF[#1, #2, #3] - #3 CarlsonRD[#1, #2, #3])/12]

Except[HoldPattern[CarlsonRG][_, _, _], HoldPattern[CarlsonRG][a___]] := (ArgumentCountQ[CarlsonRG, Length[{a}], 3, 3]; 1 /; False)
SyntaxInformation[CarlsonRG] = {"ArgumentsPattern" -> {_, _, _}}
SetAttributes[CarlsonRG, {Listable, NumericFunction, Orderless}]

(* -- RJ -- *)

(* special cases *)

CarlsonRJ[x_, y_, z_, p_] /; ! OrderedQ[{x, y, z}] := CarlsonRJ[##, p] & @@ Sort[{x, y, z}]
CarlsonRJ[x_, y_, z_, p_] /; MemberQ[{x, y, z}, p] := Module[{args = {x, y, z}, pos},
           pos = First[Position[args, p]];
           CarlsonRD[##, p] & @@ Delete[args, pos]]
CarlsonRJ[x_, y_, z_, p_] /; Signature[{x, y, z}] == 0 := 
           If[TrueQ[y == z], 3 (CarlsonRC[x, y] - CarlsonRC[x, p])/(p - y), 3 (CarlsonRC[z, y] - CarlsonRC[z, p])/(p - y)]

CarlsonRJ[x_, y_, z_, p_] /; $useComplete && MemberQ[{x, y, z}, 0] := 3 Pi Apply[CarlsonRM[##, p] &, DeleteCases[{x, y, z}, 0, 1]]/4

(* numerical evaluation *)

CarlsonRJ[x_, y_, z_, p_] := With[{res = iRJ[x, y, z, p]}, res /; Head[res] =!= iRJ]

(* derivatives *)

Derivative[1, 0, 0, 0][CarlsonRJ] ^= Function[(CarlsonRJ[#1, #2, #3, #4] - CarlsonRD[#2, #3, #1])/(2 (#4 - #1))]
Derivative[0, 1, 0, 0][CarlsonRJ] ^= Function[(CarlsonRJ[#1, #2, #3, #4] - CarlsonRD[#1, #3, #2])/(2 (#4 - #2))]
Derivative[0, 0, 1, 0][CarlsonRJ] ^= Function[(CarlsonRJ[#1, #2, #3, #4] - CarlsonRD[#1, #2, #3])/(2 (#4 - #3))]
Derivative[0, 0, 0, 1][CarlsonRJ] ^=
           Function[(3 (#4 CarlsonRF[#1, #2, #3] - 2 CarlsonRG[#1, #2, #3] + Sqrt[#1] Sqrt[#2] Sqrt[#3]/#4)/((#4 - #1) (#4 - #2) (#4 - #3)) -
                          (1/(#4 - #1) + 1/(#4 - #2) + 1/(#4 - #3)) CarlsonRJ[#1, #2, #3, #4])/2]

Except[HoldPattern[CarlsonRJ][_, _, _, _], HoldPattern[CarlsonRJ][a___]] := (ArgumentCountQ[CarlsonRJ, Length[{a}], 4, 4]; 1 /; False)
SyntaxInformation[CarlsonRJ] = {"ArgumentsPattern" -> {_, _, _, _}}
SetAttributes[CarlsonRJ, {Listable, NumericFunction}]

(* -- RH -- *)

(* special cases *)

CarlsonRH[x_, y_, z_, p_] /; ! OrderedQ[{x, y, z}] := CarlsonRH[##, p] & @@ Sort[{x, y, z}]
CarlsonRH[x_, y_, z_, p_] /; x == y == z == p := 1/Sqrt[x]
CarlsonRH[x_, y_, z_, p_] /; MemberQ[{x, y, z}, p] := Module[{args = {x, y, z}, pos},
           pos = First[Position[args, p]];
           3 CarlsonRF[x, y, z]/2 - If[TrueQ[p == 0], 0, (p CarlsonRD[##, p]/2) & @@ Delete[args, pos]]]
CarlsonRH[x_, y_, z_, p_] /; Signature[{x, y, z}] == 0 :=
           If[TrueQ[y == z], 3/2 (y CarlsonRC[x, y] - p CarlsonRC[x, p])/(y - p), 3/2 (y CarlsonRC[z, y] - p CarlsonRC[z, p])/(y - p)]
CarlsonRH[x_, y_, z_, p_] /; p == 0 := 3 CarlsonRF[x, y, z]/2

CarlsonRH[x_, y_, z_, p_] /; $useComplete && MemberQ[{x, y, z}, 0] := 3 Pi Apply[CarlsonRL[##, p] &, DeleteCases[{x, y, z}, 0, 1]]/8

(* numerical evaluation *)

CarlsonRH[x_, y_, z_, p_] := With[{res = iRH[x, y, z, p]}, res /; Head[res] =!= iRH]

(* derivatives *)

Derivative[1, 0, 0, 0][CarlsonRH] ^= Function[(2 CarlsonRH[#1, #2, #3, #4] - 3 CarlsonRF[#1, #2, #3] + #1 CarlsonRD[#2, #3, #1])/(4 (#4 - #1))]
Derivative[0, 1, 0, 0][CarlsonRH] ^= Function[(2 CarlsonRH[#1, #2, #3, #4] - 3 CarlsonRF[#1, #2, #3] + #2 CarlsonRD[#1, #3, #2])/(4 (#4 - #2))]
Derivative[0, 0, 1, 0][CarlsonRH] ^= Function[(2 CarlsonRH[#1, #2, #3, #4] - 3 CarlsonRF[#1, #2, #3] + #3 CarlsonRD[#1, #2, #3])/(4 (#4 - #3))]
Derivative[0, 0, 0, 1][CarlsonRH] ^=
           Function[(2/#4 - 1/(#4 - #1) - 1/(#4 - #2) - 1/(#4 - #3)) CarlsonRH[#1, #2, #3, #4]/2 +
                         (3 #4 (2 #4 CarlsonRG[#1, #2, #3] - Sqrt[#1] Sqrt[#2] Sqrt[#3]) +
                          (6 #1 #2 #3 - 3 #4 (#1 #2 + #2 #3 + #1 #3)) CarlsonRF[#1, #2, #3])/(4 #4 (#4 - #1) (#4 - #2) (#4 - #3))]

Except[HoldPattern[CarlsonRH][_, _, _, _], HoldPattern[CarlsonRH][a___]] := (ArgumentCountQ[CarlsonRH, Length[{a}], 4, 4]; 1 /; False)
SyntaxInformation[CarlsonRH] = {"ArgumentsPattern" -> {_, _, _, _}}
SetAttributes[CarlsonRH, {Listable, NumericFunction}]

(* --- typesetting rules --- *)

CarlsonRC /: MakeBoxes[CarlsonRC[x_, y_], TraditionalForm] :=
           RowBox[{InterpretationBox[SubscriptBox["R", "C"], CarlsonRC, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRC"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y}], ","], ")"}]

CarlsonRK /: MakeBoxes[CarlsonRK[x_, y_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "K"], CarlsonRK, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRK"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y}], ","], ")"}]
CarlsonRE /: MakeBoxes[CarlsonRE[x_, y_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "E"], CarlsonRE, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRE"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y}], ","], ")"}]
CarlsonRM /: MakeBoxes[CarlsonRM[x_, y_, p_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "M"], CarlsonRM, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRM"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, p}], ","], ")"}]
CarlsonRL /: MakeBoxes[CarlsonRL[x_, y_, p_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "L"], CarlsonRL, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRL"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, p}], ","], ")"}]

CarlsonRF /: MakeBoxes[CarlsonRF[x_, y_, z_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "F"], CarlsonRF, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRF"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, z}], ","], ")"}]
CarlsonRD /: MakeBoxes[CarlsonRD[x_, y_, z_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "D"], CarlsonRD, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRD"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, z}], ","], ")"}]
CarlsonRG /: MakeBoxes[CarlsonRG[x_, y_, z_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "G"], CarlsonRG, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRG"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, z}], ","], ")"}]
CarlsonRJ /: MakeBoxes[CarlsonRJ[x_, y_, z_, p_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "J"], CarlsonRJ, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRJ"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, z, p}], ","], ")"}]
CarlsonRH /: MakeBoxes[CarlsonRH[x_, y_, z_, p_], TraditionalForm] := 
           RowBox[{InterpretationBox[SubscriptBox["R", "H"], CarlsonRH, Editable -> False, Selectable -> False, Tooltip -> "CarlsonRH"], "(", Sequence @@ Riffle[Map[ToBoxes, {x, y, z, p}], ","], ")"}]

End[ ]

SetAttributes[{CarlsonRC, CarlsonRD, CarlsonRE, CarlsonRF, CarlsonRG, CarlsonRH, CarlsonRJ, CarlsonRK, CarlsonRL, CarlsonRM}, ReadProtected];
Protect[CarlsonRC, CarlsonRD, CarlsonRE, CarlsonRF, CarlsonRG, CarlsonRH, CarlsonRJ, CarlsonRK, CarlsonRL, CarlsonRM];

EndPackage[ ]