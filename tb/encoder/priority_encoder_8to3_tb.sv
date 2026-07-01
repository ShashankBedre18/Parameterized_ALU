`timescale 1ns/1ps

module priority_encoder_8to3_tb;

logic [7:0] in;
logic [2:0] out;
logic valid;

priority_encoder_8to3 dut(

.in(in),
.out(out),
.valid(valid)

);

initial begin

    in = 8'b00000001; #10;
    in = 8'b00000010; #10;
    in = 8'b00000100; #10;

    in = 8'b00010100; #10;   // Highest priority = bit4

    in = 8'b10110000; #10;   // Highest priority = bit7

    in = 8'b00000000; #10;

    $finish;

end

endmodule