`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : compare_unit
 * Author      : Shashank Bedre
 * Description : Compare Unit
 ******************************************************************************/
import alu_pkg::*;
module compare_unit #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,

    
    input  alu_opcode_t opcode,

    output logic [WIDTH-1:0] result,

    output logic eq,
    output logic gt,
    output logic lt,

    output logic sgt,
    output logic slt

);

//----------------------------------------------------------
// Comparison Flags
//----------------------------------------------------------

always_comb begin

    eq  = (A == B);

    gt  = (A > B);
    lt  = (A < B);

    sgt = ($signed(A) > $signed(B));
    slt = ($signed(A) < $signed(B));

end

//----------------------------------------------------------
// Compare Result
//----------------------------------------------------------

always_comb begin

    result = '0;

    unique case(opcode)

        EQ :
            result = {{(WIDTH-1){1'b0}}, eq};

        GT :
            result = {{(WIDTH-1){1'b0}}, gt};

        LT :
            result = {{(WIDTH-1){1'b0}}, lt};

        default :
            result = '0;

    endcase

end

endmodule