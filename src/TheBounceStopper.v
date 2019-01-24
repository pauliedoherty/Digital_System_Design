`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:37 10/09/2013 
// Design Name: 
// Module Name:    DEBOUNCE 
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
module TheBounceStopper(
    input button,
    input timerOF,
	 input clk,
    input rst,
	 output reg pulse,
	 output reg timerstart
    );


localparam [1:0] INIT = 2'b00, waitingp = 2'b01, pout = 2'b10; //describing states
reg [1:0] state, next_state;

   //(* FSM_ENCODING="SEQUNTIAL", SAFE_IMPLEMENTATION="YES", SAFE_RECOVERY_STATE="<recovery_state_value>" *) reg [1:0] state = <state1>;

   always@(posedge clk or posedge rst)
     begin if (rst)
      state <= INIT;
      else
		state <= next_state;
		end
		
		
		always @ (state or button or timerOF)
            case(state)
				INIT : begin
					next_state = button ? waitingp : INIT;
					pulse = 1'b0;  
					timerstart = 1'b0;
            end
           
			   waitingp : begin
				if (timerOF == 0) begin
					next_state = waitingp;
					pulse = 1'b0;
					timerstart = 1'b1;
					end
				else if (button) begin
					next_state = pout;
					pulse = 1'b1;
					timerstart = 1'b0;
					end
				else begin
					next_state = INIT;
					pulse = 1'b0;
					timerstart = 1'b0;
            end
				end
				
				
            pout : begin
				timerstart = 1'b0;
            if (button == 0) begin
					next_state = INIT;
					pulse = 1'b0;
					end
            else begin
					next_state = pout;
					pulse = 1'b0;
            end
				end
            
				default : begin  // Fault Recovery
					next_state = INIT;
					timerstart = 1'b0;
					pulse = 1'b0;
            end   
         endcase
		
endmodule
		
			