`timescale 1ns / 1ps
//****************************************************************//
// File name: Load_reg.v //
// //
// Created by Steven Wang on 10/16/2018 8:20 PM. //
// Copyright © 2018 Steven Wang. All rights reserved. //
// //
// //
// In submitting this file for class work at CSULB //
// I am confirming that this is my work and the work //
// of no one else. In submitting this code I acknowledge that //
// plagiarism in student project work is subject to dismissal. //
// from the class //
//****************************************************************//
//Load register is a d flop but it only writes to the register
//whenever load is 1. Otherwise we retain its value even
//at positive edge of the clock.
module load_reg(load,value,q,clk,reset  );
input [7:0] value;
output reg [7:0] q;
input load,clk,reset;

always @(posedge clk,posedge reset) begin
	if (reset)
		q <= 8'b0;
	else  begin
		if (load)
			q <= value;
		else
			q <= q;
	end
end

endmodule
