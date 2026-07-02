`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : black_cell
 * Author      : Shashank Bedre
 * Description : Black Cell for Parallel Prefix Adders
 ******************************************************************************/

module black_cell(

    input  logic Gi,
    input  logic Pi,

    input  logic Gj,
    input  logic Pj,

    output logic Gout,
    output logic Pout

);

always_comb begin

    Gout = Gi | (Pi & Gj);

    Pout = Pi & Pj;

end

endmodule