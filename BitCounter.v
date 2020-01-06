`timescale 1ns / 1ps
//****************************************************************//
// File name: BitCounter.v //
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
//Bit Counter is a counter to check whether we transmit our data (that includes
//parity bit/stop bit/start bit onto another peripheral.
//In this module, we transmit up to 11 bits since the max our data can hold
//is 11 bits.
//Each time a bit is successfully transmited to another peripheral
//which is the Bit Time,we increment the counter
//Once we transfer 11 bits worth of data, than the output of this module is
//the done signal to tell that the UART transmission is complete.
//
// This module only works when we are transmitting bits and when Bit Time 
// is 1.
module BitCounter(btu,doit,clk,reset,done,done1);
//inputs
input doit,btu,clk,reset;
//outputs
output reg done1;
output done;
//registers
reg [3:0] counter;
reg [3:0] counter_next;

//A flop that stores our counter data. 
always @(posedge clk,posedge reset) begin
	if (reset) begin
		done1 <= 1'b0;
		counter_next <= 1'b0;
	end else begin
		done1 <= done;
		counter_next <= counter;
		end
end
//Combo block that increments the counter whenever we are currently
//transmiting and whenever we see bit time enabled
always @ (*) begin
	case ({doit,btu})
		2'b00: counter = 2'b0;
		2'b01: counter = 2'b0;
		2'b10: counter = counter_next;
		2'b11: counter = counter_next + 4'b1;
	endcase
	
end

//Is all of our bits sent? Otherwise we are finished transmitting data.
assign done = (counter_next == 4'b1011) ? 1'b1: 1'b0;
endmodule
