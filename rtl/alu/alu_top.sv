`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : parameterized_alu
 * Author      : Shashank Bedre
 * Description : Top-Level Parameterized ALU
 ******************************************************************************/
import alu_pkg::*;
module alu_top #(

    parameter WIDTH = 32

)(

    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,

    
    input alu_opcode_t opcode,

    output logic [WIDTH-1:0] result,

    output logic zero_flag,
    output logic negative_flag,
    output logic carry_flag,
    output logic overflow_flag

);

//----------------------------------------------------------
// Internal Signals
//----------------------------------------------------------

logic [WIDTH-1:0] arithmetic_result;
logic [WIDTH-1:0] logic_result;
logic [WIDTH-1:0] shift_result;
logic [WIDTH-1:0] compare_result;

logic carry;
logic overflow;

logic eq;
logic gt;
logic lt;

logic sgt;
logic slt;

//----------------------------------------------------------
// Arithmetic Unit
//----------------------------------------------------------

arithmetic_unit #(

    .WIDTH(WIDTH)

) ARITH (

    .A(A),
    .B(B),
    .opcode(opcode),

    .result(arithmetic_result),

    .carry(carry),
    .overflow(overflow)

);

//----------------------------------------------------------
// Logic Unit
//----------------------------------------------------------

logic_unit #(

    .WIDTH(WIDTH)

) LOGIC (

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(logic_result)

);

//----------------------------------------------------------
// Shift Unit
//----------------------------------------------------------

shift_unit #(

    .WIDTH(WIDTH)

) SHIFT (

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(shift_result)

);

//----------------------------------------------------------
// Compare Unit
//----------------------------------------------------------

compare_unit #(

    .WIDTH(WIDTH)

) COMP (

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(compare_result),

    .eq(eq),
    .gt(gt),
    .lt(lt),

    .sgt(sgt),
    .slt(slt)

);

//----------------------------------------------------------
// Result Selection
//----------------------------------------------------------

always_comb begin

    result='0;

    unique case(opcode)

        ADD,
        SUB :

            result=arithmetic_result;

        AND_,
        OR_,
        XOR_,
        XNOR_,
        NOTA,
        NOTB :

            result=logic_result;

        SLL,
        SRL,
        SRA,
        ROL,
        ROR :

            result=shift_result;

        EQ,
        GT,
        LT :

            result=compare_result;

        default :

            result='0;

    endcase

end

//----------------------------------------------------------
// Status Flags
//----------------------------------------------------------

always_comb begin

    zero_flag     = (result == '0);
    negative_flag = result[WIDTH-1];

    carry_flag    = 1'b0;
    overflow_flag = 1'b0;

    unique case(opcode)

        ADD,
        SUB: begin
            carry_flag    = carry;
            overflow_flag = overflow;
        end

        default: begin
            carry_flag    = 1'b0;
            overflow_flag = 1'b0;
        end

    endcase

end
endmodule