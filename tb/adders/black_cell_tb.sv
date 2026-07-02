`timescale 1ns/1ps

module black_cell_tb;

logic Gi,Pi,Gj,Pj;

logic Gout,Pout;

logic expected_G;
logic expected_P;

black_cell dut(

.Gi(Gi),
.Pi(Pi),

.Gj(Gj),
.Pj(Pj),

.Gout(Gout),
.Pout(Pout)

);

initial begin

$display("--------------------------------");
$display("Black Cell Testbench");
$display("--------------------------------");

repeat(20) begin

    Gi=$urandom_range(0,1);
    Pi=$urandom_range(0,1);

    Gj=$urandom_range(0,1);
    Pj=$urandom_range(0,1);

    #10;

    expected_G = Gi | (Pi & Gj);

    expected_P = Pi & Pj;

    if(Gout!=expected_G || Pout!=expected_P)

        $error("FAILED");

end

$display("--------------------------------");
$display("BLACK CELL PASSED");
$display("--------------------------------");

$finish;

end

endmodule