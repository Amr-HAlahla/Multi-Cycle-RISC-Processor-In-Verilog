module tb_MCRP;
  reg clk;
  reg reset;
  wire [31:0] result;

  MCRP dut (.clk(clk), .reset(reset), .result(result));

  // Clock generator
  initial begin
    clk = 0;
    forever #20 clk = ~clk;
  end

  // Reset and stimulus
  initial begin
    reset = 1;
    #10 reset = 0;
    
	#2000 $finish;
  end	
  
endmodule
