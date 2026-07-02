`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU
 * Module      : shift_unit_tb
 * Author      : Shashank Bedre
 * Description : Self-Checking Testbench
 ******************************************************************************/

module shift_unit_tb;

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

shift_unit #(

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
    $display(" Shift Unit Test Started");
    $display("--------------------------------");

    //----------------------------------
    // SLL
    //----------------------------------

    check(32'h00000001,
          32'd4,
          SLL,
          32'h00000010);

    //----------------------------------
    // SRL
    //----------------------------------

    check(32'h00000010,
          32'd4,
          SRL,
          32'h00000001);

    //----------------------------------
    // SRA
    //----------------------------------

    check(32'h80000000,
          32'd1,
          SRA,
          32'hC0000000);

    //----------------------------------
    // ROL
    //----------------------------------

    check(32'h80000001,
          32'd1,
          ROL,
          32'h00000003);

    //----------------------------------
    // ROR
    //----------------------------------

    check(32'h80000001,
          32'd1,
          ROR,
          32'hC0000000);

    //----------------------------------
    // Shift by Zero
    //----------------------------------

    check(32'h12345678,
          32'd0,
          SLL,
          32'h12345678);

    check(32'h12345678,
          32'd0,
          SRL,
          32'h12345678);

    check(32'h12345678,
          32'd0,
          ROL,
          32'h12345678);

    check(32'h12345678,
          32'd0,
          ROR,
          32'h12345678);

    //----------------------------------
    // Random Tests
    //----------------------------------

    repeat(100)

    begin

        A = $urandom;

        B = $urandom % WIDTH;

        opcode = SLL;

        #5;

        if(result != (A << B[$clog2(WIDTH)-1:0]))

        begin

            $display("Random SLL Failed");

            $finish;

        end

        opcode = SRL;

        #5;

        if(result != (A >> B[$clog2(WIDTH)-1:0]))

        begin

            $display("Random SRL Failed");

            $finish;

        end

        opcode = SRA;

        #5;

        if(result != ($signed(A) >>> B[$clog2(WIDTH)-1:0]))

        begin

            $display("Random SRA Failed");

            $finish;

        end

    end

    //----------------------------------

    $display("--------------------------------");
    $display(" ALL SHIFT TESTS PASSED ");
    $display("--------------------------------");

    $finish;

end

endmodule