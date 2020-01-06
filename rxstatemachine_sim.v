`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:07 11/02/2018
// Design Name:   RxStateMachine
// Module Name:   C:/Users/Steven Wang/Documents/CECS 460/CECS460-UART_Full/rxstatemachine_sim.v
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

module rxstatemachine_sim;

	// Inputs
	reg Rx;
	reg Btu;
	reg Done;
	reg reset;

	// Outputs
	wire DoIt;
	wire Start;

	// Instantiate the Unit Under Test (UUT)
	RxStateMachine uut (
		.Rx(Rx), 
		.Btu(Btu), 
		.Done(Done), 
		.reset(reset), 
		.DoIt(DoIt), 
		.Start(Start)
	);

	initial begin
		// Initialize Inputs
		Rx = 0;
		Btu = 0;
		Done = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

