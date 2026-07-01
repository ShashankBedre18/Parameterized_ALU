`timescale 1ns/1ps
/******************************************************************************
 * Module : full_adder_structural
 * Description : Full Adder using two Half Adders
 ******************************************************************************/

module full_adder_structural(

    input  logic A,
    input  logic B,
    input  logic Cin,

    output logic SUM,
    output logic Cout

);

logic sum1;
logic carry1;
logic carry2;

// Half Adder 1
half_adder HA1(

    .A(A),
    .B(B),
    .SUM(sum1),
    .CARRY(carry1)

);

// Half Adder 2
half_adder HA2(

    .A(sum1),
    .B(Cin),
    .SUM(SUM),
    .CARRY(carry2)

);

// Final Carry

assign Cout = carry1 | carry2;

endmodule