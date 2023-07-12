module immediate_extender (
    input [31:0] in,
    input op,
    output reg [31:0] out
);
    always @(*) begin
        case (op)
            2'b0: out = {18'b0, in[13:0]}; // unsigned immediate (zero extend)
            2'b1: out = {{18{in[13]}}, in[13:0]}; // signed immediate (sign extend)
        endcase
    end
endmodule
