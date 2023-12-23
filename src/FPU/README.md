# IEEE 754 Floating-Point standard

Representations of floating-point data in the binary formats are encoded in k bits in the following three fields ordered as shown in Figure below:
![s1](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/s1.png)

If a Single Precision format is used the bits will be divided in that way:
- The first bit (31st bit) is set the sign (S) of the number (0 positive and 1 negative)
- Next 8 bits (from 30th to 23rd bit) represents the exponent (E)
- The rest of the string, t, (from 22nd to 0) is reserved to save the mantissa.

The range of the encoding biased exponent is divided in three sections:
- Every integer between 1 and 2^𝑤 -2 (being w=8 → 254(10) to encode the normal numbers
- The value 0 which encodes subnormal numbers and the zero value.
- The reserved value 2^𝑤 -1 (being w=8 → 255(10) to encode some special cases as NaN or ±∞
- The exponent value has a bias of 127. It means the exponent value will be between -126 (00000000(2) and +127 (11111110(2) being zero at the value (01111111(2).

![s2](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/s2.png)

Exponent and mantissa values determine the different number r cases that it can be had.
- If E = 2^𝑤 -1 and T ≠ 0, then r is NaN regardless of S
- If E = 2^𝑤 -1 and T = 0, then r is ±infinity according with the sign bit S
- If 1 ≤ E ≤ 2^𝑤 -2, then r is a normal number.
- If E = 0 and T ≠ 0, then r is a subnormal number
- If E = 0 and T = 0, then r is ±zero according with S

![s3](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/s3.png)


# IEEE 754 Floating-Point (rounding modes)

> Round and Guard bits:
Guard bits: extra bits are needed for rounding guards against loss of a significant bit.
IEEE 754 standard specifies four modes of rounding:
- Round to Nearest Even: default rounding mode
- Round toward +∞: result is rounded up.
- Round toward –∞: result is rounded down.
- Round toward 0: always truncate result

![round](https://github.com/Mohamed-Sharaf/MES-RISCV/blob/main/assets/images/round.png)


# FPU Instructions
Instructions supported by FPU Unit:

> Floating-Point Load and Store Instructions:
 - flw: Floating-point Load Word
 - fsw: Floating-point Store Word

> Floating-Point Computational Instructions:
 - fadd.s: Floating-point Add (single precision)
 - fsub.s: Floating-point Subtract (single precision)
 - fmul.s: Floating-point Multiply (single precision)
 - fdiv.s: Floating-point Divide (single precision)
 - fsqrt.s: Floating-point Square Root (single precision)

> Floating-Point Sign Instructions:
 - fsgnj.s: Floating-point Sign Injection 
 - fsgnjn.s: Floating-point Sign Injection Negate 
 - fsgnj.s: Floating-point Sign Injection Xor 

> Floating-Point Conversion Instructions:
 - fmv.x.w: Floating-point Move to Integer (word)
 - fmv.w.x: Floating-point Move from Integer (word)
 - fcvt.w.s: Floating-point Convert to Signed Integer (32-bit)
 - fcvt.wu.s: Floating-point Convert to Unsigned Integer (32-bit)
 - fcvt.s.w: Floating-point Convert to Single Precision from Signed Integer (32-bit)
 - fcvt.s.wu: Floating-point Convert to Single Precision from Unsigned Integer (32-bit)
 - fclass.s: Classifiy the Floating point

> Floating-Point Comparison Instructions:
 - fmin.s: Floating-point Minimum (single precision)
 - fmax.s: Floating-point Maximum (single precision)
 - feq.s: Floating-point Equal (single precision)
 - flt.s: Floating-point Less Than (single precision)
 - fle.s: Floating-point Less Than or Equal (single precision)



# Microarchitecture:

![fpu_schematic](../../assets/images/fpu_schematic.jpg)



# Load And Store Module

> Workflow:
- flw (load word instruction for floating-point words):
   - reads the word in the memory of address specified by the offset in the immediate field and the content of the integer register of address specified by the content of rs1.
   - Writes this word in floating-point register of address specified by the content of rd field.

- fsw (store word instruction for floating-point words): 
   - reads the word in the floating-point register of address specified by the content of rs2.
   - Writes this word in the memory of address specified by the offset in the immediate field and rd field, and the content of the integer register of address specified by the content of rs1.

# Sign Module

> Workflow:
- fsgnj.s: Floating-Point Sign Injection:
   - This instruction computes the result of injecting the sign of one single-precision floating-point operand into another. Specifically, it takes two operands: rs1 and rs2. The sign of the result is taken from rs2, and the magnitude is taken from rs1.
- fsgnjn.s: Floating-Point Sign Injection Negate:
   - This instruction is similar to fsgnj.s, but it negates the sign of the result. It takes two operands, rs1 and rs2. The sign of the result is the negation of the sign of rs2, and the magnitude is taken from rs1.
- fsgnjx.s: Floating-Point Sign Injection XOR:
   - This instruction also performs sign injection, but the sign is the XOR of the signs of the two operands. It takes two operands, rs1 and rs2. The sign of the result is the XOR of the signs of rs1 and rs2, and the magnitude is taken from rs1.

# Move Module

> Workflow:
- fmv.x.w rd, rs1, rs2:
  - Copies the single-precision floating-point number in register f[rs1] to x[rd]
- fmv.w.x rd, rs1, rs2:
  - Copies the single-precision floating-point number in register x[rs1] to f[rd].

# Integer To Float Module

> Workflow:
- Input is integer.
- Output is floating point IEEE 754 format.
  - Handle special cases (NaN, infinity, zero).
  - Determine the position of the MSB 1 in the input to know the exponent.
  - Take form the input the mantissa after knowing the position of MSB 1.
  - Rounding the mantissa by adding one to it if the bit before LSB is one and this bit will be bit 7 if sign converting and bit 8 if unsigned converting. 
  - Combine the sign ,exponent and mantissa in the output
  - Adjust the exponent by subtracting 127 from it.

# Float To Integer Module

> Workflow:
- Input is floating point IEEE 754 format   
- Output is integer
  - Extract exponent,mantissa,sign from the input.
  - Handle special cases (NaN, infinity, zero,overflow,fractions).
  - Adjust the exponent by suntracting 127 from it.
  - Shift from the mantissa by the value of the adjusted exponent.
  - Rounding to the nearest by cheking if manissa[22] =1 or not.
  - Takes the 2’s complement if the number is negative.

# Classify Module

> Workflow:
- classifies the number in rs1 and writes the type in the integer register specified by the rd field.
- Checks the exponent field.
- Then checks the mantissa field.
- Then checks the sign field.
- if both the exponent and mantissa are 0, then it’s a Zero number, if the sign field is 0: +ve Zero writes 4, if the sign field is 1: -ve Zero writes 3.
- if the exponent is 0 and mantissa isn’t 0, then it’s a subnormal number, if the sign field is 0: +ve subnormal writes 5, if the sign field is 1: -ve subnormal writes 2.
- if the exponent is all ones and mantissa is 0, then it’s infinity, if the sign field is 0: +ve infinity writes 7, if the sign field is 1: -ve infinity writes 0.
- if the exponent is all ones and mantissa isn’t 0, then it’s NAN, if the sign field is 0: quiet NAN writes 9, if the sign field is 1: signaling NAN writes 8.
- if the exponent is neither 0 nor all: it’s a normal number, if the sign field is 0: +ve writes 6, if the sign field is 1: -ve writes 1.


# Min. And Max. Module

> Workflow
- Extract the sign, exponent, and mantissa from the floating-point numbers.
- Compare the sign, exponent, and mantissa of the two numbers.
- Calculate the output (min or max) according to the required input.


# Compare Module

> Workflow:
- feq:
  - compares the 2 floating-point numbers.
  - Writes 1 if they are equal and 0 if not.
- flt:
  - compares the 2 floating-point numbers.
  - Writes 1 if the first number (rs1) is less than the second number (rs2) and 0 if not.
- flte:
  - compares the 2 floating-point numbers.
  - Writes 1 if the first number (rs1) is less than or equal to the second number (rs2) and 0 if not.




# Note: 
> This FPU Implementation is Fully Combinational
