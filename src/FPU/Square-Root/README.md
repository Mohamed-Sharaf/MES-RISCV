# Square Root Module

> Workflow:

- Extract the sign bit from the floating-point number (if 0: then it’s a +ve number and we perform the operation. If 1: then it’s a -ve number and the result is NAN).
- Divide the exponent by 2 and adjust the result based on the bits in the mantissa.
- Calculate the mantissa as following:

    - We’ll use four signals in our algorithm:
    - X - input radicand we want the square root of
    - A - holds the current value we’re working on
    - T - result of sign test
    - Q - the square root

    > Initialization 
    - A = 00000000,  X = input, T = 00000000,  Q =0000.
    - Add the implicit bit to the MSB of the input. 
    - Initialize A & T (have the same width of input) with Zero’s.
    - Initialize Q (have half width of the input) with Zero’s.
    - Left shift X by two places into A.
    - Set T = A - {Q,01}: 01 - 01.
    - Left shift Q.
    - Is T ≥ 0? Yes. Set A=T and Q[0]=1. | No. Move to next step.
    - Repeat the pervious steps Q times (have half width of the input bits).
    - Round the result of the mantissa to the desired precision (based on rm field). Normalize the result by adjusting the exponent and mantissa as needed.

