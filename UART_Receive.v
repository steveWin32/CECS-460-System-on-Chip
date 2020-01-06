`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:55 10/28/2018 
// Design Name: 
// Module Name:    UART_Receive 
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
module UART_Receive(k,k_div2,Rx,port_id,reads,ohel,eight,pen,clk,reset,data,perror,ferror,oerror,RxRdy);
wire start,doIt;
input ohel,eight,pen;
input [19:0] k;
input [19:0] k_div2;
input clk,reset,Rx;
input [15:0] port_id;
input [15:0] reads;
wire Done;
wire BTU;
output RxRdy;
output [7:0] data;
output perror,ferror,oerror;


BitTimeCounterReceive bc2(.start(start),.k(k),.k_div2(k_div2),.doIt(doIt),.clk(clk),.reset(reset),.BTU(BTU));
BitCounterReceive bcr(.clk(clk),.reset(reset),.do_it(doIt),.start(start),.btu(BTU),.eight(eight),.pen(pen),.done_out(Done) );
RxStateMachine 		rx(.Rx(RxRdy),.Btu(BTU),.Done(Done),.clk(clk),.reset(reset),.DoIt(doIt),.Start(start));

receive_datapath  re1(.clk(clk),.reset(reset),.BTU(BTU),.start(start),.port_id(port_id),.reads(reads),.rx(Rx),.rx_rdy(RxRdy),.ohel(ohel),.eight(eight),.pen(pen),.done_d(Done),.perr(perror),.ferr(ferror),.ovf(oerror),.out_port(data));


endmodule
