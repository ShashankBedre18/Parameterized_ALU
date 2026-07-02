`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : arithmetic_unit_tb
 * Author      : Shashank Bedre
 * Description : Self-Checking Testbench
 ******************************************************************************/

module arithmetic_unit_tb;

parameter WIDTH = 32;

import alu_pkg::*;

//----------------------------------------------------------
// DUT Signals
//----------------------------------------------------------

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;

alu_opcode_t opcode;

logic [WIDTH-1:0] result;

logic carry;
logic overflow;

//----------------------------------------------------------
// DUT
//----------------------------------------------------------

arithmetic_unit #(

    .WIDTH(WIDTH)

)dut(

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(result),

    .carry(carry),
    .overflow(overflow)

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

        $display("[PASS] A=%h B=%h Result=%h",
                  A,B,result);

    else begin

        $display("[FAIL]");

        $display("Expected = %h",expected);

        $display("Got      = %h",result);

        $finish;

    end

end

endtask

//----------------------------------------------------------
// Test Sequence
//----------------------------------------------------------

initial begin

    $display("--------------------------------");
    $display(" Arithmetic Unit Test Started");
    $display("--------------------------------");

    //------------------------------------------------------
    // ADD
    //------------------------------------------------------

    check(10,20,ADD,30);

    check(100,50,ADD,150);

    check(32'hFFFFFFFF,
          32'h00000001,
          ADD,
          32'h00000000);

    //------------------------------------------------------
    // SUB
    //------------------------------------------------------

    check(20,10,SUB,10);

    check(100,25,SUB,75);

    check(50,50,SUB,0);

    //------------------------------------------------------
    // Random Tests
    //------------------------------------------------------

    repeat(100)

    begin

        A = $urandom;

        B = $urandom;

        opcode = ADD;

        #5;

        if(result != (A+B))

        begin

            $display("Random ADD Failed");

            $finish;

        end

        opcode = SUB;

        #5;

        if(result != (A-B))

        begin

            $display("Random SUB Failed");

            $finish;

        end

    end

    //------------------------------------------------------

    $display("--------------------------------");

    $display(" ALL TESTS PASSED ");

    $display("--------------------------------");

    $finish;

end

endmodule