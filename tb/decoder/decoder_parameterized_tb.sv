`timescale 1ns/1ps

module decoder_parameterized_tb;

parameter N = 3;

logic [N-1:0] in;
logic [(1<<N)-1:0] out;

decoder_parameterized #(
    .N(N)
)dut(
    .in(in),
    .out(out)
);

initial begin

    for(int i=0;i<(1<<N);i++) begin
        in = i;
        #10;
    end

    $finish;

end

endmodule