`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : full_adder
 * Description : 1-Bit Full Adder
 ******************************************************************************/

module full_adder(

    input  logic A,
    input  logic B,
    input  logic Cin,

    output logic SUM,
    output logic Cout

);

always_comb begin

    SUM  = A ^ B ^ Cin;

    Cout = (A & B) |
           (Cin & (A ^ B));

end

endmodule