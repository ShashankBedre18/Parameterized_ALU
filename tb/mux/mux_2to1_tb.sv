`timescale 1ns/1ps
/***************************************************************************
 * Project      : Parameterized ALU + Register File + Arithmetic Library
 * Module       : mux_2to1_tb
 * Author       : Shashank Bedre
 * Language     : SystemVerilog
 *
 * Description:
 * Self-checking testbench for Parameterized 2:1 Multiplexer.
 ***************************************************************************/

module mux_2to1_tb;

    //--------------------------------------------------------
    // Parameters
    //--------------------------------------------------------
    localparam WIDTH = 8;

    //--------------------------------------------------------
    // Testbench Signals
    //--------------------------------------------------------
    logic [WIDTH-1:0] in0;
    logic [WIDTH-1:0] in1;
    logic             sel;
    logic [WIDTH-1:0] out;

    //--------------------------------------------------------
    // DUT Instantiation
    //--------------------------------------------------------
    mux_2to1 #(
        .WIDTH(WIDTH)
    ) dut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    //--------------------------------------------------------
    // Test Sequence
    //--------------------------------------------------------
    initial begin

        $display("=======================================");
        $display(" Starting 2:1 MUX Testbench");
        $display("=======================================");

        // Test Case 1
        in0 = 8'hAA;
        in1 = 8'h55;
        sel = 0;
        #10;

        if (out == in0)
            $display("TEST1 PASS");
        else
            $error("TEST1 FAIL");

        // Test Case 2
        sel = 1;
        #10;

        if (out == in1)
            $display("TEST2 PASS");
        else
            $error("TEST2 FAIL");

        // Test Case 3
        in0 = 8'h00;
        in1 = 8'hFF;
        sel = 0;
        #10;

        if (out == in0)
            $display("TEST3 PASS");
        else
            $error("TEST3 FAIL");

        // Test Case 4
        sel = 1;
        #10;

        if (out == in1)
            $display("TEST4 PASS");
        else
            $error("TEST4 FAIL");

        $display("=======================================");
        $display(" Simulation Completed");
        $display("=======================================");

        $finish;

    end

endmodule