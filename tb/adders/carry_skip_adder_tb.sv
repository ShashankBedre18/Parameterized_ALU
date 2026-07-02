`timescale 1ns/1ps

module carry_skip_adder_tb;

parameter WIDTH = 16;

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;
logic Cin;

logic [WIDTH-1:0] SUM;
logic Cout;

logic [WIDTH:0] expected;

carry_skip_adder #(
    .WIDTH(WIDTH)
)dut(

    .A(A),
    .B(B),
    .Cin(Cin),
    .SUM(SUM),
    .Cout(Cout)

);

initial begin

repeat(100) begin

    A   = $urandom;
    B   = $urandom;
    Cin = $urandom_range(0,1);

    #10;

    expected = A + B + Cin;

    if({Cout,SUM} !== expected)

        $error("FAILED");

end

$display("--------------------------------");
$display("Carry Skip Adder PASSED");
$display("--------------------------------");

$finish;

end

endmodule