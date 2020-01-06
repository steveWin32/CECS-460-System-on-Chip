`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:53:14 11/02/2018
// Design Name:   RxStateMachine
// Module Name:   C:/Users/Steven Wang/Documents/CECS 460/CECS460-UART_Full/rx_state_sim.v
// Project Name:  CECS460-UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RxStateMachine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rx_state_sim;

	// Inputs
	reg Rx;
	reg Btu;
	reg Done;
	reg clk;
	reg reset;

	// Outputs
	wire DoIt;
	wire Start;

	// Instantiate the Unit Under Test (UUT)
	RxStateMachine uut (
		.Rx(Rx), 
		.Btu(Btu), 
		.Done(Done), 
		.clk(clk), 
		.reset(reset), 
		.DoIt(DoIt), 
		.Start(Start)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		Rx = 0;	Btu = 0;	Done = 0;	clk = 0;	reset = 0;
		reset = 1; #100; reset =0;
        
		Rx = 1; #500;
		Rx = 0; #500;
		Rx = 0; Btu = 1; #500;
		#100;
		// Add stimulus here

	end
      
endmodule

