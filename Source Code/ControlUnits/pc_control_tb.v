module pc_control_tb();
    reg [1:0]instr_type;
    reg [4:0] opcode;
    reg zero_signal;
    reg stop_bit;
    wire [1:0] pc_src;
    pc_control pc_control_0(instr_type, opcode, zero_signal, stop_bit, pc_src);
    initial begin
        $monitor("instr_type = %b, opcode = %b, zero_signal = %b, stop_bit = %b, pc_src = %b",instr_type, opcode, zero_signal, stop_bit, pc_src);
        instr_type = 2'b00;
        opcode = 5'b00000;
        zero_signal = 0;
        stop_bit = 0;
        #10;
        instr_type = 2'b00;
        opcode = 5'b00000;
        zero_signal = 0;
        stop_bit = 1;
        #10;
        instr_type = 2'b00;
        opcode = 5'b00000;
        zero_signal = 1;
        stop_bit = 0;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00001;
        zero_signal = 0;
        stop_bit = 0;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00010;
        zero_signal = 0;
        stop_bit = 1;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00100; // BEQ instruction
        zero_signal = 1;
        stop_bit = 0;
        #10;
        instr_type = 2'b10;
        opcode = 5'b00100;
        zero_signal = 1;
        stop_bit = 0;
        #10;
        instr_type = 2'b10;
        opcode = 5'b00010;
        zero_signal = 0;
        stop_bit = 0;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00010;
        zero_signal = 0;
        stop_bit = 0;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00010;
        zero_signal = 0;
        stop_bit = 1;
        #10; 
		#30 $finish;
    end

endmodule