/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_sidharth6761_LP_multiplier4b (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n,
    inout  wire       VPWR,
   
);

wire [3:0] a;
wire [3:0] b;
wire [7:0] y;

assign a = ui_in[3:0];
assign b = ui_in[7:4];

multiplier m1 (
    .a(a),
    .b(b),
    .y(y)
);

// Output mapping    
  assign uo_out = y;
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule


module multiplier(
    input [3:0] a,
    input [3:0] b,
    output [7:0] y
);

wire [1:0] pe1, pe2;
wire v1, v2;

reg [1:0] ka, kb;
reg [2:0] k;
reg [7:0] Xa, Xb, s;
reg [2:0] OMUX;

encoder e1(.in(a), .out(pe1), .valid(v1));
encoder e2(.in(b), .out(pe2), .valid(v2));

always @(*) begin

ka = 0;
kb = 0;
k  = 0;
Xa = 0;
Xb = 0;
s  = 0;
OMUX = 0;
if(a == 0 || b == 0)
begin
    Xa = 0;
    Xb = 0;
    s = 0;
    k = 0;
    ka=0;
    kb=0;
end
else
begin
    ka = pe1;
    kb = pe2;

    Xa = a << kb;
    Xb = b << ka;

    s = Xa + Xb;
    k = ka + kb;
end
    if (s[k] == 1'b0)
        OMUX = {~s[k], s[k-1 -:2]};
    else if (k==1'b0)
        OMUX =1'b0;    
    else
        OMUX = s[k-1 -:3];
end

assign y = (k > 1) ? ({s[k], OMUX, {5{1'b1}}} >> (6-(k-1))) : 0;

endmodule




module encoder(
    input [3:0] in,
    output reg [1:0] out,
    output reg valid
);
always @(*) begin
    valid = 1'b1;
    casex(in)
        4'b1xxx: out = 2'd3;
        4'b01xx: out = 2'd2;
        4'b001x: out = 2'd1;
        4'b0001: out = 2'd0;
        default: begin
            out = 2'd0;
            valid = 1'b0;
        end
    endcase
end
endmodule

