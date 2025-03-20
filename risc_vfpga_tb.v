`timescale 1ns / 1ps

module riscv_fpga_tb;

    reg clk;
    reg reset;
    reg uart_rx;
    wire uart_tx;
    wire [7:0] gpio;

    // Instantiate the FPGA RISC-V module
    riscv_fpga uut (
        .clk(clk),
        .reset(reset),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx),
        .gpio(gpio)
    );

    always #5 clk = ~clk; // Generate a 10ns clock cycle (100 MHz)

    initial begin
        $dumpfile("riscv_fpga_tb.vcd");
        $dumpvars(0, riscv_fpga_tb);

        clk = 0;
        reset = 1;
        uart_rx = 1;
        #20 reset = 0; // Release reset after 20ns

        #1000; // Run simulation for 1000ns
        $display("GPIO Output: %b", gpio);
        if (gpio === 8'bXXXXXXXX) begin
            $display("ERROR: GPIO is still undefined!");
        end else begin
            $display("GPIO is correctly assigned.");
        end
        $finish; // Properly stop simulation
    end

endmodule
