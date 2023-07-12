// buile alu module here
module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] op,
    output reg [31:0] out
);
    always @(*) begin
        case (op)
            3'b000: out = a + b;
            3'b001: out = a - b;
            3'b010: out = a & b;
            3'b011: out = a << b;
            3'b100: out = a >> b;
        endcase
    end
endmodule
// build alu test bench here
