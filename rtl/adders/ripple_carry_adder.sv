`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : ripple_carry_adder
 * Author      : Shashank Bedre
 * Description : Parameterized Ripple Carry Adder
 ******************************************************************************/

module ripple_carry_adder #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,
    input  logic             Cin,

    output logic [WIDTH-1:0] SUM,
    output logic             Cout

);

logic [WIDTH:0] carry;

assign carry[0] = Cin;

genvar i;

generate

    for(i=0;i<WIDTH;i=i+1)

    begin : RCA

        full_adder FA(

            .A   (A[i]),
            .B   (B[i]),
            .Cin (carry[i]),

            .SUM (SUM[i]),
            .Cout(carry[i+1])

        );

    end

endgenerate

assign Cout = carry[WIDTH];

endmodule