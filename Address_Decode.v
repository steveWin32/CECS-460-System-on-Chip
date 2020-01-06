`timescale 1ns / 1ps
//****************************************************************//
// File name: Address_Decode.v //
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
//The Address Decode is the decoder to determine what address
//is to be written/read based off the input from the port_id
//we call from the tramel blaze

//Since we only have 1 peripheral, the most 2 significant bits will not be used
//The lower 3 bits of the port_id represent the index we are going to access
//If we receive a read_Strobe we should talk to the 16 bit read output 
//If we receive a write_strobe we should talk to the 16 bit write output
//The output is the decode 16-bit read or write based on the strobe signal.

module Address_Decode(port_id,read_strobe,write_strobe,read,write);
	//inputs
   input [15:0] port_id;
	input  read_strobe;
	input  write_strobe;
	//outputs
	output reg [15:0]read;
	output reg [15:0]write;
	//wire
	wire [3:0] addressnum;
	
	//Depending on the least significant 3 bits of the port_id
	//it determines what index is to be on using our 16 bit array outputs
	//For example if addressnum is 1, our output resembles 0000000000000001
	//starting from the most right
	//For example if addressnum is 5, our output resembles 0000000000010000
	
	//If we receive a read data (read_strobe) or write data (write_strobe)
	//the decode applies otherwise the output remains a 16 bits worth of zeros
	assign addressnum = port_id[3:0];
	always @ (*) begin
			case ( addressnum)
					4'b0000: begin 
						read =  read_strobe ? 16'b0000_0000_0000_0001: 16'b0000_0000_0000_0000;
						 write= write_strobe ? 16'b0000_0000_0000_0001:16'b0000_0000_0000_0000;
					end
					4'b0001: begin 
						read =  read_strobe ? 16'b0000_0000_0000_0010: 16'b0000_0000_0000_0000;
						 write = write_strobe ? 16'b0000_0000_0000_0010:16'b0000_0000_0000_0000;
					end
					4'b0010: begin 
						read =  read_strobe ? 16'b0000_0000_0000_0100: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_0000_0000_0100:16'b0000_0000_0000_0000;
					end
					4'b0011: begin 
						read =  read_strobe ? 16'b0000_0000_0000_1000: 16'b0000_0000_0000_0000;
						 write = write_strobe ? 16'b0000_0000_0000_1000:16'b0000_0000_0000_0000;
					end
					4'b0100: begin 
						read =  read_strobe ? 16'b0000_0000_0001_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_0000_0001_0000:16'b0000_0000_0000_0000;
					end
					4'b0101: begin 
						read =  read_strobe ? 16'b0000_0000_0010_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_0000_0010_0000:16'b0000_0000_0000_0000;
					end
					4'b0110: begin 
						read =  read_strobe ? 16'b0000_0000_0100_0000: 16'b0000_0000_0000_0000;
						 write = write_strobe ? 16'b0000_0000_0100_0000:16'b0000_0000_0000_0000;
					end
					4'b0111: begin 
						 read =  read_strobe ? 16'b0000_0000_1000_0000: 16'b0000_0000_0000_0000;
						 write = write_strobe ? 16'b0000_0000_1000_0000:16'b0000_0000_0000_0000;
					end
					4'b1000: begin 
						read =  read_strobe ? 16'b0000_0001_0000_0000: 16'b0000_0000_0000_0000;
						write= write_strobe ? 16'b0000_0001_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1001: begin 
						read =  read_strobe ? 16'b0000_0010_0000_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_0010_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1010: begin 
						read =  read_strobe ? 16'b0000_0100_0000_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_0100_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1011: begin 
						read =  read_strobe ? 16'b0000_1000_0000_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0000_1000_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1100: begin 
						read =  read_strobe ? 16'b0001_0000_0000_0000: 16'b0000_0000_0000_0000;
						write = write_strobe ? 16'b0001_0000_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1101: begin 
						read =  read_strobe ? 16'b0010_0000_0000_0000: 16'b0000_0000_0000_0000;
					write = write_strobe ? 16'b0010_0000_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1110: begin 
						 read =  read_strobe ? 16'b0100_0000_0000_0000: 16'b0000_0000_0000_0000;
						 write = write_strobe ? 16'b0100_0000_0000_0000:16'b0000_0000_0000_0000;
					end
					4'b1111: begin 
						 read =  read_strobe ? 16'b1000_0000_0000_0000: 16'b0000_0000_0000_0000;
						 write= write_strobe ? 16'b1000_0000_0000_0000:16'b0000_0000_0000_0000;
					end
			endcase
end


endmodule
