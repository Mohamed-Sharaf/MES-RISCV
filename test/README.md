# Test Program:

This test includes Instructions Supported by The Added FPU Extension 


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
| 00003087 | fld f1, 0(x0) |
| 5800f153 | fsqrt.s f2, f1 |
| 580171d3 | fsqrt.s f3, f2 |
| 0021f2d3 | fadd.s f5, f3, f2 |
| 1032f353 | fmul.s f6, f5, f3 |                
| 0832f253 | fsub.s f4, f5, f3 |
| 185373d3 | fdiv.s f7 f6 f5 |
| 00737453 | fadd.s f8, f6, f7 |
| e0009553 | fclass.s x10, f1 |
| 00852027 | fsw f8, 0(x10) |
| 207404d3 | fsgnj.s f9, f8, f7 |
| 20741553 | fsgnjn.s f10, f8, f7 |
| 207425d3 | fsgnjx.s f11, f8, f7 |
| 20652653 | fsgnjx.s f12, f10, f6 |
| 206516d3 | fsgnjn.s f13, f10, f6 |
| 20650753 | fsgnj.s f14, f10, f6 |
| 286507d3 | fmin.s f15, f10, f6 |
| 28651853 | fmax.s f16, f10, f6 |
| 290718d3 | fmax.s f17, f14, f16 |
| d011f953 | fcvt.s.wu f18, x3 |
| d001f9d3 | fcvt.s.w f19, x3 |
| c019f653 | fcvt.wu.s x12, f19 |
| c009f6d3 | fcvt.w.s x13, f19 |
| c007f753 | fcvt.w.s x14, f15 |
| c017f7d3 | fcvt.wu.s x15, f15 |
| f0038a53 | fmv.w.x f20, x7 |
| e00a07d3 | fmv.x.w x15, f20 |
| a021aa53 | feq.s x20, f3, f2 |
| a0219ad3 | flt.s x21, f3, f2 |
| a0218b53 | fle.s x22, f3, f2 |
| a051abd3 | feq.s x23, f3, f5 |
| a0311c53 | flt.s x24, f2, f3 |
| a0310cd3 | fle.s x25, f2, f3 |
| 5809fc53 | fsqrt.s f24, f19 |
| 1989fad3 | fdiv.s f21, f19, f24 |
| 1189fb53 | fmul.s f22, f19, f24 |              
| 20fc0e53 | fsgnj.s f28, f24, f15 |
| c00e7e53 | fcvt.w.s x28, f28 |
| 00000000 | |
----


