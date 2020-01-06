`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:31:46 11/02/2018
// Design Name:   UART_Receive
// Module Name:   C:/Users/Steven Wang/Documents/CECS 460/CECS460-UART_Full/uart_receive_sim.v
// Project Name:  CECS460-UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Receive
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_receive_sim;

	// Inputs
	reg [19:0] k;
	reg [19:0] k_div2;
	reg Rx;
	reg [15:0] port_id;
	reg [15:0] reads;
	reg ohel;
	reg eight;
	reg pen;
	reg clk;
	reg reset;

	// Outputs
	wire [7 :0] data;
	wire perror;
	wire ferror;
	wire oerror;
	wire RxRdy;

	// Instantiate the Unit Under Test (UUT)
	UART_Receive uut (
		.k(k), 
		.k_div2(k_div2), 
		.Rx(Rx), 
		.port_id(port_id), 
		.reads(reads), 
		.ohel(ohel), 
		.eight(eight), 
		.pen(pen), 
		.clk(clk), 
		.reset(reset), 
		.data(data), 
		.perror(perror), 
		.ferror(ferror), 
		.oerror(oerror), 
		.RxRdy(RxRdy)
	);
	integer i = 0;
	always #5 clk=~clk; 
	always @ (*) begin
		if (uut.RxRdy == 1'b0)
			reads = 16'b1;
		else
			reads = 16'b0;
	end
	always @ (posedge uut.re1.sr.sh) begin
			Rx = sample_data[i];
			i = i+1;
		end

	reg [10:0] sample_data;
	initial begin
		// Initialize Inputs
	
		clk=0;
		Rx = 0;	port_id = 0;	reads = 0;	ohel = 1;	eight = 1;	pen = 1;	
		sample_data = 10'b01_1001_1001;
		k = 109;	k_div2 = 55;
		// Wait 100 ns for global reset to finish
			reset = 1; #10; reset =0;	
		#100;
        
		// Add stimulus here

	end
      
endmodule

