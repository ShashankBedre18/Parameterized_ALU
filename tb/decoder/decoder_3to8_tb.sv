`timescale 1ns/1ps

module decoder_3to8_tb;

logic [2:0] in;
logic [7:0] out;

decoder_3to8 dut(

    .in(in),
    .out(out)

);

initial begin

    for(int i=0;i<8;i++) begin
        in = i;
        #10;
    end

    $display("--------------------------------");
    $display("3-to-8 Decoder Test Completed");
    $display("--------------------------------");

    $finish;

end

endmodule