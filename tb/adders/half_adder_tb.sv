`timescale 1ns/1ps

module half_adder_tb;

logic A;
logic B;

logic SUM;
logic CARRY;

half_adder dut(

    .A(A),
    .B(B),
    .SUM(SUM),
    .CARRY(CARRY)

);

initial begin

    $display("------------------------------------------");
    $display(" Half Adder Self Checking Testbench");
    $display("------------------------------------------");

    // Test 1
    A=0; B=0; #10;
    if(SUM!==0 || CARRY!==0)
        $error("Test1 Failed");

    // Test 2
    A=0; B=1; #10;
    if(SUM!==1 || CARRY!==0)
        $error("Test2 Failed");

    // Test 3
    A=1; B=0; #10;
    if(SUM!==1 || CARRY!==0)
        $error("Test3 Failed");

    // Test 4
    A=1; B=1; #10;
    if(SUM!==0 || CARRY!==1)
        $error("Test4 Failed");

    $display("------------------------------------------");
    $display(" ALL HALF ADDER TESTS PASSED ");
    $display("------------------------------------------");

    $finish;

end

endmodule