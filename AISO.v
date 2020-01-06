`timescale 1ns / 1ps
//****************************************************************//
// File name: AISO.v //
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
//
// AISO - Asynchronous In, Synchronous Out
// The AISO is a module that turns a asynchronous input into a synchronous output
// This is mostly used for reset because reset attempts to change all flop registers back to 0's or known state
// Unlike other signals, reset does not wait for the clock to reach positive edge which may
// cause issues such as not meeting the timing constraint which leads to metastability

module AISO(reset_in,clk,reset_out );

//Inputs
input clk,reset_in;
//Registers
reg reset_meta, reset_ok;
//Outputs
output reset_out;

//The trick to turn it into a synchronous output is forcing the signal into metastability
//by going out the first flop known as meta_signal
//Metastability only occurs in less than one cycle which is where another flop is placed after the
//output of the first flop
//Since it requires the positive edge of the clock and metastability only occurs in less than one clock cycle
//the output of the 2nd flop removes the oscillatiing from the flop unpredictable state and will not change its value
//Therefore the output of the 2nd flop is the ok_signal
always@(posedge clk, posedge reset_in) begin
	if (reset_in) begin
		reset_meta <= 1'b0; reset_ok <= 1'b0;
	end else begin
		reset_meta <= 1'b1; 	reset_ok <= reset_meta;
	end
end
//Our signal is hard wired as 1 since reset will turn the signal into 0. But since when we hit reset, our input is a 1
//But our goal is to turn it into a synchronous state meaning that the output should not change, it should be the same
//bit as the input therefore we must invert the output of ok_signal to match the reset.
assign reset_out = ~reset_ok;
endmodule
