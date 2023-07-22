module instruction_memory(
    input [31:0] addr,	
    output reg [31:0] data_out
);
    reg [31:0] mem [0:1023]; // Assuming 1024 32-bit words in memory

    always @(addr) begin
        data_out = mem[addr];
    end

    initial begin
        // Set instructions directly in the memory array
        mem[0] = 32'h08CA0052; // addi $5, $3, 10  => R5 = R3 + 10 : R5 = 13 => 0x0000000D
        mem[1] = 32'h0955FFDA; // addi $10, $5, -5 => R10 = R5 + (-5) : R10 = 8
        mem[2] = 32'h08861000; // add $3, $2, $1   => R3 = R2 + R1 : R3 = 3 
        mem[3] = 32'h00C81000; // and $4, $3, $1   => R4 = R3 & R1 : R4 = 1 
        mem[4] = 32'h10CA4000; // sub $5, $3, $4   => R5 = R3 - R4 : R5 = 2
        mem[5] = 32'h19060002; // SW $3, 0($4)     => Mem[1] = R3 : Mem[1] = 3   
        mem[6] = 32'h00480106; //SLL R4, R1, 2 => R4 = R1 << 2 : R4 = 4
        mem[7] = 32'h07FFFFEC; // J -3
        //mem[7] = 32'hFFFFFEC; // JAL
    end
endmodule
