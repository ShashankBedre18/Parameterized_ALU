`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : arithmetic_unit
 * Author      : Shashank Bedre
 * Description : Arithmetic Unit (ADD / SUB)
 ******************************************************************************/
import alu_pkg::*;
module arithmetic_unit #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,

    
    input  alu_opcode_t opcode,

    output logic [WIDTH-1:0] result,
    output logic             carry,
    output logic             overflow

);

//----------------------------------------------------------
// Internal Signals
//----------------------------------------------------------

logic [WIDTH:0] add_temp;
logic [WIDTH:0] sub_temp;

assign add_temp = {1'b0, A} + {1'b0, B};
assign sub_temp = {1'b0, A} - {1'b0, B};

//----------------------------------------------------------
// Arithmetic Operation
//----------------------------------------------------------

always_comb begin

    result   = '0;
    carry    = 1'b0;
    overflow = 1'b0;

    unique case (opcode)

        ADD: begin

            result = add_temp[WIDTH-1:0];
            carry  = add_temp[WIDTH];

            overflow =
                (~(A[WIDTH-1] ^ B[WIDTH-1])) &
                 (A[WIDTH-1] ^ result[WIDTH-1]);

        end

        SUB: begin

            result = sub_temp[WIDTH-1:0];
            carry  = sub_temp[WIDTH];

            overflow =
                (A[WIDTH-1] ^ B[WIDTH-1]) &
                (A[WIDTH-1] ^ result[WIDTH-1]);

        end

        default: begin

            result   = '0;
            carry    = 1'b0;
            overflow = 1'b0;

        end

    endcase

end

endmodule