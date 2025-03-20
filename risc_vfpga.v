`timescale 1ns / 1ps

module riscv_fpga (
    input wire clk,        // FPGA clock
    input wire reset,      // Reset signal
    input wire uart_rx,    // UART receive
    output reg uart_tx,    // UART transmit
    output reg [7:0] gpio  // General-purpose output
);

    reg [31:0] pc;  // Program Counter
    reg [31:0] instr_memory [0:31];  // Instruction memory (BRAM)
    reg [31:0] registers [0:31];  // Register file
    reg [31:0] instruction;
    
    wire [6:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7;

    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct7 = instruction[31:25];

    // ✅ Ensure GPIO is initialized to prevent "XX"
    initial begin
        pc = 0;
        gpio = 8'b00000000;  // ✅ Initialize GPIO properly
        uart_tx = 1;         // ✅ Set UART to idle state
        registers[0] = 0;    // ✅ Ensure register[0] is zero
        registers[1] = 0;
        registers[2] = 0;
        registers[3] = 0;

        // ✅ Properly initialize instruction memory
        instr_memory[0] = 32'b00000000001000000000000010010011; // ADDI x1, x0, 2
        instr_memory[1] = 32'b00000000001100000000000100010011; // ADDI x2, x0, 3
        instr_memory[2] = 32'b00000000001000001000000110110011; // ADD x3, x1, x2
        instr_memory[3] = 32'b01000000001000010000000110110011; // SUB x3, x1, x2
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            gpio <= 8'b00000000;  // ✅ Reset GPIO properly
            uart_tx <= 1;         // ✅ Keep UART in idle state
        end else begin
            instruction <= instr_memory[pc >> 2]; // Fetch instruction
            case (opcode)
                7'b0010011: registers[rd] <= registers[rs1] + instruction[31:20]; // ADDI
                7'b0110011: begin
                    case (funct3)
                        3'b000: registers[rd] <= funct7[5] ? registers[rs1] - registers[rs2] : registers[rs1] + registers[rs2]; // ADD/SUB
                    endcase
                end
            endcase

            // ✅ Make sure GPIO always gets a value
            if (rd != 0) begin
                gpio <= registers[rd][7:0];  // ✅ Assign from valid register
            end else begin
                gpio <= 8'b00000001;  // ✅ Default fallback value
            end

            pc <= pc + 4; // Increment PC
        end
    end

endmodule
