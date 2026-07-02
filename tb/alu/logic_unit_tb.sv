`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : logic_unit_tb
 * Author      : Shashank Bedre
 * Description : Self-Checking Testbench
 ******************************************************************************/

module logic_unit_tb;

parameter WIDTH = 32;

import alu_pkg::*;

//----------------------------------------------------------
// DUT Signals
//----------------------------------------------------------

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;

alu_opcode_t opcode;

logic [WIDTH-1:0] result;

//----------------------------------------------------------
// DUT
//----------------------------------------------------------

logic_unit #(

    .WIDTH(WIDTH)

)dut(

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(result)

);

//----------------------------------------------------------
// Task
//----------------------------------------------------------

task automatic check;

    input logic [WIDTH-1:0] a;
    input logic [WIDTH-1:0] b;
    input alu_opcode_t op;
    input logic [WIDTH-1:0] expected;

begin

    A = a;
    B = b;
    opcode = op;

    #10;

    if(result == expected)

        $display("[PASS] Opcode=%0d Result=%h", op, result);

    else begin

        $display("[FAIL]");

        $display("Opcode   = %0d", op);
        $display("Expected = %h", expected);
        $display("Got      = %h", result);

        $finish;

    end

end

endtask

//----------------------------------------------------------
// Test Sequence
//----------------------------------------------------------

initial begin

    $display("--------------------------------");
    $display(" Logic Unit Test Started");
    $display("--------------------------------");

    //-------------------------------
    // AND
    //-------------------------------

    check(32'hAA55AA55,
          32'hFFFF0000,
          AND_,
          32'hAA550000);

    //-------------------------------
    // OR
    //-------------------------------

    check(32'hAA55AA55,
          32'hFFFF0000,
          OR_,
          32'hFFFFAA55);

    //-------------------------------
    // XOR
    //-------------------------------

    check(32'hAAAAAAAA,
          32'h55555555,
          XOR_,
          32'hFFFFFFFF);

    //-------------------------------
    // XNOR
    //-------------------------------

    check(32'hAAAAAAAA,
          32'h55555555,
          XNOR_,
          32'h00000000);

    //-------------------------------
    // NOT A
    //-------------------------------

    check(32'h0000FFFF,
          32'h00000000,
          NOTA,
          32'hFFFF0000);

    //-------------------------------
    // NOT B
    //-------------------------------

    check(32'h00000000,
          32'hFFFFFFFF,
          NOTB,
          32'h00000000);

    //-------------------------------
    // Random Tests
    //-------------------------------

    repeat(100)

    begin

        A = $urandom;
        B = $urandom;

        opcode = AND_;

        #5;

        if(result != (A&B))

        begin
            $display("Random AND Failed");
            $finish;
        end

        opcode = OR_;

        #5;

        if(result != (A|B))

        begin
            $display("Random OR Failed");
            $finish;
        end

        opcode = XOR_;

        #5;

        if(result != (A^B))

        begin
            $display("Random XOR Failed");
            $finish;
        end

    end

    //-------------------------------

    $display("--------------------------------");
    $display(" ALL LOGIC TESTS PASSED ");
    $display("--------------------------------");

    $finish;

end

endmodule