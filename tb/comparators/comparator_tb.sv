`timescale 1ns/1ps

module comparator_tb;

parameter WIDTH = 32;

logic [WIDTH-1:0] A;
logic [WIDTH-1:0] B;

logic eq;
logic neq;
logic gt;
logic lt;
logic gte;
logic lte;

comparator #(
    .WIDTH(WIDTH)
)dut(

    .A(A),
    .B(B),

    .eq(eq),
    .neq(neq),
    .gt(gt),
    .lt(lt),
    .gte(gte),
    .lte(lte)

);

initial begin

repeat(100) begin

    A = $urandom;
    B = $urandom;

    #10;

    if(eq  !== (A==B))  $error("EQ FAILED");
    if(neq !== (A!=B))  $error("NEQ FAILED");
    if(gt  !== (A>B))   $error("GT FAILED");
    if(lt  !== (A<B))   $error("LT FAILED");
    if(gte !== (A>=B))  $error("GTE FAILED");
    if(lte !== (A<=B))  $error("LTE FAILED");

end

$display("--------------------------------------");
$display("COMPARATOR PASSED");
$display("--------------------------------------");

$finish;

end

endmodule