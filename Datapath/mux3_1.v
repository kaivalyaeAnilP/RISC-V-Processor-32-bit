`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 20:31:59
// Design Name: 
// Module Name: mux3_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux3_1(
    input i0, i1, i2,
    input [1:0] sel,
    output reg out
    );
    
    always @(*) begin
        case(sel) 
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
            default: out = 0;
        endcase
    end
    
endmodule
