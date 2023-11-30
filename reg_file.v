`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 17:15:25
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk, WE3,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    output [31:0] RD1, RD2
    );
    
    reg [31:0] mem [31:0];
    
    always @(posedge clk) begin
        if(WE3)
            mem[A3] <= WD3;
    end
    
    assign RD1 = (A1 != 0) ? mem[A1] : 0;
    assign RD2 = (A2 != 0) ? mem[A2] : 0;
    
endmodule
