module control_unit_tb();
    reg [1:0] instr_type;
    reg [4:0] opcode;
    wire reg_b;
    wire reg_wr;
    wire ext_op;
    wire [1:0] alu_src;
    wire [2:0] alu_op;
    wire mem_read;
    wire mem_write;
    wire wb_src;
    
    control_unit control_unit(
        .instr_type(instr_type),
        .opcode(opcode),
        .reg_b(reg_b),
        .reg_wr(reg_wr),
        .ext_op(ext_op),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .wb_src(wb_src)
    );
    
    initial begin
        instr_type = 2'b00;
        opcode = 5'b00000; // AND
        #10;
        instr_type = 2'b00;
        opcode = 5'b00001; // ADD
        #10;
        instr_type = 2'b00;
        opcode = 5'b00010; // SUB
        #10;
        instr_type = 2'b00;
        opcode = 5'b00011; // CMP
        #10;
        instr_type = 2'b01; 
        opcode = 5'b00000;// ANDI
        #10;
        instr_type = 2'b01; 
        opcode = 5'b00001; // ADDI
        #10;
        instr_type = 2'b01;
        opcode = 5'b00010; // LW
        #10;
        instr_type = 2'b01;
        opcode = 5'b00011; // SW
        #10;
        instr_type = 2'b01;
        opcode = 5'b00100; // BEQ
        #10;
        instr_type = 2'b10;
        opcode = 5'b00000; // J
        #10;
        instr_type = 2'b10;
        opcode = 5'b00001; // JAL
        #10;
        instr_type = 2'b11;
        opcode = 5'b00000; // SLL
        #10;
        instr_type = 2'b11;
        opcode = 5'b00001; // SLR
        #10;
        instr_type = 2'b11;
        opcode = 5'b00010; // SLLV
        #10;
        instr_type = 2'b11;
        opcode = 5'b00011; // SLRV
        #10;
        #30 $finish; 
	end
	initial begin
		// monitor					  
        $monitor("instr_type = %b, opcode = %b, reg_b = %b, reg_wr = %b, ext_op = %b, alu_src = %b, alu_op = %b, mem_read = %b, mem_write = %b, wb_src = %b\n", instr_type, opcode, reg_b, reg_wr, ext_op, alu_src, alu_op, mem_read, mem_write, wb_src);
	end
endmodule