module control_unit(input [1:0] instr_type, input [4:0] opcode,
    output reg reg_b,
    output reg reg_wr,
    output reg ext_op,
    output reg [1:0] alu_src,
    output reg [2:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg wb_src
);

    reg s4,s3,s2,s1,s0;
    always @(*)begin
        reg_b = (opcode == 5'b00100 && instr_type == 2'b01) ? 1'b1 : 1'b0; // BEQ && I-type
        reg_wr = (instr_type == 2'b00 && opcode != 5'b00011) || (instr_type == 2'b01 && opcode != 5'b00011 && opcode != 5'b00100) || (instr_type == 2'b11) ? 1'b1 : 1'b0;
        ext_op = ~(instr_type == 2'b01 && opcode == 5'b00000) ? 1'b1 : 1'b0; // ADDI && I-type
        s1 = (instr_type == 2'b11 && (opcode == 5'b00000 || opcode == 5'b00001))? 1'b1 : 1'b0;
        s0 = (instr_type == 2'b00 || (instr_type == 2'b01 && opcode == 5'b00100) || (instr_type == 2'b11 && (opcode == 5'b00010 || opcode == 5'b00011))) ? 1'b1 : 1'b0;
        alu_src = {s1,s0}; // ALU source 
		
        s4 = (instr_type == 2'b11 && (opcode == 5'b00001 || opcode == 5'b00011));
        s3 = ((instr_type == 2'b00 && opcode == 5'b00000) || (instr_type == 2'b01 && opcode == 5'b00000) || (instr_type == 2'b11 && opcode == 5'b00000) || (instr_type == 2'b11 && opcode == 5'b00010));
        s2 = ((instr_type == 2'b00 && (opcode == 5'b00010 || opcode == 5'b00011)) || (instr_type == 2'b01 && opcode == 5'b00100) || (instr_type == 2'b11 && opcode == 5'b00000) || (instr_type == 2'b11 && opcode == 5'b00010)) ? 1'b1 : 1'b0;
        alu_op = {s4,s3,s2}; // ALU operation
		
        mem_read = (opcode == 5'b00010 && instr_type == 2'b01) ? 1'b1 : 1'b0; // LW && I-type
        mem_write = (opcode == 5'b00011 && instr_type == 2'b01) ? 1'b1 : 1'b0; // SW && I-type
        wb_src = (opcode == 5'b00010 && instr_type == 2'b01) ? 1'b1 : 1'b0; // LW && I-type
        // set alu_op
		/*
		if(instr_type == 2'b00) begin
            case(opcode)
                5'b00000: alu_op = 3'b010; // AND
                5'b00001: alu_op = 3'b000; // ADD
                5'b00010: alu_op = 3'b001; // SUB
                5'b00011: alu_op = 3'b001; // SUB (CMP)
				default: alu_op = 3'b000;
            endcase
        end
        else if(instr_type == 2'b01) begin
            case(opcode)
                5'b00000: alu_op = 3'b010; // ANDI
                5'b00001: alu_op = 3'b000; // ADDI
                5'b00010: alu_op = 3'b000; // ADD (LW)
                5'b00011: alu_op = 3'b000; // ADD (SW)
                5'b00100: alu_op = 3'b001; // BEQ
				default: alu_op = 3'b000;
            endcase
        end
        else if(instr_type == 2'b11) begin
            case(opcode)
                5'b00000: alu_op = 3'b011; // Logical Shift Left
                5'b00001: alu_op = 3'b100; // logical Shift Right
                5'b00010: alu_op = 3'b011; // logical Shift Left
                5'b00011: alu_op = 3'b100; // logical Shift Right
				default: alu_op = 3'b000;
            endcase
        end	
		*/
        /*
        or 
        reg_wr = (instr_type != 2'b10) || ~(instr_type == 2'b01 && opcode == 5'b00011) || ~(instr_type == 2'b01 && opcode == 5'b00100) || ~(instr_type == 2'b00 && opcode == 5'b00011) ? 1'b1 : 1'b0;
        */
        
        /*if((instr_type == 2'b01 && opcode == 5'b00000) == 1'b0) begin
            ext_op = 1'b1; // NOT ADDI instruction
        end*/
    end

endmodule