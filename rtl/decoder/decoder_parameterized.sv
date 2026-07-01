`timescale 1ns/1ps
/******************************************************************************
 * Module : decoder_parameterized
 ******************************************************************************/

module decoder_parameterized #(

    parameter N = 3

)(
    input  logic [N-1:0] in,
    output logic [(1<<N)-1:0] out

);

always_comb begin

    out = '0;
    out[in] = 1'b1;

end

endmodule