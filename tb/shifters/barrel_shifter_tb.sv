`timescale 1ns/1ps

module barrel_shifter_tb;

parameter WIDTH = 32;

logic [WIDTH-1:0] data_in;
logic [$clog2(WIDTH)-1:0] shift_amt;
logic [2:0] shift_op;

logic [WIDTH-1:0] data_out;
logic [WIDTH-1:0] expected;

barrel_shifter #(
    .WIDTH(WIDTH)
) dut (

    .data_in(data_in),
    .shift_amt(shift_amt),
    .shift_op(shift_op),
    .data_out(data_out)

);

initial begin

    repeat(100) begin

        data_in   = $urandom;
        shift_amt = $urandom_range(0, WIDTH-1);
        shift_op  = $urandom_range(0,4);

        #10;

        case(shift_op)

            3'b000: expected = data_in << shift_amt;

            3'b001: expected = data_in >> shift_amt;

            3'b010: expected = $signed(data_in) >>> shift_amt;

            3'b011: expected =
                    (data_in << shift_amt) |
                    (data_in >> (WIDTH-shift_amt));

            3'b100: expected =
                    (data_in >> shift_amt) |
                    (data_in << (WIDTH-shift_amt));

            default:
                    expected = data_in;

        endcase

        if(data_out !== expected)

            $error("FAILED");

    end

    $display("--------------------------------");
    $display("BARREL SHIFTER PASSED");
    $display("--------------------------------");

    $finish;

end

endmodule