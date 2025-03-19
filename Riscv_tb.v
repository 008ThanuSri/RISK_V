`timescale 1ns / 1ps

module riscv_cpu_tb;

    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [6:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;

    // Instantiate the CPU module
    riscv_cpu uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct3(funct3)
    );

    // Clock Generation (100MHz, Period = 10ns)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply Reset
        #10 reset = 0;

        // Run Simulation for Some Cycles
        #200;  // Extend simulation time to check memory bounds

        // Stop simulation
        $finish;
    end

    // Debugging Monitor
    initial begin
        $monitor("Time = %0t | PC = %h | Opcode = %b | rs1 = %d | rs2 = %d | rd = %d | funct3 = %b", 
              $time, pc, opcode, rs1, rs2, rd, funct3);
    end

endmodule
