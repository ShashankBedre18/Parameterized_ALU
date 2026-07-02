`timescale 1ns/1ps

module ripple_carry_adder_tb;

parameter WIDTH = 8;

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;
logic             Cin;

logic [WIDTH-1:0] SUM;
logic             Cout;

logic [WIDTH:0] expected;

ripple_carry_adder #(
    .WIDTH(WIDTH)
) dut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .SUM(SUM),
    .Cout(Cout)
);

initial begin

    $display("======================================");
    $display("Ripple Carry Adder Testbench");
    $display("======================================");

    repeat (20) begin

        A   = $urandom;
        B   = $urandom;
        Cin = $urandom_range(0,1);

        #10;

        expected = A + B + Cin;

        if ({Cout,SUM} !== expected)
            $error("FAILED : A=%0d B=%0d Cin=%0d Expected=%0d Got=%0d",
                   A,B,Cin,expected,{Cout,SUM});
    end

    $display("======================================");
    $display("ALL TESTS PASSED");
    $display("======================================");

    $finish;

end

endmodule