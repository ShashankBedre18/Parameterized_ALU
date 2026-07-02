`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : logic_unit
 * Author      : Shashank Bedre
 * Description : Logic Unit
 ******************************************************************************/
import alu_pkg::*;
module logic_unit #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,

    
    input  alu_opcode_t opcode,

    output logic [WIDTH-1:0] result

);

//----------------------------------------------------------
// Logic Operations
//----------------------------------------------------------

always_comb begin

    result = '0;

    unique case(opcode)

        AND_ :
            result = A & B;

        OR_ :
            result = A | B;

        XOR_ :
            result = A ^ B;

        XNOR_ :
            result = ~(A ^ B);

        NOTA :
            result = ~A;

        NOTB :
            result = ~B;

        default :
            result = '0;

    endcase

end

endmodule