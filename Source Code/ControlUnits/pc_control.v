module pc_control(input [1:0]instr_type,input [4:0] opcode, input zero_signal, stop_bit, output reg [1:0] pc_src);
    // pc_src logic
	/*
	always @(*)begin
	    if (instr_type == 2'b01 && zero_signal && opcode == 5'b00100) begin // I-type
	        pc_src = 2'b01; // branch taken
	    end
	    else if(instr_type == 2'b10) begin // J-type
	        pc_src = 2'b10; // jump
	    end
	    else if(stop_bit) begin // stop
	        pc_src = 2'b11; // Return Address
	    end
	    else if(instr_type == 2'b00 || instr_type == 2'b11) begin // R-type
	        pc_src = 2'b00; // pc + 4
	    end
	    else begin // default
	        pc_src = 2'b00; // pc + 4
	    end	 
	end*/
    // another simple implementation
    
	wire branch;
	wire jump;
	assign branch = (instr_type == 2'b01 && zero_signal && opcode == 5'b00100) || stop_bit;
	assign jump = (instr_type == 2'b10) || stop_bit;
	
	// MUX to choose the pc_src value
	always @* begin
	    case ({jump, branch})
	        2'b00: pc_src = 2'b00; // pc + 4
	        2'b01: pc_src = 2'b01; // branch taken
	        2'b10: pc_src = 2'b10; // jump
	        2'b11: pc_src = 2'b11; // Return Address
	    endcase
	end

    
endmodule