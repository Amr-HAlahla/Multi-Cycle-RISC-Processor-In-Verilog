module stack_control_tb();
    reg [1:0] instr_type;
    reg [4:0] opcode;
    reg stop_bit;
    reg [31:0] sp;
    wire push;
    wire pop;
    wire [31:0] next_sp;

    stack_control stack_control_0(
        .instr_type(instr_type),
        .opcode(opcode),
        .stop_bit(stop_bit),
        .push(push),
        .pop(pop),
        .sp(sp),
        .next_sp(next_sp)
    );

    initial begin
        instr_type = 2'b00;
        opcode = 5'b00000; // AND
        stop_bit = 0;
        sp = 32'h00000008;
        #10;
        instr_type = 2'b00;
        opcode = 5'b00001; // ADD
        stop_bit = 0;
        #10;
        instr_type = 2'b00;
        opcode = 5'b00010; // SUB
        stop_bit = 0;
        #10;
        instr_type = 2'b00;
        opcode = 5'b00011; // CMP
        stop_bit = 1;
        #10;
        instr_type = 2'b01; 
        opcode = 5'b00000;// ANDI
        stop_bit = 0;
        #10;
        instr_type = 2'b01; 
        opcode = 5'b00001; // ADDI
        stop_bit = 0;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00010; // LW
        stop_bit = 0;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00011; // SW
        stop_bit = 0;
        #10;
        instr_type = 2'b01;
        opcode = 5'b00100; // BEQ
        stop_bit = 0;
        #10;
        instr_type = 2'b10;
        opcode = 5'b00000; // J
        stop_bit = 0;
        #10;
        instr_type = 2'b10;
        opcode = 5'b00001; // JAL
        stop_bit = 0;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00000; // SLL
        stop_bit = 1;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00001; // SLR
        stop_bit = 0;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00010; // SLLV
        stop_bit = 1;
        #10;
        instr_type = 2'b11;
        opcode = 5'b00011; // SLRV
        stop_bit = 1;
        #10;
        #10 $finish;
    end
    initial begin
        $monitor("instr_type = %b, opcode = %b, push = %b, pop = %b, sp = %h, next_sp = %h\n", instr_type, opcode, push, pop, sp, next_sp);
    end
endmodule