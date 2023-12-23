# Division Module

> Workflow: 
  Let N1 and N2 are normalized operands represented by S1, M1, E1 and S2, M2, E2 as their respective sign bit, mantissa (significand) and exponent. If let us say we consider x=N1 and d=N2 and the result q has been taken as “x/d”. The following four steps are used for floating point division.
Divide significands, subtract exponents, and determine sign.
- M = M1 / M2
- E = E1 - E2 + Bias
- S = S1 XOR S2
- Normalize Mantissa M (Shift left or right by 1) and update exponent E.
- Rounding the result to fit in the available bits.
- Determine exception flags and special values.


# Microarchitecture:

![div_schematic](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/div_schematic.jpg)
