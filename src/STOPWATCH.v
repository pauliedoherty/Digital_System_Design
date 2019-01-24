`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:38 10/16/2013 
// Design Name: 
// Module Name:    DiverCounter 
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
module DiverCounter(
  
    input clk,
    input rst,
    input [15:0] Time,
    output wire [7:0] segments,
	 output reg [3:0] digits //Will need to be changed
    );
reg [1:0] Q;
reg [9:0] s;
wire [1:0] nextQ;
reg [6:0] valdisp;
wire z, high;
wire [9:0] count, sum;
reg [3:0] tdisp;
//slow pulse generator for display

assign high =1'b1;
assign sum = high + s;
assign count = z ?  10'd0 : sum;

always@(posedge clk or posedge rst)
	if (rst) s <= 10'b0;
	else s <= count;
	
assign z = (s==10'd1023);
//end of slow pulse generator

reg dp; //wire for decimal point

//"-bit counter to act as a multiplexer selecter and display selecter
assign nextQ = z + Q;
always@(posedge clk or posedge rst)
    if (rst) Q <= 2'b00;
    else Q <= nextQ;
    
//Selects which bits of the 16bit counter to display and which segment to display them on
always @(Time or Q)
case (Q)
	2'b00: begin tdisp = Time[3:0];  //displays 1st set of bits on required segments
			 digits = 4'b1110;
          dp = 1'b1; end
			 
	2'b01: begin tdisp = Time[7:4];  //displays 2nd set of bits on required segments
	       digits = 4'b1101; 
			 dp = 1'b0; end
			 
	2'b10: begin tdisp = Time[11:8]; //displays 3rd set of bits on required segments
	       digits = 4'b1011; 
			 dp = 1'b1; end
			 
	2'b11: begin tdisp = Time[15:12];//displays 4th set of bits on required segments
			 digits = 4'b0111;
			 dp = 1'b1; end
			 
   default: begin 		 tdisp = Time[15:12]; //default should never arise
								 digits = 4'b0111; 
								 dp = 1'b1; end
endcase


//Look-up-table to decide which output is sent to the seven segment display
always@(tdisp)
case(tdisp)
	
	4'b0000: valdisp = 7'b0000001; //display fig 0
	4'b0001: valdisp = 7'b1001111; //display fig 1
	4'b0010: valdisp = 7'b0010010; //display fig 2
	4'b0011: valdisp = 7'b0000110; //display fig 3
	4'b0100: valdisp = 7'b1001100; //display fig 4
	4'b0101: valdisp = 7'b0100100; //display fig 5
	4'b0110: valdisp = 7'b0100000; //display fig 6
	4'b0111: valdisp = 7'b0001111; //display fig 7
	4'b1000: valdisp = 7'b0000000; //display fig 8	
	4'b1001: valdisp = 7'b0000100; //display fig 9
   4'b1010: valdisp = 7'b0001000; //display fig A
   4'b1011: valdisp = 7'b1100000; //display fig B
	4'b1100: valdisp = 7'b0110001; //display fig C
	4'b1101: valdisp = 7'b0110001; //display fig D
   4'b1110: valdisp = 7'b0110000; //display fig E
	4'b1111: valdisp = 7'b0111000; //display fig F

endcase
/*
always@(digits)
case (digits)

4'b1101: dp=1'b0;
default: dp=1'b1;
*/
	assign segments = {valdisp,dp};
	
	
endmodule 