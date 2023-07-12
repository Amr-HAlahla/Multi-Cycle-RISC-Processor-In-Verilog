module test_bench();
    reg clk;
    reg reset;
    wire [1:0] pc_src; // pc source
    wire ext_op; // extend operation
    wire [2:0] alu_op; // alu operation
    wire [1:0] alu_src; // alu source
    wire mem_write; // memory write
    wire mem_read; // memory read
    wire reg_write; // register write
    wire wb_src; // write back source
    wire stack_write; // stack write
    wire stack_read; // stack read
    wire zero_signal; // zero signal
    wire [31:0] pc_out; // program counter output		   
    wire [31:0] ir_out; // instruction register output
    wire [31:0] a_out; // first operand output
    wire [31:0] b_out; // second operand output
    wire [31:0] alu_result; // output of ALU
    wire [31:0] mem_result; // output of memory
	wire [31:0] wb_result;
    wire reg_src; // register source
    // instantiate the module
    MCRP sm(clk, reset, pc_src, ext_op, alu_op, alu_src, mem_write, mem_read, reg_write, wb_src, stack_write, stack_read, zero_signal, pc_out, ir_out, a_out, b_out, alu_result, mem_result, wb_result, reg_src);

    initial begin
        clk = 0;
        reset = 1;
        #30 reset = 0;
		
		//#5000 $finish;
    end

    always begin
        #20 clk = ~clk;
		#20;
    end

	initial begin
	  $monitor("pc_src = %h, ext_op = %h, alu_op = %h, alu_src = %h, mem_write = %h, mem_read = %h, reg_write = %h, wb_src = %h, stack_write = %h, stack_read = %h, zero_signal = %h, pc_out = %h, ir_out = %h, a_out = %h, b_out = %h, alu_result = %h, mem_result = %h, wb_result = %h, reg_src = %h\n\n", pc_src, ext_op, alu_op, alu_src, mem_write, mem_read, reg_write, wb_src, stack_write, stack_read, zero_signal, pc_out, ir_out, a_out, b_out, alu_result, mem_result, wb_result, reg_src);
	end
endmodule