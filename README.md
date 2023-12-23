# MES-RISCV
Single Cycle RISC-V processor extended by Single Precision Floating Point Unit (IEEE 754).

# Table of Contents:

- [Introduction](#Introduction)
- [Microarchitecture](#Microarchitecture)
- [Directory Structure](#directory-structure)
- [References](#References)
- [Contributors](#contributors)

# Introduction
RISC-V is an open-source computer architecture that allows for flexible design of processors. Its simplicity and openness encourage innovation, making it suitable for various applications, from small embedded systems to high-performance computing. Essentially, RISC-V aims to democratize processor design, fostering collaboration and advancing computing technology.

  - RV32F in RISC-V:RV32F is a specific variant of the RISC-V instruction set architecture.
    
  - 32-Bit Architecture: The "RV32" in RV32F indicates a 32-bit architecture, which is commonly used in systems with resource constraints.
    
  - Floating-Point Support: The "F" in RV32F signifies support for floating-point instructions, making it suitable for tasks such as scientific computing, signal processing, and graphics.
  
  - Resource-Constrained Systems: RV32F is often chosen for systems where factors like memory and power are critical, and a balance between performance and resource efficiency is essential.
  
  - Standardized Framework: The RV32F specification provides a standardized framework for implementing processors. This ensures compatibility and facilitates integration across diverse hardware platforms that adhere to the RISC-V standard.

# Microarchitecture

![risc.bold](/assets/images/risc.bold.png)

# Directory Structure:
  * [README](./README.md): This file.
  * [RISC-V](./src/): TOP.
  * [FPU](./src/FPU/): Floating Point Unit.
  * [Test](./test/): Test Files and results.

# References
- The RISC-V Instruction Set Manual-Volume I: User-Level ISA-Document Version 2.2
- The RISC-V Reader:An Open Architecture Atlas-Beta Edition, 0.0.1-David Patterson and Andrew Waterma
- https://www.proquest.com/docview/1622629195
- https://baseconvert.com/ieee-754-floating-point
- https://luplab.gitlab.io/rvcodecjs/
- http://weitz.de/ieee/
- https://upcommons.upc.edu/bitstream/handle/2099.1/15467/32BitFloatingPointAdder.pdf


# Contributors:
- Designed By: (listed alphabetically)
  - [Eman Ezzat](emanezzat4018@gmail.com)
  - [Mohamed Sharaf](sharafm823@gmail.com)
  - [Shohrt Helmy](shohrthelmy@gmail.com) 
