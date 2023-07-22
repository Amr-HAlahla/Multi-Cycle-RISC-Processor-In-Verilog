module MCRP(input clk,reset,
    output reg [1:0] pc_src_out, // pc source
    output reg ext_op_out, // extend operation
    output reg [2:0] alu_op_out, // alu operation
    output reg [1:0] alu_src_out, // alu source
    output reg mem_write_out, // memory write
    output reg mem_read_out, // memory read
    output reg reg_write_out, // register write
    output reg wb_src_out, // write back source
    output reg stack_write_out, // stack write
    output reg stack_read_out, // stack read
    output reg zero_signal_out, // zero signal
    output reg [31:0] pc_out, // program counter output
    output reg [31:0] ir_out, // instruction register output
    output reg [31:0] a_out, // first operand output
    output reg [31:0] b_out, // second operand output
    output reg [31:0] alu_result, // output of ALU
    output reg [31:0] mem_result, // output of memory
    output reg [31:0] wb_result, // return address output  
    output reg reg_src_out, // register source
);

    // define the instructions 
    // R tpye
    parameter AND = 5'b00000;
    parameter ADD = 5'b00001;
    parameter SUB = 5'b00010;
    parameter CMP = 5'b00011;
    // I type
    parameter ANDI = 5'b00000;
    parameter ADDI = 5'b00001;
    parameter LW = 5'b00010;
    parameter SW = 5'b00011;
    parameter BEQ = 5'b00100;
    // J-type (J, JAL)
    parameter J = 5'b00000;
    parameter JAL = 5'b00001;
    // S-type(SLL,SLR,SLLV,SLRV)
    parameter SLL = 5'b00000;
    parameter SLR = 5'b00001;
    parameter SLLV = 5'b00010;
    parameter SLRV = 5'b00011;

    // define the alu operations
    parameter ADD_OP = 3'b000;
    parameter SUB_OP = 3'b001;
    parameter AND_OP = 3'b010;
    parameter SLL_OP = 3'b011;
    parameter SLR_OP = 3'b100;
    
    // define the states
    parameter IF = 3'b000;
    parameter ID = 3'b001;
    parameter EX = 3'b010;
    parameter MEM = 3'b011;
    parameter WB = 3'b100;

    // define the state variable
    reg [2:0] state; // state variable
    reg [2:0] next_state; // next state variable

    reg [31:0] sp; // stack pointer
    reg [31:0] next_pc; // next program counter
    reg [31:0] pc; // program counter
    wire [31:0] ir; // instruction register
    wire [31:0] a; // first operand
    wire [31:0] b; // second operand
    wire [31:0] alu_out; // output of ALU
    wire [31:0] mem_out; // output of memory
    wire [31:0] RA; // return address
    reg [31:0] BTA; // branch target address
    reg [31:0] JA; // jump address
    wire [31:0] extended_immediate; // sign extended immediate
    wire [31:0] extended_offset; // sign extended offset
    wire [31:0] SA_extended; // unsign extended SA
    reg [31:0] alu_second_operand; // second operand of ALU
    reg [31:0] wb_data; // data to be written back to register file
    reg [31:0] memory_address; // memory address
    // define the ir fields 
    reg [4:0] opcode; // opcode
    reg [4:0] rs1; // rs
    reg [4:0] rs2; // rt
    reg [4:0] rd; // rd
    reg [4:0] shamt; // shamt
    reg [13:0] immediate; // immediate
    reg [23:0] offset; // offset
    reg [1:0] instruction_type; // instruction type
    reg stop_bit; // stop bit

    //define the control signals as wires
    wire [1:0] pc_src; // pc source
    wire reg_b; // register source
    wire reg_write; // register write
    wire ext_op; // extend operation
    wire [1:0] alu_src; // alu source
    wire [2:0] alu_op; // alu operation
    wire mem_read; // memory read
    wire mem_write; // memory write
    wire wb_src; // write back source
    wire stack_write; // stack write
    wire stack_read; // stack read
    reg zero_signal; // zero signal
    wire next_sp = 0; // next stack pointer

    // define the modules
    instruction_memory im(pc,ir); // instruction memory module
    register_file rf(clk, rs1, rs2, rd, wb_data, reg_write, a, b); // register file module
    alu alu(a, alu_second_operand, alu_op, alu_out); // alu module 
    memory mem(clk, memory_address, b,  mem_write, mem_read, mem_out); // memory module
    stack_memory stack(sp, stack_read, pc, stack_write, RA); // stack module
    immediate_extender ext(immediate, ext_op, extended_immediate); // extender module
    shift_extender shift(shamt, SA_extended); // shift extender module
    offset_extender offset_ext(offset, extended_offset); // offset extender module    
    pc_control pc_ctrl(instruction_type, opcode, zero_signal, stop_bit, pc_src); // pc control module
    control_unit ctrl(instruction_type, opcode, reg_b, reg_write, ext_op, alu_src, alu_op, mem_read, mem_write, wb_src); // control unit module    
    stack_control stack_ctrl(instruction_type, opcode, stop_bit, sp, stack_read, stack_write, next_sp); // stack control module	
	assign sp = next_sp; // assign the next stack pointer to the stack pointer	
    // define the state transition logic
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            next_state = IF;
            // reset all the registers
            //sp = 32'h00000000;
            pc = 32'h00000000;
            next_pc = 32'h00000000;
            alu_second_operand = 32'h00000000;
            wb_data = 32'h00000000;
            memory_address = 32'h00000000;
            zero_signal = 1'b0;

            // reset all the ir fields
            opcode = 5'h00;
            rs1 = 5'h00;
            rs2 = 5'h00;
            rd = 5'h00;
            shamt = 5'h00;
            immediate = 14'h0000;
            offset = 24'h000000;
            instruction_type = 2'b00;
            stop_bit = 1'b0;
            #10;
        end
        else begin
            state = next_state;
            case(state)
            IF: begin
                next_pc <= pc + 32'h00000001; // increment the pc by 1, next_pc = 7 => 8 
                if (pc_src == 2'b00) begin
                    pc = next_pc;
                end
                else if (pc_src == 2'b01) begin
                    pc = BTA;
                    next_pc <= BTA + 32'b00000001;
                end
                else if (pc_src == 2'b10) begin
                    pc = JA;  // pc = 4
                    next_pc <= JA + 32'b00000001; // next_pc = 5
                end
                else if (pc_src == 2'b11) begin
                    pc = RA;
                    next_pc <= RA + 32'b00000001;
                end
				#30;
                pc_out = pc;
                pc_src_out = pc_src;
                
            end
            ID: begin
				# 50;
                // calculate the ir fields and the control signals
                opcode = ir[31:27];
                instruction_type = ir[2:1];
                rs1 = ir[26:22];
                rd = ir[21:17];
                rs2 = ir[16:12];
                shamt = ir[11:7];
                immediate = ir[16:3];
                offset = ir[26:3];
                stop_bit = ir[0];  
				#30;
                // prepare branch address and jump address
                JA = pc + extended_offset; // jump address
                BTA = next_pc + extended_immediate; // branch target address
				#30;
                ir_out = ir;
                a_out = a;
                b_out = b;
                ext_op_out = ext_op;
                reg_write_out = reg_write;
                reg_src_out = reg_b;
                alu_op_out = alu_op;
                alu_src_out = alu_src;
                mem_write_out = mem_write;
                mem_read_out = mem_read;
                wb_src_out = wb_src;
                stack_write_out = stack_write;
                stack_read_out = stack_read; 
				#20;
            end
            EX: begin 
				#30;
                // fine the second alu operand
                if (alu_src == 2'b00) begin
                    alu_second_operand = extended_immediate;
                end
                else if (alu_src == 2'b01) begin
                    alu_second_operand = b;
                end
                else if (alu_src == 2'b10) begin
                    alu_second_operand = SA_extended;
                end
				#30;
                // set zero flag
                if(instruction_type == 2'b00)begin
                    if(opcode == CMP) begin
                        if (alu_out < 0) begin 
                            zero_signal = 1'b1;
                        end
                        else begin
                            zero_signal = 1'b0;
                        end 
                    end
                end    
                else if(instruction_type == 2'b01)begin
                    if(opcode == BEQ) begin
                        if (alu_out == 0) begin 
                            zero_signal = 1'b1;
                        end
                        else begin
                            zero_signal = 1'b0;
                        end
                    end
                end	
                alu_result = alu_out;
                zero_signal_out = zero_signal;
            end    
            MEM: begin
                memory_address = alu_out; // set memory address
				#150; // delay for read from memory operation.
                mem_result = mem_out; 
            end
            WB: begin 
                if (wb_src == 1'b0) begin
                    wb_data = alu_out;
                end
                else if (wb_src == 1'b1) begin
                    wb_data = mem_out;
                end
				#20;
                wb_result = wb_data;
            end
        endcase 

        case(state)
            IF: begin
                next_state = ID;
            end
            ID: begin
                if (instruction_type == 2'b10) begin
                    next_state = IF;
                end
                else begin
                    next_state = EX;
                end
            end
            EX: begin
                if (instruction_type == 2'b00) begin
                    if (opcode == CMP) begin
                        next_state = IF; // no write back
                    end
                    else begin
                        next_state = WB; // write back
                    end
                end
                else if(instruction_type == 2'b01) begin
                    if (opcode == LW || opcode == SW) begin
                        next_state = MEM;
                    end
                    else begin
                        next_state = WB;
                        end
                end
                else if(instruction_type == 2'b11) begin
                    next_state = WB;
                end
            end
            MEM: begin
                if (opcode == LW) begin
                    next_state = WB;
                end
                else begin
                    next_state = IF;
                end
            end
            WB: begin
                next_state = IF;
            end
        endcase 
        // set output control signals 
        // pc_src_out = pc_src;
        // ext_op_out = ext_op;
        // reg_write_out = reg_write;
        // reg_src_out = reg_b;
        // alu_op_out = alu_op;
        // alu_src_out = alu_src;
        // mem_write_out = mem_write;
        // mem_read_out = mem_read;
        // wb_src_out = wb_src;
        // stack_write_out = stack_write;
        // stack_read_out = stack_read;
        // zero_signal_out = zero_signal;
        end
    end
endmodule
