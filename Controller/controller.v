`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2023 20:11:22
// Design Name: 
// Module Name: Controller
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


module controller(
    input clk, rst,
    input zero, funct7,
    input [6:0] opcode,
    input [2:0] funct3,
    output branch, PC_update, reg_write, mem_write, IR_write, 
    output address_src,
    output [1:0] result_src, alu_src_B, alu_src_A, imm_src,
    output [2:0] alu_control
    );
    
    main_fsm fsm(.clk(clk),.rst(rst),.opcode(opcode),.branch(branch),.PC_update(PC_update),.reg_write(reg_write),.mem_write(mem_write),.IR_write(IR_write),.address_src(address_src),.result_src(result_src),.alu_src_B(alu_src_B),.alu_src_A(alu_src_A),.alu_op(alu_op));
    extend_unit_decoder eud(.opcode(opcode),.imm_src(imm_src));
    alu_decoder ad(.alu_op(alu_op),.funct3(funct3),.funct7(funct7),.opcode5(opcode[5]),.alu_control(alu_control));
    
endmodule
