# Multiplication Module

> Workflow:
> Let N1 and N2 are normalized operands represented by S1, M1, E1 and S2, M2, E2 as their respective sign bit, mantissa (significand) and exponent. Basically, following four steps are used for floating point multiplication.
- Multiply signifcands, add exponents, and determine sign
- M = M1 * M2 
- E = E1 + E2 - Bias 
- S = S1 XOR S2
- Normalize Mantissa M (Shift left or right by 1) and update exponent E.
- Rounding the result to fit in the available bits.
- Determine exception flags and special values for overflow and underflow.


# Microarchitecture:

![mul_schematic](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/mul_schematic.jpg)
