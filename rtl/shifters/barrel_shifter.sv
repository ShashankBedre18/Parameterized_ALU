`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : barrel_shifter
 * Author      : Shashank Bedre
 * Description : Parameterized Barrel Shifter
 ******************************************************************************/

module barrel_shifter #(

    parameter WIDTH = 32

)(

    input  logic [WIDTH-1:0] data_in,
    input  logic [$clog2(WIDTH)-1:0] shift_amt,
    input  logic [2:0] shift_op,

    output logic [WIDTH-1:0] data_out

);

always_comb begin

    case(shift_op)

        3'b000 : data_out = data_in << shift_amt;

        3'b001 : data_out = data_in >> shift_amt;

        3'b010 : data_out = $signed(data_in) >>> shift_amt;

        3'b011 : data_out = (data_in << shift_amt) |
                            (data_in >> (WIDTH-shift_amt));

        3'b100 : data_out = (data_in >> shift_amt) |
                            (data_in << (WIDTH-shift_amt));

        default : data_out = data_in;

    endcase

end

endmodule