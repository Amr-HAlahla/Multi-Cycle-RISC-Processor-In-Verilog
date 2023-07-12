module register_file_tb;
    reg clk;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg write_enable;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    register_file reg_file(clk, read_reg1, read_reg2, write_reg, write_data, write_enable, read_data1, read_data2);

    initial begin
        clk = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;
        write_enable = 0;
        #10;
        write_enable = 1;
        write_data = 32'hdeadbeef;
        write_reg = 0;
        #10;
        write_enable = 0;
        read_reg1 = 0; // read from register 0
        read_reg2 = 1; // read from register 1
        #10;
        $display("read_data1 = %h", read_data1);
        $display("read_data2 = %h", read_data2);
        #10;
        $finish;
    end

    always begin
        #5;
        clk = ~clk;
    end
endmodule