module offset_extender (
    input [23:0] in,
    output reg [31:0] out
);
    always @(*) begin
        out = {{8{in[23]}}, in[23:0]};
    end
endmodule