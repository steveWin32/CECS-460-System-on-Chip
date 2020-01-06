`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:49 10/28/2018 
// Design Name: 
// Module Name:    BitTimeCounterReceive 
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
module BitTimeCounterReceive(start,k,k_div2,doIt,clk,reset,BTU);
input start;
input doIt,clk,reset;
input [19:0] k;
input [19:0] k_div2;
output BTU;

reg [19:0] counters ;
reg [19:0] next_counters;
wire [19:0] k_mux;

assign k_mux = start ? k_div2 : k;

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
assign BTU = (next_counters == k_mux) ? 1'b1: 1'b0;
endmodule
