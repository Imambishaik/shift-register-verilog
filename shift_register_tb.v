`timescale 1ns/1ps

module shift_register_tb;

reg clk, rst, din, load;
reg [1:0] sel;
reg [3:0] data_in;

wire [3:0] q;
wire [3:0] sipo_q;
wire dout;

// Instantiate modules
universal_shift_register U1 (
    .clk(clk),
    .rst(rst),
    .sel(sel),
    .din(din),
    .data_in(data_in),
    .q(q)
);

sipo_shift_register U2 (
    .clk(clk),
    .rst(rst),
    .din(din),
    .q(sipo_q)
);

piso_shift_register U3 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .dout(dout)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

// Test sequence
initial begin
    // Initialize
    rst = 1; din = 0; sel = 2'b00; load = 0; data_in = 4'b0000;

    // Reset
    #10 rst = 0;

    // Load into Universal
    #10 sel = 2'b11; data_in = 4'b1011;

    // Shift Right
    #10 sel = 2'b01; din = 1;
    #10 din = 0;

    // Shift Left
    #10 sel = 2'b10; din = 1;
    #10 din = 0;

    // Hold
    #10 sel = 2'b00;

    // SIPO input sequence
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 1;

    // PISO Load
    #10 load = 1; data_in = 4'b1101;
    #10 load = 0;

    // Wait
    #50;

    $stop;
end

endmodule


