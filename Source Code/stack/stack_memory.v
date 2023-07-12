module stack_memory(
    input [31:0] stack_pointer, input pop, input [31:0] data_in,
    input push, output reg [31:0] data_out );

    reg [31:0] mem [0:1023]; // Assuming 1024 32-bit words in memory
    always @(*) begin
        if (push) begin
            mem[stack_pointer] <= data_in;
        end
        else if (pop) begin
            data_out <= mem[stack_pointer];
        end
    end
    // Initialize memory with some random values
    initial begin
        integer i;
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i] = i;
        end
    end
endmodule