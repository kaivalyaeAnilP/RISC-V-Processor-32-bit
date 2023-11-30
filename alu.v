`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2023 00:39:25
// Design Name: 
// Module Name: processor
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


module alu(
    input [31:0] src_A, src_B,
    input [2:0] alu_control,
    output [31:0] alu_result
    );
    
    wire [31:0] sum,andAB,orAB,slt,right_in;
    assign right_in = (alu_control[0])? ~src_B: src_B;
    adder (.a(src_A),.b(right_in),.y(sum));
    and (andAB,src_A,src_B);
    or (orAB,src_A,src_B);
    assign slt = {sum[30:0],1'b0};
    mux5_1 (.i0(sum),.i1(sum),.i2(andAB),.i3(orAB),.i4(slt),.sel(alu_control),.out(alu_result));
    
endmodule