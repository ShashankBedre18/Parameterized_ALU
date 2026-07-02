`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : alu_top_tb
 * Author      : Shashank Bedre
 * Description : Top-Level ALU Self-Checking Testbench
 ******************************************************************************/

module alu_top_tb;

parameter WIDTH = 32;

import alu_pkg::*;

//----------------------------------------------------------
// DUT Signals
//----------------------------------------------------------

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;

alu_opcode_t opcode;

logic [WIDTH-1:0] result;

logic zero_flag;
logic negative_flag;
logic carry_flag;
logic overflow_flag;

//----------------------------------------------------------
// Statistics
//----------------------------------------------------------

integer pass_count;
integer fail_count;

//----------------------------------------------------------
// DUT
//----------------------------------------------------------

alu_top #(

    .WIDTH(WIDTH)

)dut(

    .A(A),
    .B(B),

    .opcode(opcode),

    .result(result),

    .zero_flag(zero_flag),
    .negative_flag(negative_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag)

);

//----------------------------------------------------------
// Check Task
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

    if(result === expected)

    begin

        pass_count++;

        $display("[PASS] Opcode=%0d Result=%h",
                 op,result);

    end

    else

    begin

        fail_count++;

        $display("--------------------------------");

        $display("[FAIL]");

        $display("Opcode   : %0d",op);

        $display("A        : %h",A);

        $display("B        : %h",B);

        $display("Expected : %h",expected);

        $display("Result   : %h",result);

        $display("--------------------------------");

    end

end

endtask

//----------------------------------------------------------
// Test Sequence
//----------------------------------------------------------

initial begin

pass_count = 0;

fail_count = 0;

$display("");

$display("======================================");

$display("      ALU TOP VERIFICATION");

$display("======================================");

    //------------------------------------------------------
    // Arithmetic Tests
    //------------------------------------------------------

    check(32'd10,
          32'd20,
          ADD,
          32'd30);

    check(32'd20,
          32'd10,
          SUB,
          32'd10);

    check(32'hFFFFFFFF,
          32'd1,
          ADD,
          32'h00000000);

    //------------------------------------------------------
    // Logic Tests
    //------------------------------------------------------

    check(32'hAA55AA55,
          32'hFFFF0000,
          AND_,
          32'hAA550000);

    check(32'hAA55AA55,
          32'hFFFF0000,
          OR_,
          32'hFFFFAA55);

    check(32'hAAAAAAAA,
          32'h55555555,
          XOR_,
          32'hFFFFFFFF);

    check(32'hAAAAAAAA,
          32'h55555555,
          XNOR_,
          32'h00000000);

    check(32'h0000FFFF,
          32'h00000000,
          NOTA,
          32'hFFFF0000);

    check(32'h00000000,
          32'hFFFFFFFF,
          NOTB,
          32'h00000000);

    //------------------------------------------------------
    // Shift Tests
    //------------------------------------------------------

    check(32'h00000001,
          32'd4,
          SLL,
          32'h00000010);

    check(32'h00000010,
          32'd4,
          SRL,
          32'h00000001);

    check(32'h80000000,
          32'd1,
          SRA,
          32'hC0000000);

    check(32'h80000001,
          32'd1,
          ROL,
          32'h00000003);

    check(32'h80000001,
          32'd1,
          ROR,
          32'hC0000000);

    //------------------------------------------------------
    // Compare Tests
    //------------------------------------------------------

    check(32'd100,
          32'd100,
          EQ,
          32'd1);

    check(32'd200,
          32'd100,
          GT,
          32'd1);

    check(32'd50,
          32'd100,
          LT,
          32'd1);

    check(32'd10,
          32'd20,
          EQ,
          32'd0);

    check(32'd10,
          32'd20,
          GT,
          32'd0);

    check(32'd20,
          32'd10,
          LT,
          32'd0);

    //------------------------------------------------------
    // Zero Flag Test
    //------------------------------------------------------

    A = 32'd10;
    B = 32'd10;
    opcode = SUB;

    #10;

    if(zero_flag)
        pass_count++;
    else begin
        fail_count++;
        $display("Zero Flag Test Failed");
    end;

    //------------------------------------------------------
    // Negative Flag Test
    //------------------------------------------------------

    A = 32'd10;
    B = 32'd20;
    opcode = SUB;

    #10;

    if(negative_flag)
        pass_count++;
    else begin
        fail_count++;
        $display("Negative Flag Test Failed");
    end;

        //------------------------------------------------------
    // Random ADD Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = A + B;

        check(A,B,ADD,expected);

    end

    //------------------------------------------------------
    // Random SUB Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = A - B;

        check(A,B,SUB,expected);

    end

    //------------------------------------------------------
    // Random AND Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = A & B;

        check(A,B,AND_,expected);

    end

    //------------------------------------------------------
    // Random OR Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = A | B;

        check(A,B,OR_,expected);

    end

    //------------------------------------------------------
    // Random XOR Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = A ^ B;

        check(A,B,XOR_,expected);

    end

    //------------------------------------------------------
    // Random Shift Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;
        logic [$clog2(WIDTH)-1:0] shamt;

        A = $urandom;
        B = $urandom_range(0,WIDTH-1);

        shamt = B[$clog2(WIDTH)-1:0];

        expected = A << shamt;

        check(A,B,SLL,expected);

    end

    //------------------------------------------------------
    // Random Compare Tests
    //------------------------------------------------------

    repeat (100) begin

        logic [WIDTH-1:0] expected;

        A = $urandom;
        B = $urandom;

        expected = (A == B);

        check(A,B,EQ,expected);

    end

    //------------------------------------------------------
    // Verification Summary
    //------------------------------------------------------

    $display("");

    $display("==========================================");

    $display("        ALU VERIFICATION SUMMARY");

    $display("==========================================");

    $display("Passed Tests : %0d",pass_count);

    $display("Failed Tests : %0d",fail_count);

    $display("==========================================");

    if(fail_count==0)

        $display(" ALL ALU TESTS PASSED ");

    else

        $display(" SOME TESTS FAILED ");

    $display("==========================================");

    $finish;

end

endmodule