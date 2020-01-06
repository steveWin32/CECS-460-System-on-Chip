`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:52 10/28/2018 
// Design Name: 
// Module Name:    RxStateMachine 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RxStateMachine(Rx,Btu,Done,clk,reset,DoIt,Start);
input Rx,Btu,Done,reset,clk;
reg DoIt_n,Start_n;
output reg DoIt,Start;
reg [1:0] present_state;
reg [1:0] next_state;

always @ (*) begin
		casez ({present_state,Rx,Btu,Done})
			5'b01_0_0_?: {next_state,DoIt_n,Start_n} = 4'b01_1_1;
			5'b01_0_1_?: {next_state,DoIt_n,Start_n} = 4'b10_1_0;
			5'b00_0_?_?: {next_state,DoIt_n,Start_n} = 4'b01_1_1; //Idle State
			5'b00_1_?_?: {next_state,DoIt_n,Start_n} = 4'b00_0_0;
			5'b01_1_?_?: {next_state,DoIt_n,Start_n} = 4'b00_0_0;
			5'b10_?_?_1: {next_state,DoIt_n,Start_n} = 4'b00_0_0;
			5'b10_?_?_0: {next_state,DoIt_n,Start_n} = 4'b10_1_0;
			default: {next_state,DoIt_n,Start_n} = 4'b00_0_0;
		endcase
end

always @ (posedge clk, posedge reset) begin
		if (reset) begin
			present_state <= 2'b00;
			DoIt <= 1'b0;
			Start <= 1'b0;
		end
		else begin
			present_state <= next_state;
			DoIt <= DoIt_n;
			Start <= Start_n;
		end
end

endmodule
