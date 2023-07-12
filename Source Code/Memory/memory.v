module memory (	 
	input clk,
    input  [31:0] addr,
    input  [31:0] data_in,
    input  write_signal,
    input  read_signal,
    output reg [31:0] data_out
);
    reg [31:0] mem [0:1023]; // Assuming 1024 32-bit words in memory

    always @(posedge clk or read_signal or write_signal) begin
        if (write_signal) begin
            mem[addr] = data_in;
        end
        else if (read_signal) begin
            data_out = mem[addr];
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