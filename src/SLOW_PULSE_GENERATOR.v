`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:44:21 10/15/2013 
// Design Name: 
// Module Name:    SLOW_PULSE_GENERATOR 
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
module SLOW_PULSE_GENERATOR(
    input run,
    input rst,
    input clock, 
	 output reg  [15:0] Time  
    );
wire [18:0] added;
wire spulse;
wire [15:0] added2;
reg  [18:0]  Q;
// 19-bit wide output signal
wire [18:0] nextQ; 
wire [15:0] nextQ2;
// 19-bit wide internal signal
assign added = Q + run;//1 bit added to 19 bit
assign nextQ = spulse ? 19'b0 : added; //multiplexor
   

always @ (posedge clock or posedge rst) 
// register
if (rst) begin 
Q <= 19'b0; 
Time <= 16'b0;
end 
// reset forces counter Q and Time to 0
else begin 
Q <= nextQ;// otherwise Q takes nextQ
Time <= nextQ2;// and Time takes nextQ2
end


assign spulse = (Q == 19'd312499); 
assign added2 = Time + 1'b1;
assign nextQ2 = spulse ? added2 : Time; //multiplexor (when high add, when low remain the same)


endmodule 
