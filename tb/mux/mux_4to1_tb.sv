`timescale 1ns/1ps

/******************************************************************************
 * Project     : Parameterized ALU + Register File + Arithmetic Library
 * Module      : mux_4to1_tb
 * Author      : Shashank Bedre
 * Description : Self-checking Testbench for 4:1 Multiplexer
 ******************************************************************************/

module mux_4to1_tb;

localparam WIDTH = 8;

// Inputs
logic [WIDTH-1:0] in0;
logic [WIDTH-1:0] in1;
logic [WIDTH-1:0] in2;
logic [WIDTH-1:0] in3;
logic [1:0] sel;

// Output
logic [WIDTH-1:0] out;

// DUT
mux_4to1 #(
    .WIDTH(WIDTH)
) dut (
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .sel(sel),
    .out(out)
);

initial begin

    in0 = 8'hAA;
    in1 = 8'h55;
    in2 = 8'hF0;
    in3 = 8'h0F;

    sel = 2'b00;
    #10;
    if(out != in0) $error("Test 1 Failed");

    sel = 2'b01;
    #10;
    if(out != in1) $error("Test 2 Failed");

    sel = 2'b10;
    #10;
    if(out != in2) $error("Test 3 Failed");

    sel = 2'b11;
    #10;
    if(out != in3) $error("Test 4 Failed");

    $display("--------------------------------");
    $display(" ALL TEST CASES PASSED ");
    $display("--------------------------------");

    $finish;

end

endmodule