`timescale 1ns / 1ps
//****************************************************************//
// File name: BitTimeCounter.v //
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
//Bit Time counter is a counter to determine whether we counted a certain amount
// of posedge clocks (based off baud rate) that it reaches Bit Time.
//Once we reach a certain tick, we then call BTU (Bit Time Up) to tell
//the UART we are ready to send one bit.
//
//UART uses baud rate which is how fast one bit is sent between 2 peripherals.
//A list of baud rate values are listed below called Baud Rate Decoder
//
//This counter only runs whenever we are transmitting bits. Otherwise the counter
//will be reset back to 0 or if we reached the Bit Time
module BitTimeCounter(k,doIt,clk,reset,BTU);

input doIt,clk,reset;
input [19:0] k;
output BTU;
reg [19:0] counters ;
reg [19:0] next_counters;

//A register to store the counter on every positive edge of the clock
always @ (posedge clk,posedge reset) begin
	if (reset)
		next_counters <= 20'b0;
	else
		next_counters <= counters;
end

//Combo logic to increment the counter
always @(*) begin
	case ({doIt,BTU})
		2'b00: counters = 0;
		2'b01: counters = 0;
		2'b10: counters = next_counters + 20'b1;
		2'b11: counters = 0;
	endcase
end



//Bit Time Up - Check if we reached the tick based off the decoder above
assign BTU = (next_counters == k) ? 1'b1: 1'b0;
endmodule
