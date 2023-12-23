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

