`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : carry_select_adder
 * Author      : Shashank Bedre
 * Language    : SystemVerilog
 *
 * Description :
 * Parameterized Carry Select Adder
 ******************************************************************************/

module carry_select_adder #(
    parameter WIDTH = 16
)(
    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,
    input  logic             Cin,

    output logic [WIDTH-1:0] SUM,
    output logic             Cout
);

localparam HALF = WIDTH/2;

logic carry_mid;

logic [HALF-1:0] sum0;
logic [HALF-1:0] sum1;

logic cout0;
logic cout1;

//////////////////////////////////////////////////////////////
// Lower Half RCA
//////////////////////////////////////////////////////////////

ripple_carry_adder #(
    .WIDTH(HALF)
) RCA_LOW (

    .A   (A[HALF-1:0]),
    .B   (B[HALF-1:0]),
    .Cin (Cin),

    .SUM (SUM[HALF-1:0]),
    .Cout(carry_mid)

);

//////////////////////////////////////////////////////////////
// Upper RCA assuming Carry = 0
//////////////////////////////////////////////////////////////

ripple_carry_adder #(
    .WIDTH(HALF)
) RCA_C0 (

    .A   (A[WIDTH-1:HALF]),
    .B   (B[WIDTH-1:HALF]),
    .Cin (1'b0),

    .SUM (sum0),
    .Cout(cout0)

);

//////////////////////////////////////////////////////////////
// Upper RCA assuming Carry = 1
//////////////////////////////////////////////////////////////

ripple_carry_adder #(
    .WIDTH(HALF)
) RCA_C1 (

    .A   (A[WIDTH-1:HALF]),
    .B   (B[WIDTH-1:HALF]),
    .Cin (1'b1),

    .SUM (sum1),
    .Cout(cout1)

);

//////////////////////////////////////////////////////////////
// Carry Select Logic
//////////////////////////////////////////////////////////////

always_comb begin

    if(carry_mid) begin
        SUM[WIDTH-1:HALF] = sum1;
        Cout              = cout1;
    end
    else begin
        SUM[WIDTH-1:HALF] = sum0;
        Cout              = cout0;
    end

end

endmodule