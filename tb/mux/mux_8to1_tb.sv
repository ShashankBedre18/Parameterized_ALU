`timescale 1ns/1ps

module mux_8to1_tb;

localparam WIDTH = 8;

logic [WIDTH-1:0] in0,in1,in2,in3,in4,in5,in6,in7;
logic [2:0] sel;
logic [WIDTH-1:0] out;

mux_8to1 #(
    .WIDTH(WIDTH)
)dut(
    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .in4(in4),
    .in5(in5),
    .in6(in6),
    .in7(in7),
    .sel(sel),
    .out(out)
);

initial begin

    in0 = 8'hAA;
    in1 = 8'h55;
    in2 = 8'hF0;
    in3 = 8'h0F;
    in4 = 8'h11;
    in5 = 8'h22;
    in6 = 8'h33;
    in7 = 8'h44;

    sel = 3'd0; #10;
    sel = 3'd1; #10;
    sel = 3'd2; #10;
    sel = 3'd3; #10;
    sel = 3'd4; #10;
    sel = 3'd5; #10;
    sel = 3'd6; #10;
    sel = 3'd7; #10;

    $finish;

end

endmodule