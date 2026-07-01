`timescale 1ns/1ps

module decoder_2to4_tb;

logic [1:0] in;
logic [3:0] out;

decoder_2to4 dut(

.in(in),
.out(out)

);

initial begin

    in=2'b00; #10;
    in=2'b01; #10;
    in=2'b10; #10;
    in=2'b11; #10;

    $finish;

end

endmodule