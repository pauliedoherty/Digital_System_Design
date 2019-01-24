`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:59 10/18/2013 
// Design Name: 
// Module Name:    delay 
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
module delay(
    input timerstart,
    input rst,
    input clock,
	 output [1:0] timerOF
    );

wire [18:0] added3;
reg  [18:0]  Q3;
// 19-bit wide output signal
wire [15:0] nextQ3;
// 19-bit wide internal signal
assign added3 = Q3 + 1'b1; //1 bit added to 19 bit
assign nextQ3 = timerstart ? added3 : 19'b0; //multiplexor
   

always @ (posedge clock or posedge rst) 
// register
if (rst) begin 
Q3 <= 19'b0; 
end 
// reset forces counter Q and Time to 0
else begin 
Q3 <= nextQ3;// otherwise Q takes nextQ
end

assign timerOF = (Q3 == 19'd50); 

endmodule
