`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:37:42 11/01/2018
// Design Name:   UART_Transmit
// Module Name:   C:/Users/Steven Wang/Documents/CECS 460/CECS460-UART_Full/uart_mod_sim.v
// Project Name:  CECS460-UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Transmit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_mod_sim;

	// Inputs
	reg Load;
	reg [7:0] out_port;
	reg eight;
	reg pen;
	reg ohel;
	reg [19:0] k;
	reg clk;
	reg reset;

	// Outputs
	wire txrdy;
	wire transfer;

	// Instantiate the Unit Under Test (UUT)
	UART_Transmit uut (
		.Load(Load), 
		.out_port(out_port), 
		.eight(eight), 
		.pen(pen), 
		.ohel(ohel), 
		.k(k), 
		.txrdy(txrdy), 
		.transfer(transfer), 
		.clk(clk), 
		.reset(reset)
	);
	integer f;
	reg flip;
	time t=1000;
	
	always #5 clk =~clk;

	initial begin
	// Initialize Inputs
	reset = 0;
	Load = 1;	out_port = 8'b1011_1001;	eight = 1;	pen = 1;	ohel = 1;	k = 109;	clk = 0;	
	reset = 1;  #25; reset =0;
	// Add stimulus here
		f = $fopen("output.txt");
		flip = 0;
		#100
		Load = 0;
		#1_000_000
		$fclose(f);
		$finish;

	end
   always #t 
		begin	#25	
			flip = !flip;
			$fwrite(f,transfer, " ");
			$write("Bit: " ,transfer,"\n");
		end

endmodule

