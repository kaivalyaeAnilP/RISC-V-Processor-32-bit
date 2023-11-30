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
