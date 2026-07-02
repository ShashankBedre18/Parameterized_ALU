`timescale 1ns/1ps

module carry_lookahead_adder_4bit_tb;

logic [3:0] A,B;
logic Cin;

logic [3:0] SUM;
logic Cout;

logic [4:0] expected;

carry_lookahead_adder_4bit dut(
.A(A),
.B(B),
.Cin(Cin),
.SUM(SUM),
.Cout(Cout)
);

initial begin

repeat(30) begin

    A   = $urandom;
    B   = $urandom;
    Cin = $urandom_range(0,1);

    #10;

    expected = A+B+Cin;

    if({Cout,SUM}!==expected)
        $error("FAILED");

end

$display("CLA PASSED");

$finish;

end

endmodule