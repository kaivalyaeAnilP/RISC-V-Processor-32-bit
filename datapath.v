module datapath(
    input clk,                                              //clk
    input PC_write, address_src, IR_write, reg_write,       //1 bit control signals 
    input [1:0] result_src, alu_src_A, alu_src_B, imm_src,  //2 bit control signals
    input [2:0] alu_control,                                //3 bit control signals
    input [31:0] mem_rd,                                    //data received from RAM after a read operation
    output [31:0] mem_wd,                                   //data sent to RAM for a write operation
    output [31:0] mem_address                               //address to read from or written to in RAM
    );
    
    wire [31:0] PC, old_PC, instr, RD1, RD2, result, imm_ext, A, B, src_A, src_B, alu_result, alu_out, data;
    
    reg_32_bit pc_reg(.clk(clk),.rst(rst),.en(PC_write),.in(result),.out(PC));        //Program Counter
    reg_32_bit old_pc_reg(.clk(clk),.rst(rst),.en(1'b1),.in(PC),.out(old_PC));        //Old Program Counter
    reg_32_bit ir(.clk(clk),.rst(rst),.en(IR_write),.in(mem_rd),.out(instr));         //Instruction Register
    
    extend ext(instr[31:7],imm_src,imm_ext);
    
    //register file of 32 32-bit registers interfaced by two buffer registers
    reg_file rf(.clk(clk),.WE3(reg_write),.A1(instr[19:15]),.A2(instr[24:20]),.A3(instr[11:7]),.WD3(result),.RD1(RD1),.RD2(RD2));
    reg_32_bit rfbr_A(.clk(clk),.rst(rst),.en(1'b1),.in(RD1),.out(A));
    reg_32_bit rfbr_B(.clk(clk),.rst(rst),.en(1'b1),.in(RD2),.out(B));
    
    mux3_1 m1(.i0(PC),.i1(old_PC),.i2(A),.sel(alu_src_A),.out(src_A));                //3:1 MUX selects right input to the alu
    mux3_1 m2(.i0(B),.i1(imm_ext),.i2(32'd4),.sel(alu_src_B),.out(src_B));            //3:1 MUX selects left input to the alu
    alu alu(src_A,src_B,alu_control,alu_result);                                      //ALU and buffer register
    reg_32_bit alu_buffer_register(.clk(clk),.rst(rst),.en(1'b1),.in(alu_result),.out(alu_out));
    mux3_1 m3(.i0(alu_out),.i1(data),.i2(alu_result),.sel(result_src),.out(result));  //3:1 MUX selects the result of the operation
    
    reg_32_bit mbr(.clk(clk),.rst(rst),.en(1'b1),.in(mem_rd),.out(data)); //Memory buffer register that stores data received from RAM after a read operation
    assign mem_address = (address_src)? result: PC;                       //MUX selects the address in memory that is to be read from or written to
    assign mem_wd = B;                                                    //Data to be sent to memory for a write operation
    
endmodule
