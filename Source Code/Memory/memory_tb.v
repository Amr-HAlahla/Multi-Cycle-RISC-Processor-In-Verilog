module memory_tb;
    reg clk;
    reg [31:0] addr;
    reg [31:0] data_in;
    reg write_signal;
    reg read_signal;
    wire [31:0] data_out;

    memory mem(clk, addr, data_in, write_signal, read_signal, data_out);

    initial begin
        clk = 0;
        addr = 0;
        data_in = 0;
        write_signal = 0;
        read_signal = 0;
        #10;
        write_signal = 1;
        data_in = 32'hdeadbeef;
        #10;
        write_signal = 0;
        read_signal = 1;
        addr = 0;
        #10;
        addr = 1;
        #10;
        addr = 2;
        #10;
        addr = 3;
        #10;
        addr = 4;
        #10;
        addr = 5;
        #10;
        addr = 6;
        #10;
        addr = 7;
        #10;
        addr = 8;
        #10;
        addr = 9;
        #10;
        addr = 10;
        #10;
        addr = 11;
        #10;
        addr = 12;
        #10;
        addr = 13;
        #10;
        addr = 14;
        #10;
        addr = 15;
        #10;
        addr = 16;
        #10;
        addr = 17;
        #10;
        addr = 18;
        #10;
        addr = 19;
        #10;
        addr = 20;
        #10;
        addr = 21;
        #10;
        addr = 22;
        #10;
        addr = 23;
        #10;
        addr = 24;
        #10;
        addr = 25;
        #10;
        addr = 26;
        #10;
        addr = 27;
        #10;
        addr = 28;
        #10;
        addr = 29;
        #10;
        addr = 30;
        #10;
        addr = 31;
        #10;
        addr = 32;
        #10;
        addr = 33;
        #10;
        addr = 34;
        #10;
        addr = 35;
        #10; 
        #100; // Wait for some time before finishing the simulation
        $finish;
    end

    always #5 clk = ~clk;
    
    // Monitor for memory
    always @(posedge clk) begin
        $display("addr=%d, data_out=%h", addr, data_out);
    end

endmodule
