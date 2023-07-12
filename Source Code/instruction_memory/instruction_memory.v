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
        mem[0] = 32'h08CA0052; // addi $5, $3, 10  => 32'b00001(opcode)00011(rs1)00101(rd)00000000001010(immediate)01(type)0(stop) 
        mem[1] = 32'h0955FFDA; // addi $10, $5, -5 => 32'b00001(opcode)00101(rs1)01010(rd)11111111111011(immediate)01(type)0(stop)
        mem[2] = 32'h08861000; // add $3, $2, $1   => 32'b00001(opcode)00010(rs1)00011(rd)00001(rs2)000000000(unused)00(type)0(stop)
        mem[3] = 32'h00C81000; // and $4, $3, $1   => 32'b00000(opcode)00011(rs1)00100(rd)00001(rs2)000000000(unused)00(type)0(stop) 
        mem[4] = 32'h10CA4000; // sub $5, $3, $4   => 32'b00010(opcode)00011(rs1)00101(rd)00100(rs2)000000000(unused)00(type)0(stop) 
        mem[5] = 32'h19060002; // SW $3, 0($4)     => 32'b00011(opcode)00100(rs1)00011(rd)00000000000000(imm)01(type)0(stop)    
        //mem[6] = 32'h110C0002; // LW $6, 0($4)    => 32'b00010(opcode)00011(rs1)00110(rd)00000000000000(imm)01(type)0(stop) 
    end
endmodule