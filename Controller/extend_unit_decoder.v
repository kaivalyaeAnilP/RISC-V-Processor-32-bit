`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2023 14:18:47
// Design Name: 
// Module Name: extend_unit_decoder
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


module extend_unit_decoder(
    input [6:0] opcode,
    output reg [1:0] imm_src
    );
    
    always @(*) begin
        case(opcode)
            7'b0000011: imm_src = 2'b00;
            7'b0100011: imm_src = 2'b01;
            7'b0110011: imm_src = 2'bxx;
            7'b1100011: imm_src = 2'b10;
            7'b0010011: imm_src = 2'b00;
            7'b1101111: imm_src = 2'b11;
            default:    imm_src = 2'bxx;
        endcase
    end
    
endmodule
