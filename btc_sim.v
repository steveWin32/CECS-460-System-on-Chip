`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:53:26 11/02/2018
// Design Name:   BitTimeCounterReceive
// Module Name:   C:/Users/Steven Wang/Documents/CECS 460/CECS460-UART_Full/btc_sim.v
// Project Name:  CECS460-UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BitTimeCounterReceive
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module btc_sim;

	// Inputs
	reg start;
	reg [19:0] k;
	reg [19:0] k_div2;
	reg doIt;
	reg clk;
	reg reset;

	// Outputs
	wire BTU;

	// Instantiate the Unit Under Test (UUT)
	BitTimeCounterReceive uut (
		.start(start), 
		.k(k), 
		.k_div2(k_div2), 
		.doIt(doIt), 
		.clk(clk), 
		.reset(reset), 
		.BTU(BTU)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		start = 0;	k = 0; k_div2 = 0; doIt = 0;	clk = 0;	reset = 0;
		k = 109; k_div2 = 55;
		reset = 1; #100; reset =0;
		doIt = 1;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

