`timescale 1ns / 1ps
//****************************************************************//
// File name: shift_register.v //
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
//The shift register is the register that is responsible on transmitting
//serial data input.
//The register is shifted 1 bit at a time to the right.
//Whenever a load signal is on, we set the data to the 11 bits of data that is loaded
//b1 = (output of decode) the MSB 
//b2 = (output of decode)
//b3 = 7 bits of data
//b4 = 0 (start bit)
//b5 = 1 (mark) the LSB

//Whenever we shift bits to the right, the MSB is always a 1 (mark bit)

module shift_register(clk,reset,ld,sh,sdi,b1,b2,b3,b4,b5,sd0); 
input ld,sh,sdi; //sdi = serial data in
input clk,reset;
input b1,b2;
input [6:0] b3;
input b4,b5;
output reg sd0;
reg [10:0] data;
always @(posedge clk, posedge reset)
	//Reset triggered, reset data and data output
	if (reset) begin
		data <= 11'b11111_11111_1;
		sd0 <= 1'b1;
	//Should we load another 11 bits of data
	end else if (ld) 
		//Load the 10 bit data
		data <= {b1,b2,b3,b4,b5};
	//Should we shift the bit?
	else if (sh) begin 
		//Shift the data to the right by 1
		data <= {sdi,data[10:1]};
		//Followed by output the data the most to the right as output
		sd0 <= data[0];
end
endmodule
