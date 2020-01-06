`timescale 1ns / 1ps
//****************************************************************//
// File name: UART_TRANSMIT.v //
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
//UART (Transmit side)
//This module covers the transmit portion of the UART.
//It transmit 8 bits of data (ASCII) to another peripheral through serial input.
//
//UART has a signal called txrdy to signal the tramel blaze whether the device
//can send data to another peripheral.
//When txrdy is 1 it means that it is ready to send a ASCII character
//Otherwise if not ready, it means that the Transmit has bits that are being sent through shift
//register.
//
//Because it is a serial input, the ASCII has to break down into binary bits.
//It then goes into a shift register to move each bit 1 at a time to the right.Until it reaches the stop bit
//
//The UART has customizable baud rates that changes how fast one bit is sent between
//two devices and parity bits (odd/even bits) that is used to verify from the receiver side
//that the data transferred correctly matches the data recevied from the other peripheral.
//Another form of error checking.
//
//A output called transfer is the 1 bit (0/1) that is to be sent to the other peripheral.

module UART_Transmit(Load,out_port,eight,pen,ohel,k,txrdy,transfer,clk,reset);
	//Inputs
	input Load;
	input [7:0] out_port;
	input eight;
	input pen;
	input ohel;
	input [19:0] k;
	input clk,reset;
	//Outputs
	output reg txrdy;
	output wire transfer;
	//registers
	reg write_d1;	
	reg do_it;
	//wires
	wire baud_time_unit;
	wire done;
	wire doneD1;
	wire [7:0] load_data;
	wire d10, d9;
	
	//D flop for write_dl for the shift register
	always @ (posedge clk, posedge reset) begin
		if (reset)
			write_d1 <= 1'b0;
		else 
			write_d1 <= Load;
	
	end
	
	//S/R flop for txrdy to signal whether we can send another char
	always @ (posedge clk, posedge reset) begin
	if (reset) //Reset
		txrdy <= 1'b1;
	else if (doneD1) //S
		txrdy <= 1'b1;
	else if (Load) //R
		txrdy <= 1'b0;
	end
	
	//S/R Flop for do_it which is used for bit_time_counter,bit_counter.
	always @ (posedge clk, posedge reset) begin
	if (reset)
		do_it <= 1'b0;
	else if (Load)
		do_it <= 1'b1;
	else if (done)
		do_it <= 1'b0;
	end
	//=========================
	//Modules used
	//=========================
	//Bit time Counter module
	BitTimeCounter bit_time_counter_mod(.k(k),.doIt(do_it),.clk(clk),.reset(reset),.BTU(baud_time_unit));
	//Bit counter module
	BitCounter 		bit_counter_mod(.btu(baud_time_unit),.doit(do_it),.clk(clk),.reset(reset),.done(done),.done1(doneD1));
	//Load register module
	load_reg 		load_reg_mod(.load(Load),.value(out_port),.q(load_data),.clk(clk),.reset(reset));
	//The decode module that whether the data is 8 bit, can enable parity bit, whether we use odd/even parity if parity bit is enabled
	decode   		decode_mod(.data(load_data),.eight(eight),.pen(pen),.ohel(ohel),.d10(d10),.d9(d9));
	//Shift register module
	shift_register shift_mod(.clk(clk),.reset(reset),.ld(write_d1),.sh(baud_time_unit),.sdi(1'b1),.b1(d10),.b2(d9),.b3(load_data[6:0]),.b4(1'b0),.b5(1'b1),.sd0(transfer)); 

endmodule
