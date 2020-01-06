`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:31 10/31/2018 
// Design Name: 
// Module Name:    receive_engine 
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
module receive_datapath(clk,reset,BTU,start,reads,port_id,rx,rx_rdy,ohel,eight,pen,done_d,perr,ferr,ovf,out_port);
input BTU, clk, reset;
input start;
input eight;
input ohel;
input rx;
input pen;
input done_d;
input [15:0] reads;
input [15:0] port_id;
output wire [7:0] out_port;

wire sh_wire;
wire [9:0] shift_data;
wire b9,b8,b7;
wire [6:0] b;

assign sh_wire = BTU && ~start;
shift_reg_receive sr(.sh(sh_wire),.sdi(rx),.clk(clk),.reset(reset),.out(shift_data));
remap_combo   r1(.data(shift_data),.eight(eight),.pen(pen),.out_port(out_port),.bit_9(b9),.bit_8(b8),.bit_7(b7),.bit_else(b));

wire parity_gen_select,parity_bit_select;
assign parity_gen_select = eight == 1 ? b7 : 1'b0;
assign parity_bit_select = eight == 1 ? b8 : b7;

wire parity_xor,parity_value;
assign parity_xor =  b ^ parity_gen_select;
assign parity_value = ~ohel ? parity_xor : ~parity_xor;

wire parity_2;
assign parity_2 = parity_value ^ parity_bit_select;
wire parity_error;
assign parity_error = pen && parity_2 && done_d;

wire stop_bit_select;
assign stop_bit_select = ~({pen,eight} == 2'b00 ? b7 : ({pen,eight}==2'b01 || {pen,eight} == 2'b11) ? b8 :b9);
wire framing_error;
assign framing_error = done_d && stop_bit_select;

wire overflow_error;
assign overflow_error = done_d && rx_rdy;

wire clear;
assign clear = reads[0] && port_id == 0;
reg rxRdy;

output reg rx_rdy,perr,ferr,ovf;

always @(*)
	if (done_d)
		rx_rdy = 1'b1;
	else if (clear)
		rx_rdy = 1'b0;

		
always @(*)
	if (overflow_error)
		ovf = 1'b1;
	else if (clear)
		ovf = 1'b0;

always @(*)
	if (parity_error)
		perr = 1'b1;
	else if (clear)
		perr = 1'b0;

always @(*)
	if (framing_error)
		ferr = 1'b1;
	else if (clear)
		ferr = 1'b0;



endmodule
