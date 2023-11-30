`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2023 20:16:39
// Design Name: 
// Module Name: main_fsm
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


module main_fsm(
    input clk, rst,
    input [6:0] opcode,
    output branch, PC_update, reg_write, mem_write, IR_write, 
    output address_src,
    output [1:0] result_src, alu_src_B, alu_src_A, alu_op
    );
    
    parameter fetch = 4'd0, decode = 4'd1, mem_adr = 4'd2, mem_rd = 4'd3, mem_WB = 4'd4, mem_wr = 4'd5;
    parameter execute_R = 4'd6, alu_WB = 4'd7, execute_I = 4'd8, JAL = 4'd9, BEQ = 4'd10;
    
    reg [3:0] current_state, next_state;  //State flip flops
    
    //Combinational always block for state transition logic
    always @(*) begin
        case(current_state)
            fetch: next_state = decode;
            decode: next_state = ((opcode == 7'b0000011)|(opcode == 7'b0100011)) ? mem_adr :
                                 (opcode == 7'b0110011) ? execute_R :
                                 (opcode == 7'b0010011) ? execute_I :
                                 (opcode == 7'b1101111) ? JAL :
                                 (opcode == 7'b1101111) ? BEQ : 
                                 fetch;
            mem_adr: next_state = (opcode == 7'b0000011) ? mem_rd:
                                  (opcode == 7'b0100011) ? mem_wr:
                                  fetch;
            mem_rd: next_state = mem_WB;
            mem_WB: next_state = fetch;
            mem_wr: next_state = fetch;
            execute_R: next_state = alu_WB;
            alu_WB: next_state = fetch;
            execute_I: next_state = alu_WB;
            JAL: next_state = alu_WB;
            BEQ: next_state = fetch;
        endcase
    end 
    
    //Edge-triggered always block for state flip flops
    always @(posedge clk) begin
        if(rst)
            current_state <= fetch;
        else
            current_state <= next_state;
    end
    
    //Initializing the control signals
    assign branch = (current_state == BEQ) ? 1'b1 : 1'b0;
    assign PC_update = (current_state == fetch) ? 1'b1 : 1'b0;
    assign reg_write = ((current_state == mem_WB)|(current_state == alu_WB)) ? 1'b1 : 1'b0;
    assign mem_write = (current_state == mem_wr) ? 1'b1 : 1'b0;
    assign IR_write = (current_state == fetch) ? 1'b1 : 1'b0;
    
    //initializing select lines for the multiplexers
    assign address_src = (current_state == fetch) ? 1'b0 :
                         ((current_state == mem_WB)|(current_state == alu_WB)) ? 1'b0 :
                         1'bx;
    assign result_src = ((current_state == JAL)|(current_state == BEQ)|(current_state == mem_rd)|(current_state == mem_wr)|(current_state == alu_WB)) ? 2'b00 :
                        (current_state == mem_WB) ? 2'b01 :
                        (current_state == fetch) ? 2'b10 :
                        2'bxx;
    assign alu_src_A = (current_state == fetch) ? 2'b00 :
                       ((current_state == decode)|(current_state == JAL)) ? 2'b01 :
                       ((current_state == mem_adr)|(current_state == execute_I)|(current_state == BEQ)) ? 2'b10 :
                       2'bxx;
    assign alu_src_B = ((current_state == execute_R)|(current_state == BEQ)) ? 2'b00 :
                       ((current_state == decode)|(current_state == mem_adr)|(current_state == JAL)) ? 2'b01 :
                       ((current_state == fetch)|(current_state == JAL)) ? 2'b10 :
                       2'bxx;
                       
    //initializing control lines to select alu operation
    assign alu_op = ((current_state == fetch)|(current_state == decode)|(current_state == mem_adr)|(current_state == JAL)) ? 2'b00 :
                    (current_state == BEQ) ? 2'b01 :
                    ((current_state == execute_I)|(current_state == execute_R)) ? 2'b10 :
                    2'bxx;
                       
endmodule
