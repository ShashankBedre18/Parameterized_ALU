`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Arithmetic Library
 * Module      : comparator
 * Author      : Shashank Bedre
 * Description : Parameterized Comparator
 ******************************************************************************/

module comparator #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,

    output logic eq,
    output logic neq,
    output logic gt,
    output logic lt,
    output logic gte,
    output logic lte

);

always_comb begin

    eq  = (A == B);
    neq = (A != B);

    gt  = (A > B);
    lt  = (A < B);

    gte = (A >= B);
    lte = (A <= B);

end

endmodule