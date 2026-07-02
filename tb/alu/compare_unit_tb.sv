`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : compare_unit_tb
 * Author      : Shashank Bedre
 * Description : Self-Checking Testbench
 ******************************************************************************/

module compare_unit_tb;

parameter WIDTH = 32;

import alu_pkg::*;

//----------------------------------------------------------
// DUT Signals
//----------------------------------------------------------

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;

alu_opcode_t opcode;

logic [WIDTH-1:0] result;

logic eq;
logic gt;
logic lt;

logic sgt;
logic slt;

//----------------------------------------------------------
// DUT
//----------------------------------------------------------

compare_unit #(

    .WIDTH(WIDTH)

)dut(

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(result),

    .eq(eq),
    .gt(gt),
    .lt(lt),

    .sgt(sgt),
    .slt(slt)

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
    $display(" Compare Unit Test Started");
    $display("--------------------------------");

    //----------------------------------
    // Equal
    //----------------------------------

    check(32'd100,
          32'd100,
          EQ,
          32'd1);

    //----------------------------------
    // Greater Than
    //----------------------------------

    check(32'd200,
          32'd100,
          GT,
          32'd1);

    //----------------------------------
    // Less Than
    //----------------------------------

    check(32'd50,
          32'd100,
          LT,
          32'd1);

    //----------------------------------
    // Equal False
    //----------------------------------

    check(32'd10,
          32'd20,
          EQ,
          32'd0);

    //----------------------------------
    // GT False
    //----------------------------------

    check(32'd10,
          32'd20,
          GT,
          32'd0);

    //----------------------------------
    // LT False
    //----------------------------------

    check(32'd20,
          32'd10,
          LT,
          32'd0);

    //----------------------------------
    // Signed Comparison Check
    //----------------------------------

    A = -5;
    B = 10;

    opcode = EQ;

    #10;

    if((sgt == 0) && (slt == 1))

        $display("[PASS] Signed Compare");

    else begin

        $display("[FAIL] Signed Compare");

        $finish;

    end

    //----------------------------------
    // Random Tests
    //----------------------------------

    repeat(100)

    begin

        A = $urandom;
        B = $urandom;

        opcode = EQ;

        #5;

        if(result != (A==B))

        begin

            $display("Random EQ Failed");
            $finish;

        end

        opcode = GT;

        #5;

        if(result != (A>B))

        begin

            $display("Random GT Failed");
            $finish;

        end

        opcode = LT;

        #5;

        if(result != (A<B))

        begin

            $display("Random LT Failed");
            $finish;

        end

    end

    //----------------------------------

    $display("--------------------------------");
    $display(" ALL COMPARE TESTS PASSED ");
    $display("--------------------------------");

    $finish;

end

endmodule