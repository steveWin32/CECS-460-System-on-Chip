`timescale 1ns / 1ps
//****************************************************************//
// File name: decode.v //
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
//Decode module - is a decoder based off user input to determine
//whether the data is a 8 bit, enabling parity bit, should parity enabled be 
//odd parity or even parity.
//The output of the decoder is the last two bits of the data transmission.
//If parity enable is off, the ohel (Odd high even low) input doesn't even matter
//since ohel only affects the description of parity bit.
//If the data is not a 8 bit, the output will be a 7 bit of data instead.
//ohel is a input that if 1, odd parity, else we use even bit
//A 1 means its a mark meaning the bit is a stop bit or unused bit.
//
//The format on how data is transferred things goes by
//(mark[1])->(start bit)(data 0,1,2,3,4,5,6)(7)(parity bit)(stop bit) ->(mark[1])
module decode(data,eight,pen,ohel,d10,d9);
//input
input eight,pen,ohel;
input [7:0] data;
//output
output reg d10,d9;
//wire
wire p_odd,p_even;

//To determine parity, we use reduction exclusive or (XOR) ^ 
//where we XOR every bit
//For odd parity, our output has to be 0 in for the bit to be 1 to
//get a odd number of 1s
assign p_odd = ^data == 0 ? 1'b1 : 1'b0;
//For even parity, our output has to be 1 in for the bit to be 1 to
//get a even number of 1s
assign p_even = ^data == 1 ? 1'b1 : 1'b0;

always @ (*) begin
	case ({eight,pen,ohel})
		3'b000: {d10,d9} = 2'b11;            //No 8 bit, no parity enable, even parity
		3'b001: {d10,d9} = 2'b11;            //No 8 bit, no parity enable, odd parity
		3'b010: {d10,d9} = {1'b1,p_even};    //No 8 bit, parity enable, even parity
		3'b011: {d10,d9} = {1'b1,p_odd};     //No 8 bit, parity enable, odd parity
		3'b100: {d10,d9} = {1'b1,data[7]};   //8 bit, no parity enable, even parity
		3'b101: {d10,d9} = {1'b1,data[7]};   //8 bit, no parity enable, odd parity
		3'b110: {d10,d9} = {p_even,data[7]}; //8 bit, parity enable, even parity
		3'b111: {d10,d9} = {p_odd,data[7]};  //8 bit, parity enable, odd parity
	endcase
end

endmodule
