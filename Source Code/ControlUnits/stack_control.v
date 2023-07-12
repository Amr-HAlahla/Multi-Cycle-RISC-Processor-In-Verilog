module stack_control(
    input [1:0] instr_type,
    input [4:0] opcode,
    input stop_bit,
    input [31:0] sp,
    output reg push,
    output reg pop,
    output reg [31:0] next_sp
);

    always @* begin
        if (instr_type == 2'b10 && opcode == 5'b00001) begin // JAL
        push = 1;
        pop = 0;
        next_sp = sp + 1;  // push return address onto stack
    end
    else if(stop_bit) begin // end of function, get return address
        push = 0;
        pop = 1;
        next_sp = sp - 1; // pop return address off stack
    end
    else begin
        push = 0;
        pop = 0;
        next_sp = sp;
    end
    end
endmodule