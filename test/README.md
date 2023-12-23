# Test Program:

Instructions Supported by The Added FPU Extension 


| Machine Code | Instruction |
|:---------:	|:---------:	|
| 00004033 | 
| 00800093 |  
| 00100113 | 
| 00100193 | 
| 00000393 |  
| 00100413 | 
| 00200493 | 
| 0290C263 | 
| 00018393 | 
| 00008113 |
| 00914863 | 
| 007181B3 | 
| 40810133 | 
| FE948AE3 | 
| 408080B3 | 
| FE9480E3 | 
| 00300023 | factorial of 8  | 
| 00003087 | *fld f1, 0(x0)* |
5800f153 /*fsqrt.s f2, f1*/
580171d3 /*fsqrt.s f3, f2*/
0021f2d3 /*fadd.s f5, f3, f2*/
1032f353 /*fmul.s f6, f5, f3*/                
0832f253 /*fsub.s f4, f5, f3*/
185373d3 /*fdiv.s f7 f6 f5*/
00737453 /*fadd.s f8, f6, f7*/
e0009553 /*fclass.s x10, f1*/
00852027 /*fsw f8, 0(x10)*/
207404d3 /*fsgnj.s f9, f8, f7*/
20741553 /*fsgnjn.s f10, f8, f7*/
207425d3 /*fsgnjx.s f11, f8, f7*/
20652653 /*fsgnjx.s f12, f10, f6*/
206516d3 /*fsgnjn.s f13, f10, f6*/
20650753 /*fsgnj.s f14, f10, f6*/
286507d3 /*fmin.s f15, f10, f6*/
28651853 /*fmax.s f16, f10, f6*/
290718d3 /*fmax.s f17, f14, f16*/

----


