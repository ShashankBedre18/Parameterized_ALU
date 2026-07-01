`timescale 1ns/1ps

module full_adder_tb;

logic A;
logic B;
logic Cin;

logic SUM;
logic Cout;

full_adder dut(

.A(A),
.B(B),
.Cin(Cin),
.SUM(SUM),
.Cout(Cout)

);

initial begin

$display("--------------------------------");
$display("Full Adder Testbench");
$display("--------------------------------");

for(int i=0;i<8;i++) begin

    {A,B,Cin}=i;

    #10;

    if({Cout,SUM}!=(A+B+Cin))
        $error("FAILED A=%0b B=%0b Cin=%0b",A,B,Cin);

end

$display("--------------------------------");
$display("ALL TESTS PASSED");
$display("--------------------------------");

$finish;

end

endmodule