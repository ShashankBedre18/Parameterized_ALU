`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : half_adder
 * Author      : Shashank Bedre
 * Description : Half Adder
 ******************************************************************************/

module half_adder(

    input  logic A,
    input  logic B,

    output logic SUM,
    output logic CARRY

);

always_comb begin

    SUM   = A ^ B;
    CARRY = A & B;

end

endmodule