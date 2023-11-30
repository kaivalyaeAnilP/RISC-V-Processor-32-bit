`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 16:59:26
// Design Name: 
// Module Name: reg_32_bit
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


module reg_32_bit(
    input clk, rst, en,
    input [31:0] in,
    output reg [31:0] out
    );
    
    always @(posedge clk) begin
        if(rst)
            out <= 0;
        else begin
            if(en)
                out <= in;
        end
    end
    
endmodule
