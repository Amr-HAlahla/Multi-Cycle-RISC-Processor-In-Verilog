module instruction_memory_tb;
    reg [31:0] addr; 
    wire [31:0] data_out;

    instruction_memory mem(addr, data_out);

    initial begin		 
        addr = 0;
        #10;
        $display("Instruction = %h", data_out);
        #10;	
		addr = 1;
        #10;
        $display("Instruction = %h", data_out);
        #10; 
		addr = 2;
        #10;
        $display("Instruction = %h", data_out);
        #10;
		addr = 3;
        #10;
        $display("Instruction = %h", data_out);
        #10;
		addr = 4;
        #10;
        $display("Instruction = %h", data_out);
        #10;
		addr = 5;
        #10;
        $display("Instruction = %h", data_out);
        #10;
        $finish;
    end
endmodule
