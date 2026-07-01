`timescale 1ns/1ps

module encoder_8to3_tb;

logic [7:0] in;
logic [2:0] out;

encoder_8to3 dut(

    .in(in),
    .out(out)

);

initial begin

    in=8'b00000001; #10; if(out!=3'b000) $error("Fail");
    in=8'b00000010; #10; if(out!=3'b001) $error("Fail");
    in=8'b00000100; #10; if(out!=3'b010) $error("Fail");
    in=8'b00001000; #10; if(out!=3'b011) $error("Fail");
    in=8'b00010000; #10; if(out!=3'b100) $error("Fail");
    in=8'b00100000; #10; if(out!=3'b101) $error("Fail");
    in=8'b01000000; #10; if(out!=3'b110) $error("Fail");
    in=8'b10000000; #10; if(out!=3'b111) $error("Fail");

    $display("--------------------------------");
    $display(" ALL TESTS PASSED ");
    $display("--------------------------------");

    $finish;

end

endmodule