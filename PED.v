`timescale 1ns / 1ps
//****************************************************************//
// File name: PED.v //
// //
// Created by Steven Wang on 2/12/2018 8:22 PM. //
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
// PED - Positive Edge Detector
// Detects whether the signal receives a transition from 0 to 1 (positive edge). 
// If there is, the output returns 1 otherwise if there isn't a transition or 
// we get a transition from 1 to 0 (negative edge) returns a 0.
//
// The module consists of 2 flops
// It receives the db (debounced signal) and feeds into the first flop and outputs (q) [Next]
// It feeds (q) onto the second flop after the next clock cycle and outputs (q_out) [Previous]
// We then check the transition between them. If q_out is a 0 while q is a 1 we get
// a posedge change and our PED outputs a 1
// Otherwise if q_out and q are the same PED outputs a 0
// ==============================================================
// Input
// ==============================================================
// clk - the clock that is shared from master clock in our design
// db - a signal (for this project it is obtained after the debouncer module)
// ==============================================================
// Output
// ==============================================================
// PED_out - the output whether PED received a transition from 0 to 1.
//

module PED(clk,reset,db,PED_out );
input clk,db,reset;
reg q, q_out;
output PED_out;
always @(posedge clk, posedge reset) begin
	if (reset) begin
		q <= 1'b0;
		q_out <= 1'b0;
	end else begin
	//Note changes are NOT made until the next clock cycle meaning that
	//q does not get updated immediately so that q_out will still get
	//q before getting assigned to the wire db
		q <= db;
		q_out <= q;
	end
end
//Then assign the updated q and q_out and compare
assign PED_out = q & ~q_out;
endmodule


