`timescale 1ns/1ps

module encoder_4to2_tb;

logic [3:0] in;
logic [1:0] out;

encoder_4to2 dut(

    .in(in),
    .out(out)

);

initial begin

    $display("Starting 4-to-2 Encoder Test");

    in = 4'b0001; #10;
    if(out != 2'b00) $error("Test 1 Failed");

    in = 4'b0010; #10;
    if(out != 2'b01) $error("Test 2 Failed");

    in = 4'b0100; #10;
    if(out != 2'b10) $error("Test 3 Failed");

    in = 4'b1000; #10;
    if(out != 2'b11) $error("Test 4 Failed");

    $display("---------------------------");
    $display(" ALL TESTS PASSED ");
    $display("---------------------------");

    $finish;

end

endmodule