// test bench for stack_memory.v
module stack_memory_tb;
    reg [31:0] stack_pointer;
    reg [31:0] data_in;
    reg pop;
    reg push;
    wire [31:0] data_out;

    stack_memory mem(stack_pointer, pop, data_in, push, data_out);

    initial begin
        stack_pointer = 0;
        data_in = 0;
        push = 0;
        pop = 0;
        #10;
        push = 1;
        data_in = 32'hdeadbeef;
        stack_pointer = 0;
        #10;
        push = 0;
        pop = 1;
        stack_pointer = 0;
        #10;
        $display("data_out = %h", data_out);
        #10;
        $finish;
    end
endmodule