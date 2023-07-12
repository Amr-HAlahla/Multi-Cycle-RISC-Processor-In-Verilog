module memory_tb;
    reg clk;
    reg [31:0] addr;
    reg [31:0] data_in;
    reg write_signal;
    reg read_signal;
    wire [31:0] data_out;

    memory dut (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .write_signal(write_signal),
        .read_signal(read_signal),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        clk = 0;
        addr = 0;
        data_in = 0;
        write_signal = 0;
        read_signal = 0;
        #10;
        // Write test case
        write_signal = 1;
        addr = 10;
        data_in = 123;
        #10;

        // Read test case
        write_signal = 0;
        read_signal = 1;
        addr = 10;
        #20;
        $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("addr = %d, data_in = %d, write_signal = %d, read_signal = %d, data_out = %d",
                addr, data_in, write_signal, read_signal, data_out);
    end
endmodule
