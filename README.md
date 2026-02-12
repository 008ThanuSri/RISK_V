# RISC_V
A simple RISC-V CPU (Instruction Fetch &amp; Decode) implemented in Verilog and tested in Xilinx Vivado.  It features a Program Counter (PC), Instruction Memory (ROM), and an Instruction Decoder.
This is a **basic RISC-V CPU** that implements **instruction fetching and decoding** in **Verilog**, and is tested in **Xilinx Vivado**.

 Features
- Implements Program Counter (PC) update
- Instruction Memory (ROM) that stores predefined instructions  
- Decodes RISC-V instructions (Opcode, Registers, Function bits)  
- Runs in Xilinx Vivado (AMD/Xilinx) 
- Verilog Testbench is included for validation.
Extended Work: FPGA-ready implementation
- BRAM for instruction storage
- GPIO Output for Debugging
- Vivado Constraints File (riscv_fpga.xdc) for FPGA pin mapping

---

**1. Files in This Repository
|    File Name           |  Description                      |
|-------------------------|----------------------------------|
| `riscv_cpu.v`           | RISC-V CPU Verilog code          |
| `riscv_cpu_tb.v`        | Testbench for simulation         |
|  'riscv_fpga.v'       |	FPGA-ready version of the RISC-V CPU |
|  'riscv_fpga_tb.v'	    |    Testbench for FPGA implementation|
| `vivado_simulation.png` | Screenshot of working simulation |
| `README.md`             | This documentation file          |

---

**2. How to Run the Simulation in Vivado
   Step 1: Open Vivado**
i. Open **Xilinx Vivado**  
ii. Create a **new project** (Language: Verilog)
iii. Add `riscv_cpu.v` and `riscv_cpu_tb.v` to the project   
     (In extension (add 'riscv_fpga.v' and 'riscv_fpga_tb.v' to the project)).
     

    Step 2: Run Behavioral Simulation
iv. Click **"Run Simulation"** → **"Run Behavioral Simulation"**  
v. Observe the **PC incrementing and instruction decoding**  

---

**3. Expected Simulation Output:
Time = 0 | PC = 00000000 | Opcode = 0010011 | rs1 = 0 | rs2 = 0 | rd = 1 | funct3 = 000 Time = 10ns | PC = 00000004 | Opcode = 0010011 | rs1 = 1 | rs2 = 0 | rd = 2 | funct3 = 000 Time = 20ns | PC = 00000008 | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000 Time = 30ns | PC = 0000000C | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000 Time = 40ns | PC = 00000010 | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000 Time = 50ns | PC = 00000014 | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000 Time = 60ns | PC = 00000018 | Opcode = 0000000 | rs1 = 0 | rs2 = 0 | rd = 0 | funct3 = 000 Time = 70ns | PC = 0000001C | Opcode = 0000000 | rs1 = 0 | rs2 = 0 | rd = 0 | funct3 = 000
Time = 0    | PC = 00000000 | Opcode = 0010011 | rs1 = 0 | rs2 = 0 | rd = 1 | funct3 = 000
Time = 10ns | PC = 00000004 | Opcode = 0010011 | rs1 = 1 | rs2 = 0 | rd = 2 | funct3 = 000
Time = 20ns | PC = 00000008 | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000
Time = 30ns | PC = 0000000C | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000
Time = 40ns | PC = 00000010 | Opcode = 0110011 | rs1 = 1 | rs2 = 2 | rd = 3 | funct3 = 000

---

**4. Vivado Simulation Output
Below is the waveform from **Xilinx Vivado** showing the correct behavior of the RISC-V CPU:

Vivado Simulation Output
[image](https://github.com/user-attachments/assets/dcd76957-fcb1-4428-801c-9b1b313503f8)

 With FPGA (after FPGA implementation).
 ![image](https://github.com/user-attachments/assets/692ac622-a22b-4a72-9adc-c86314a09d04)

**About the FPGA Implementation
The FPGA version of the RISC-V CPU expands upon the basic simulation by adding: 
BRAM (Block RAM) for instruction storage
GPIO Output for Debugging
Vivado Constraints File (riscv_fpga.xdc) for FPGA pin mapping

--> Steps to Implement on FPGA
Step 1: Open Vivado
Create a new Vivado project.
Select your FPGA board 
Add riscv_fpga.v.
Step 2: Run Synthesis & Implementation
Click "Run Synthesis" → Fix any warnings/errors.
Click "Run Implementation".
Step 3: Generate Bitstream & Program FPGA
Click "Generate Bitstream".
Upload the bitstream to the FPGA.

 
**5.Future improvement
  - Implement Load/Store operations to access memory
  - Integrate Branching (BEQ, BNE)


**6. Contact Information  
   GitHub Repository: https://github.com/008ThanuSri/RISK_V 
   Email: thanusrigandham008@gmail.com 
   LinkedIn:  www.linkedin.com/in/thanusri-gandham  
