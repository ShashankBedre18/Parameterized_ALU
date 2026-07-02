`timescale 1ns/1ps

module gray_cell_tb;

logic Gi;
logic Pi;
logic Gj;

logic Gout;

logic expected_G;

gray_cell dut(

    .Gi(Gi),
    .Pi(Pi),
    .Gj(Gj),
    .Gout(Gout)

);

initial begin

    $display("--------------------------------");
    $display("Gray Cell Testbench");
    $display("--------------------------------");

    repeat(20) begin

        Gi = $urandom_range(0,1);
        Pi = $urandom_range(0,1);
        Gj = $urandom_range(0,1);

        #10;

        expected_G = Gi | (Pi & Gj);

        if(Gout !== expected_G)
            $error("FAILED : Gi=%0b Pi=%0b Gj=%0b", Gi, Pi, Gj);

    end

    $display("--------------------------------");
    $display("GRAY CELL PASSED");
    $display("--------------------------------");

    $finish;

end

endmodule