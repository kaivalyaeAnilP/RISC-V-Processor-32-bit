`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2023 22:33:22
// Design Name: 
// Module Name: mux5_1
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


module mux5_1(
    input [31:0] i0,i1,i2,i3,i4,
    input [2:0] sel,
    output reg [31:0] out
    );
    
    always @(*) begin
        case(sel) 
            3'b000: out = i0;
            3'b001: out = i1;
            3'b010: out = i2;
            3'b011: out = i3;
            3'b100: out = i4;
            default: out = 0;
        endcase
    end
    
endmodule
