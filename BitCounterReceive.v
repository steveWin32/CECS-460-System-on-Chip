`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:39 10/28/2018 
// Design Name: 
// Module Name:    BitCounterReceive 
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
module BitCounterReceive(clk,reset,do_it,start,btu,eight,pen,done_out );
input do_it,start,clk,reset,btu,eight,pen;
wire do_mux;
reg [3:0] counter;
reg [3:0] next_counter;
reg [3:0] value;
assign do_mux = do_it && ~start;
wire done;
output reg done_out;
always @ (*) begin
	case ({do_mux,btu})
		2'b00: counter = 4'b0;
		2'b01: counter = 4'b0;
		2'b10: counter = next_counter;
		2'b11: counter = next_counter + 1;
	endcase
end
always @(*) begin
	case ({eight,pen})
		2'b00: value = 8;
		2'b01: value = 9;
		2'b10: value = 10;
		2'b11: value = 10;
	endcase
end

always @ (posedge clk,posedge reset) begin
	if (reset) begin
		next_counter <= 4'b0;
		done_out <= 1'b0; end
	else begin
		next_counter <= counter;
		done_out <= done;
	end
end
assign done = next_counter >= value ? 1'b1: 1'b0;
endmodule
