// ================= UNIVERSAL SHIFT REGISTER =================
module universal_shift_register (
    input clk,
    input rst,
    input [1:0] sel,      // 00: Hold, 01: Right, 10: Left, 11: Load
    input din,
    input [3:0] data_in,
    output reg [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else begin
        case (sel)
            2'b00: q <= q;                    // Hold
            2'b01: q <= {din, q[3:1]};        // Shift Right
            2'b10: q <= {q[2:0], din};        // Shift Left
            2'b11: q <= data_in;              // Load
        endcase
    end
end

endmodule


// ================= SIPO =================
module sipo_shift_register (
    input clk,
    input rst,
    input din,
    output reg [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else
        q <= {q[2:0], din};
end

endmodule


// ================= PISO =================
module piso_shift_register (
    input clk,
    input rst,
    input load,
    input [3:0] data_in,
    output reg dout
);

reg [3:0] temp;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        temp <= 4'b0000;
        dout <= 0;
    end
    else if (load)
        temp <= data_in;
    else begin
        dout <= temp[3];
        temp <= {temp[2:0], 1'b0};
    end
end

endmodule
