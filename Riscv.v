module riscv_cpu (
    input wire clk,         // Clock signal
    input wire reset,       // Reset signal
    output reg [31:0] pc,   // Program Counter (PC)
    output reg [6:0] opcode, // Decoded opcode
    output reg [4:0] rs1,   // Source register 1
    output reg [4:0] rs2,   // Source register 2
    output reg [4:0] rd,    // Destination register
    output reg [2:0] funct3 // Function bits
);

    reg [31:0] instr_memory [0:7]; // Simple instruction ROM (8 instructions)
    reg [31:0] instruction; // Holds the fetched instruction

    // Initialize Instruction Memory (ROM)
    initial begin
        instr_memory[0] = 32'b00000000001000001000000010010011; // ADDI x1, x0, 2
        instr_memory[1] = 32'b00000000001100010000000100010011; // ADDI x2, x1, 3
        instr_memory[2] = 32'b00000000001000001000000110110011; // ADD x3, x1, x2
        instr_memory[3] = 32'b01000000001000010000000110110011; // SUB x3, x1, x2
        instr_memory[4] = 32'b00000000001000001000000110110011; // AND x3, x1, x2
        instr_memory[5] = 32'b00000000001000001000000110110011; // OR x3, x1, x2
        instr_memory[6] = 32'b00000000000000000000000000000000; // NOP
        instr_memory[7] = 32'b00000000000000000000000000000000; // NOP
    end

    // PC Logic (Ensure It Stays Within Memory Bounds)
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else if (pc < 28) // 7 instructions * 4 bytes = 28 bytes max
            pc <= pc + 4;  // Increment PC by 4
    end

    // Instruction Fetch (Reading from ROM) - Fix for XXXXXX Issue
    always @(posedge clk) begin
        if (pc < 32)  // Check memory bounds
            instruction <= instr_memory[pc >> 2]; // Fetch instruction from memory
        else
            instruction <= 0; // If out of range, fetch NOP
    end

    // Instruction Decode
    always @(posedge clk) begin
        opcode  <= instruction[6:0];   // Opcode
        rd      <= instruction[11:7];  // Destination Register
        funct3  <= instruction[14:12]; // Function bits
        rs1     <= instruction[19:15]; // Source Register 1
        rs2     <= instruction[24:20]; // Source Register 2
    end

endmodule

