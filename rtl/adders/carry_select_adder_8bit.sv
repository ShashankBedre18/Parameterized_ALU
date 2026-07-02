`timescale 1ns/1ps

module carry_select_adder_8bit(

    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic       Cin,

    output logic [7:0] SUM,
    output logic       Cout

);

logic c4;

logic [3:0] sum0,sum1;
logic c0,c1;

// Lower 4-bit RCA

ripple_carry_adder #(.WIDTH(4)) RCA_LOW(

    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),

    .SUM(SUM[3:0]),
    .Cout(c4)

);

// Upper assuming Cin=0

ripple_carry_adder #(.WIDTH(4)) RCA0(

    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(1'b0),

    .SUM(sum0),
    .Cout(c0)

);

// Upper assuming Cin=1

ripple_carry_adder #(.WIDTH(4)) RCA1(

    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(1'b1),

    .SUM(sum1),
    .Cout(c1)

);

always_comb begin

    if(c4) begin

        SUM[7:4]=sum1;
        Cout=c1;

    end

    else begin

        SUM[7:4]=sum0;
        Cout=c0;

    end

end

endmodule