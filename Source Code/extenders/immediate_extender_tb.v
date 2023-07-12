// test bench for immediate_extender.v
module immediate_extender_tb;
    reg [31:0] in;
    reg op;
    wire [31:0] out;

    immediate_extender extender(in, op, out);

    initial begin
        in = 0;
        op = 0;
        #10;
        in = 32'hdeadbeef;
        op = 0;
        #10;
        $display("out = %h", out);
        #10;
        op = 1;
        #10;
        $display("out = %h", out);
        #10;
        $finish;
    end
endmodule