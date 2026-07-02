`timescale 1ns/1ps
/******************************************************************************
 * Project     : Parameterized ALU + Register File
 * Module      : register_file
 * Author      : Shashank Bedre
 * Description : Parameterized Multi-Port Register File
 ******************************************************************************/

module register_file #(

    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 32,
    parameter ZERO_REG   = 1

)(
    input  logic clk,
    input  logic rst_n,

    // Write Port
    input  logic we,
    input  logic [$clog2(DEPTH)-1:0] wr_addr,
    input  logic [DATA_WIDTH-1:0] wr_data,

    // Read Port 1
    input  logic [$clog2(DEPTH)-1:0] rd_addr1,
    output logic [DATA_WIDTH-1:0] rd_data1,

    // Read Port 2
    input  logic [$clog2(DEPTH)-1:0] rd_addr2,
    output logic [DATA_WIDTH-1:0] rd_data2

);

localparam ADDR_WIDTH = $clog2(DEPTH);

//------------------------------------------------------------
// Register Memory
//------------------------------------------------------------

logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

integer i;

//------------------------------------------------------------
// Synchronous Write + Reset
//------------------------------------------------------------

always_ff @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin

        for (i = 0; i < DEPTH; i = i + 1)
            mem[i] <= '0;

    end
    else begin

        // Optional constant-zero register
        if (ZERO_REG)
            mem[0] <= '0;

        if (we) begin

            if (ZERO_REG) begin

                if (wr_addr != '0)
                    mem[wr_addr] <= wr_data;

            end
            else begin

                mem[wr_addr] <= wr_data;

            end

        end

    end

end

//------------------------------------------------------------
// Asynchronous Read Port 1
//------------------------------------------------------------

always_comb begin

    if (ZERO_REG && (rd_addr1 == '0))
        rd_data1 = '0;
    else
        rd_data1 = mem[rd_addr1];

end

//------------------------------------------------------------
// Asynchronous Read Port 2
//------------------------------------------------------------

always_comb begin

    if (ZERO_REG && (rd_addr2 == '0))
        rd_data2 = '0;
    else
        rd_data2 = mem[rd_addr2];

end

endmodule