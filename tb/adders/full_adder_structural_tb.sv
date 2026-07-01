`timescale 1ns/1ps

module full_adder_structural_tb;

logic A;
logic B;
logic Cin;

logic SUM;
logic Cout;

full_adder_structural dut(

.A(A),
.B(B),
.Cin(Cin),
.SUM(SUM),
.Cout(Cout)

);

initial begin

for(int i=0;i<8;i++) begin

    {A,B,Cin}=i;

    #10;

    if({Cout,SUM}!=(A+B+Cin))
        $error("FAILED");

end

$display("All Tests Passed");

$finish;

end

endmodule