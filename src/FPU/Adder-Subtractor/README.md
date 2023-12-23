# Addition And Subtraction Module

> Workflow:
While adding or subtracting the two floating point numbers, two cases may arise. * Case I: when both the numbers are of same sign i.e., when both the numbers are either +ve or –ve. In this case MSB of both the numbers are either 1 or 0. * Case II: when both the numbers are of different sign i.e., when one number is +ve and other number is –ve. In this case the MSB of one number is 1 and other is 0.

- Extract the sign, exponent, and mantissa from the floating-point numbers.
- Enter two numbers N1 and N2. E1, S1 and E1, S2 represent exponent and significand of N1 and N2 respectively.
- Is E1 or E2 = “0”. If yes; set hidden bit of N1 or N2 is zero. If not; then check if E2 > E1, if yes swap N1 and N2 and if E1 > E2; contents of N1 and N2 need not to be swapped.
- Calculate difference in exponents d=E1-E2. If d = “0” then there is no need of shifting the significand. If d is more than “0” say “y” then shift S2 to the right by an amount “y” and fill the left most bits by zero. Shifting is done with hidden bit.
- Amount of shifting i.e., “y” is added to exponent of N2 value. New exponent value of E2 = (previous E2) + “y”. Now result is in normalize form because E1 = E2.
- Check if N1 and N2 have different sign, if “no”.
- Add the significands of 24 bits each including hidden bit S=S1+S2.
