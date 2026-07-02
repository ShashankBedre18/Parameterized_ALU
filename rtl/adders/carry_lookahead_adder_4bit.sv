`timescale 1ns/1ps
/******************************************************************************
 * Module : carry_lookahead_adder_4bit
 ******************************************************************************/

module carry_lookahead_adder_4bit(

    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic       Cin,

    output logic [3:0] SUM,
    output logic       Cout

);

logic [3:0] P;
logic [3:0] G;

logic C1,C2,C3,C4;

always_comb begin

    P = A ^ B;
    G = A & B;

    C1 = G[0] | (P[0] & Cin);

    C2 = G[1]
       | (P[1] & G[0])
       | (P[1] & P[0] & Cin);

    C3 = G[2]
       | (P[2] & G[1])
       | (P[2] & P[1] & G[0])
       | (P[2] & P[1] & P[0] & Cin);

    C4 = G[3]
       | (P[3] & G[2])
       | (P[3] & P[2] & G[1])
       | (P[3] & P[2] & P[1] & G[0])
       | (P[3] & P[2] & P[1] & P[0] & Cin);

    SUM[0] = P[0] ^ Cin;
    SUM[1] = P[1] ^ C1;
    SUM[2] = P[2] ^ C2;
    SUM[3] = P[3] ^ C3;

    Cout = C4;

end

endmodule