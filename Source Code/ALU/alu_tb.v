module alu_tb;
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] op;
    wire [31:0] out;

    alu alu(a, b, op, out);

    initial begin
        a = 0;
        b = 0;
        op = 0;
        #10;
        a = 32'h0000000f;
        b = 32'h00000004;
        op = 3'b000;	 //ADD
        #10;
        $display("a = %h, b = %h, operation = %h, out = %h",a,b,op,out);
        #10;
        op = 3'b001;  // SUB
        #10;
        $display("a = %h, b = %h, operation = %h, out = %h",a,b,op,out);
        #10;
		a = 32'h00001111;
		b = 32'h00000004;
		op = 3'b010; // AND
		#10
		$display("a = %h, b = %h, operation = %h, out = %h",a,b,op,out);
		#10
		a = 32'h00000001;
		b = 32'h00000002;
		op = 3'b011; // Logical Shift Left
		#10
		$display("a = %h, b = %h, operation = %h, out = %h",a,b,op,out);
		#10
        $finish;
    end
endmodule
