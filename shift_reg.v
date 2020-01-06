`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:13:51 10/31/2018 
// Design Name: 
// Module Name:    shift_reg 
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
module shift_reg(sh,sdi,clk,reset,out);
input sh,sdi,clk,reset;
output reg [9:0] out;

always @ (posedge clk, posedge reset)
	if (reset)
		out <= 10'b0;
	else if (sh)
		out <= {sdi,out[9:1]};




endmodule
