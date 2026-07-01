`timescale 1ns/1ps
/***************************************************************************
 * Project      : Parameterized ALU + Register File + Arithmetic Library
 * Module       : mux_2to1
 * Author       : Shashank Bedre
 * Language     : SystemVerilog
 *
 * Description:
 * Parameterized 2:1 Multiplexer
 * Selects one of two WIDTH-bit inputs based on the select signal.
 ***************************************************************************/

module mux_2to1 #(
    parameter int WIDTH = 32
)(
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    input  logic             sel,
    output logic [WIDTH-1:0] out
);

    always_comb begin
        if (sel)
            out = in1;
        else
            out = in0;
    end

endmodule