module shift_extender(
    input [4:0] in,
    output reg [31:0] out
);
    always @(*) begin
        out = {27'b0, in[4:0]};
    end
endmodule