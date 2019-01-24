
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:26 10/15/2013 
// Design Name: 
// Module Name:    CONTROL_BLOCK 
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
module CONTROL_BLOCK(
    input pulse,
	 input clk,
	 input rst,
   output reg run
    );
 
 localparam stopped = 1'b0,  started = 1'b1;
 reg [1:0] state, next_state;


   //(* FSM_ENCODING="SEQUNTIAL", SAFE_IMPLEMENTATION="YES", SAFE_RECOVERY_STATE="<recovery_state_value>" *) reg [1:0] state = <state1>;

   always@(posedge clk or posedge rst)
     begin if (rst) 
      state <= stopped;
      else 
		state <= next_state;
		end 
				

always @ (state or pulse)				
				 case (state)
            stopped : begin
				run = 1'b0;
				
               if (pulse == 0) begin
						next_state = stopped;
						end
               else begin
                  next_state = started;
						end
            end
				
            started : begin
				run = 1'b1;
               if (pulse == 0) begin
                  next_state = started;
						end
               else begin
                  next_state = stopped;
						end
            end
         endcase
  endmodule
  