`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : gray_cell
 * Author      : Shashank Bedre
 * Description : Gray Cell for Parallel Prefix Adders
 ******************************************************************************/

module gray_cell(

    input  logic Gi,
    input  logic Pi,
    input  logic Gj,

    output logic Gout

);

always_comb begin

    Gout = Gi | (Pi & Gj);

end

endmodule