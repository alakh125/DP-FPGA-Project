`timescale 1 ns /  100 ps
module tb_fibonacci ();

reg         clk, start;
reg  [31:0] n; 
wire        valid;
wire [31:0] fib;

fibonacci #(
  .in_size(32),
  .out_size(32)
)
f(
  .clk(clk),
  .start(start), 
  .n(n),     
  .valid(valid),
  .fib(fib)
);

always #10 clk = ~clk;

initial begin
  $dumpfile("fib.vcd");
  $dumpvars;
  $display ("Starting simulation.....");
  n = 10;
  start = 0;
  clk = 0;
  #10
  start = 1;
  #500
  $display ("Simulation Complete!");
  $finish;
end

endmodule