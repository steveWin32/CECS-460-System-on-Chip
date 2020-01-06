`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:37 10/28/2018 
// Design Name: 
// Module Name:    shift_reg_receive 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module shift_reg_receive(sh,sdi,clk,reset,out);
input sh,sdi,clk,reset;
output reg [9:0] out;

always @ (posedge clk, posedge reset)
	if (reset)
		out <= 10'b00000_00000;
	else if (sh)
		out <= {sdi,out[9:1]};

endmodule
