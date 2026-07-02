`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File
 * Module      : register_file_tb
 * Author      : Shashank Bedre
 * Description : Self-checking Testbench for Parameterized Register File
 ******************************************************************************/

module register_file_tb;

parameter DATA_WIDTH = 32;
parameter DEPTH      = 32;
parameter ZERO_REG   = 1;

localparam ADDR_WIDTH = $clog2(DEPTH);

//------------------------------------------------------------
// DUT Signals
//------------------------------------------------------------

logic clk;
logic rst_n;

logic we;

logic [ADDR_WIDTH-1:0] wr_addr;
logic [DATA_WIDTH-1:0] wr_data;

logic [ADDR_WIDTH-1:0] rd_addr1;
logic [ADDR_WIDTH-1:0] rd_addr2;

logic [DATA_WIDTH-1:0] rd_data1;
logic [DATA_WIDTH-1:0] rd_data2;

//------------------------------------------------------------
// Golden Model
//------------------------------------------------------------

logic [DATA_WIDTH-1:0] golden_mem [0:DEPTH-1];

//------------------------------------------------------------
// DUT
//------------------------------------------------------------

register_file #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ZERO_REG(ZERO_REG)
) dut (

    .clk(clk),
    .rst_n(rst_n),

    .we(we),

    .wr_addr(wr_addr),
    .wr_data(wr_data),

    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),

    .rd_data1(rd_data1),
    .rd_data2(rd_data2)

);

//------------------------------------------------------------
// Clock Generation
//------------------------------------------------------------

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//------------------------------------------------------------
// Test
//------------------------------------------------------------

integer i;

initial begin

    $display("=========================================");
    $display("      REGISTER FILE TEST STARTED");
    $display("=========================================");

    //--------------------------------------------------------
    // Initialize
    //--------------------------------------------------------

    rst_n    = 0;
    we       = 0;
    wr_addr  = 0;
    wr_data  = 0;
    rd_addr1 = 0;
    rd_addr2 = 0;

    for(i=0;i<DEPTH;i=i+1)
        golden_mem[i] = '0;

    //--------------------------------------------------------
    // Reset
    //--------------------------------------------------------

    #20;
    rst_n = 1;

    //--------------------------------------------------------
    // Random Write / Read Test
    //--------------------------------------------------------

    repeat(200) begin

        @(posedge clk);

        we      = $urandom_range(0,1);
        wr_addr = $urandom_range(0,DEPTH-1);
        wr_data = $urandom;

        if(we) begin

            if(ZERO_REG) begin

                if(wr_addr != 0)
                    golden_mem[wr_addr] = wr_data;

                golden_mem[0] = '0;

            end
            else begin

                golden_mem[wr_addr] = wr_data;

            end

        end

        rd_addr1 = $urandom_range(0,DEPTH-1);
        rd_addr2 = $urandom_range(0,DEPTH-1);

        #1;

        if(rd_data1 !== golden_mem[rd_addr1]) begin

            $display("ERROR Read Port1");
            $display("Addr=%0d Expected=%h Got=%h",
                     rd_addr1,
                     golden_mem[rd_addr1],
                     rd_data1);

            $finish;

        end

        if(rd_data2 !== golden_mem[rd_addr2]) begin

            $display("ERROR Read Port2");
            $display("Addr=%0d Expected=%h Got=%h",
                     rd_addr2,
                     golden_mem[rd_addr2],
                     rd_data2);

            $finish;

        end

    end

    //--------------------------------------------------------
    // Check ZERO Register
    //--------------------------------------------------------

    if(ZERO_REG) begin

        rd_addr1 = 0;
        #1;

        if(rd_data1 != 0) begin

            $display("ERROR : Register0 is not ZERO");
            $finish;

        end

    end

    //--------------------------------------------------------
    // PASS
    //--------------------------------------------------------

    $display("=========================================");
    $display(" ALL REGISTER FILE TESTS PASSED ");
    $display("=========================================");

    $finish;

end

endmodule