`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:35 10/28/2018 
// Design Name: 
// Module Name:    baud_rate_decoder 
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
module baud_rate_decoder(baud_decode,k,k_div2 );
input [3:0] baud_decode;
output reg [19:0] k;
output reg [19:0] k_div2;
always @ (*) begin
	case (baud_decode)
		4'b0000: begin k = 333333;k_div2 = 333333/2; end//Baud Rate: 300
		4'b0001: begin k = 83333;k_div2 = 83333/2; end //Baud Rate: 1200
		4'b0010: begin k = 41667;k_div2 = 41667/2; end //Baud Rate: 2400
		4'b0011: begin k = 20833;k_div2 = 20833/2; end //Baud Rate: 4800
		4'b0100: begin k = 10417;k_div2 = 10417/2; end//Baud Rate: 9600
		4'b0101: begin k = 5208;k_div2 = 5208/2; end  //Baud Rate: 19200
		4'b0110: begin k = 2604;k_div2 = 2604/2; end  //Baud Rate: 38400
		4'b0111: begin k = 1736;k_div2 = 1736/2; end //Baud Rate: 57600
		4'b1000: begin k = 868; k_div2 = 868/2;end   //Baud Rate: 115200
		4'b1001: begin k = 434;k_div2 = 434/2; end   //Baud Rate: 230400
		4'b1010: begin k = 217;k_div2 = 217/2; end   //Baud Rate: 460800
		4'b1011: begin k = 109;k_div2 = 109/2; end  //Baud Rate: 921600
		default: begin k = 333333;k_div2 = 333333/2; end//Baud Rate: 300
	endcase
end

endmodule
