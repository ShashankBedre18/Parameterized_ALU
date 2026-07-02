`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : carry_skip_adder
 * Author      : Shashank Bedre
 * Language    : SystemVerilog
 *
 * Description :
 * Parameterized Carry Skip Adder
 ******************************************************************************/

module carry_skip_adder #(
    parameter WIDTH = 16
)(
    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,
    input  logic             Cin,

    output logic [WIDTH-1:0] SUM,
    output logic             Cout
);

logic [WIDTH:0] carry;
logic [WIDTH-1:0] P;
logic [WIDTH-1:0] G;

assign carry[0] = Cin;

always_comb begin

    for(int i=0;i<WIDTH;i++) begin

        P[i] = A[i] ^ B[i];
        G[i] = A[i] & B[i];

        SUM[i] = P[i] ^ carry[i];

        carry[i+1] = G[i] | (P[i] & carry[i]);

    end

end

//------------------------------------------------------
// Block Propagate
//------------------------------------------------------

logic block_propagate;

assign block_propagate = &P;

//------------------------------------------------------
// Skip Logic
//------------------------------------------------------

assign Cout = (block_propagate) ? Cin : carry[WIDTH];

endmodule