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
if(a == 0 || b == 0)
begin
    Xa = 0;
    Xb = 0;
    s = 0;
    k = 0;
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
