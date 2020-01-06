`timescale 1ns / 1ps
//****************************************************************//
// File name: UART_TRANSMIT_TOP.v //
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
//This is the top level of the UART - Transmit
//The way on how the UART works is explained in the Project Report
//and are also explained on every module on how it works

module Uart_Transmit_Top(Eight,Pen,Ohel,Baud,clk,reset,led_out,transmit,receive);
//inputs
input Eight;
input Pen;
input Ohel;
input clk, reset;
input [3:0] Baud;
input receive;
//outputs
output transmit;
output [15:0] led_out;
//wires
wire ready_out;
wire int_ack;
wire [15:0] out_port;
wire [15:0] port_id;
wire read_strobe;
wire write_strobe;
wire [15:0] read_out;
wire [15:0] write_out;
wire reset_out;
wire TxRdy;
wire RxRdy;
wire [19:0] k;
wire [19:0] k_div2;

wire perror;
wire ferror;
wire ovf;
//receiver (data/status)
wire [7:0] data;
wire [7:0] status;
//registers
reg interrupt;	
//AISO - Asynchronous Input, Synchronous Output emphasis on reset signal			 
AISO  aiso_mod(.reset_in(reset),.clk(clk),.reset_out(reset_out));

baud_rate_decoder brd(.baud_decode(Baud),.k(k),.k_div2(k_div2) );

//UART - Universal Asynchronous Receiver Transmitter - Transmit Side
UART_Transmit uart_mod(.Load(write_out[0]),.out_port(out_port[7:0]),.eight(Eight),.pen(Pen),.ohel(Ohel),.k(k),.txrdy(TxRdy),.transfer(transmit),.clk(clk),.reset(reset_out));

//UART - Universal Asynchronous Receiver Transmitter - Receive Side
UART_Receive uart_mod2(.k(k),.k_div2(k_div2),.Rx(receive),.port_id(port_id),.reads(read_out),.ohel(Ohel),.eight(Eight),.pen(Pen),
.clk(clk),.reset(reset_out),.data(data),.perror(perror),.ferror(ferror),.oerror(ovf),.RxRdy(RxRdy));

//status flag for receive.
assign status = {2'b0,ovf,perror,ferror,TxRdy,RxRdy};

//Mux for receive data/receive status
wire [7:0] in_port;
assign in_port = read_out[0] == 1 ? data : read_out[1] == 1 ? status : 8'b0;

//check is ready or transmit signal are ready
wire rdy_signal;
assign rdy_signal = RxRdy || TxRdy;

//PED - positive edge detect
PED ped_mod(.clk(clk),.reset(reset),.db(rdy_signal),.PED_out(ready_out));
//SR Flop for the interrupt signal
always @ (posedge clk, posedge reset) begin
	if (reset) //Reset
		interrupt <= 1'b0;
	else if (ready_out) //S
		interrupt <= 1'b1;
	else if (int_ack) //R
		interrupt <= 1'b0;
	end

//Tramel Blaze
tramelblaze_top tramel_blaze_mod(.CLK(clk), .RESET(reset_out), .IN_PORT({8'b0,in_port}), .INTERRUPT(interrupt), 
                       .OUT_PORT(out_port), .PORT_ID(port_id), .READ_STROBE(read_strobe), .WRITE_STROBE(write_strobe), .INTERRUPT_ACK(int_ack));
//Address Decode
Address_Decode adr_dec_mod(.port_id(port_id),.read_strobe(read_strobe),.write_strobe(write_strobe),.read(read_out),.write(write_out));

//The output that is filtered to only receive port_id 1 data that is used to
//display its value on the LED on the Nexys 4 FPGA Board
//In the assembly code we shift the LED to the left but rotating the bits around
assign led_out = (port_id == 1'b1) ? out_port : led_out;

endmodule
