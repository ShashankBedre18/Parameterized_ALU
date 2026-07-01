`timescale 1ns/1ps

module mux_16to1_tb;

localparam WIDTH = 8;

logic [WIDTH-1:0] in0,in1,in2,in3,in4,in5,in6,in7;
logic [WIDTH-1:0] in8,in9,in10,in11,in12,in13,in14,in15;
logic [3:0] sel;
logic [WIDTH-1:0] out;

mux_16to1 #(
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
    .in8(in8),
    .in9(in9),
    .in10(in10),
    .in11(in11),
    .in12(in12),
    .in13(in13),
    .in14(in14),
    .in15(in15),
    .sel(sel),
    .out(out)
);

initial begin

    in0  = 8'h00;
    in1  = 8'h11;
    in2  = 8'h22;
    in3  = 8'h33;
    in4  = 8'h44;
    in5  = 8'h55;
    in6  = 8'h66;
    in7  = 8'h77;
    in8  = 8'h88;
    in9  = 8'h99;
    in10 = 8'hAA;
    in11 = 8'hBB;
    in12 = 8'hCC;
    in13 = 8'hDD;
    in14 = 8'hEE;
    in15 = 8'hFF;

    for (int i = 0; i < 16; i++) begin
        sel = i;
        #10;
    end

    $finish;

end

endmodule