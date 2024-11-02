`timescale 1ns / 1ps

module testbench;

	reg clk;
	reg [31:0] pc_out;
	reg [31:0] ins_memory_out;
	reg [31:0] alures_1;
	reg [31:0] data_ram;
  
	monocicle uut(
		.clk(clk),
		.sel(1'b0),
		.pc_out(pc_out),
		.ins_memory_out(ins_memory_out),
		.alures_1(alures_1),
		.data_ram(data_ram)
	);
		
      
    initial begin
      clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
		
		clk = 1'b0;
      #10;
		
		clk = 1'b1;
      #10;
      
        $finish;
    end

    initial begin
      $monitor("At time %0t: pc = %b, instruction_memory = %b, AluRes = %b, data_ram = %b",
               $time, pc_out, ins_memory_out, alures_1, data_ram);
    end
    
endmodule
