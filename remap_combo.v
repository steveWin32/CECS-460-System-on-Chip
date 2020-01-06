`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:24 10/31/2018 
// Design Name: 
// Module Name:    remap_combo 
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
module remap_combo(data,eight,pen,out_port,bit_9,bit_8,bit_7,bit_else);
output bit_9,bit_8,bit_7;
output [6:0] bit_else;
reg [9:0] value;
output [7:0] out_port;
input eight,pen;
input [9:0] data;

always @ (*)
	case ({eight,pen})
		2'b00: value = {2'b0, data[8:2]};
		2'b01: value = {1'b0, data[8:1]};
		2'b10: value = {1'b0, data[8:1]};
		2'b11: value = data;
	endcase
assign out_port = {~eight ? 1'b0:value[7],value[6:0]};
assign bit_9 = value[9];
assign bit_8 = value[8];
assign bit_7 = value[7];
assign bit_else = value[6:0];
endmodule
