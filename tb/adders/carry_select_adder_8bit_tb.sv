`timescale 1ns/1ps

module carry_select_adder_8bit_tb;

logic [7:0] A,B;
logic Cin;

logic [7:0] SUM;
logic Cout;

logic [8:0] expected;

carry_select_adder_8bit dut(

.A(A),
.B(B),
.Cin(Cin),
.SUM(SUM),
.Cout(Cout)

);

initial begin

repeat(50) begin

    A=$urandom;
    B=$urandom;
    Cin=$urandom_range(0,1);

    #10;

    expected=A+B+Cin;

    if({Cout,SUM}!==expected)

        $error("FAILED");

end

$display("Carry Select Adder PASSED");

$finish;

end

endmodule