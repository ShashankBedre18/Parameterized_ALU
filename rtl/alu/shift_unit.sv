`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : shift_unit
 * Author      : Shashank Bedre
 * Description : Shift and Rotate Unit
 ******************************************************************************/
import alu_pkg::*;
module shift_unit #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,

    
    input  alu_opcode_t opcode,

    output logic [WIDTH-1:0] result

);

//----------------------------------------------------------
// Shift Amount
//----------------------------------------------------------

logic [$clog2(WIDTH)-1:0] shamt;

assign shamt = B[$clog2(WIDTH)-1:0];

//----------------------------------------------------------
// Shift / Rotate Operations
//----------------------------------------------------------

always_comb begin

    result = '0;

    unique case(opcode)

        //--------------------------------------------------
        // Logical Left Shift
        //--------------------------------------------------

        SLL :
            result = A << shamt;

        //--------------------------------------------------
        // Logical Right Shift
        //--------------------------------------------------

        SRL :
            result = A >> shamt;

        //--------------------------------------------------
        // Arithmetic Right Shift
        //--------------------------------------------------

        SRA :
            result = $signed(A) >>> shamt;

        //--------------------------------------------------
        // Rotate Left
        //--------------------------------------------------

        ROL : begin

            if(shamt == 0)
                result = A;
            else
                result = (A << shamt) |
                         (A >> (WIDTH-shamt));

        end

        //--------------------------------------------------
        // Rotate Right
        //--------------------------------------------------

        ROR : begin

            if(shamt == 0)
                result = A;
            else
                result = (A >> shamt) |
                         (A << (WIDTH-shamt));

        end

        //--------------------------------------------------

        default :
            result = '0;

    endcase

end

endmodule