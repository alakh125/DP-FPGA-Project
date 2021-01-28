module fibonacci #(
    parameter in_size  = 32,
    parameter out_size = 32
)
(
    input                 clk,
    input                 start, //synchronous negedge reset
    input  [in_size-1 :0] n,     //assumption n >= 1
    output                valid, //goes high when fib = F(n)
    output [out_size-1:0] fib    //outputs F(n), assuming F(n) can be contained within out_size bits
);
//n indicates the n-th Fibonacci F(n) number desired to be calculated.

reg [in_size-1 :0] n_count;
reg [out_size-1:0] f0;
reg [out_size-1:0] f1;
reg [out_size-1:0] fn;

//Output assignments
assign fib   = fn;
assign valid = (n_count==n);

//Negedge FF for f0
always @(negedge clk) begin
  if(~start) begin
    f0 <= 0; //F_0 begins at 0
  end else if(n_count == n) begin //prevents overflowing
    f0 <= f0;
  end else begin
    f0 <= f1;
  end
end

//Negedge FF for f1
always @(negedge clk) begin
  if(~start) begin
    f1 <= 1; //F_1 begins at 1
  end else if(n_count == n) begin //prevents overflowing
    f1 <= f1;
  end else begin
    f1 <= fn;
  end
end

//Posedge FF for fN
always @(posedge clk) begin
  if(~start) begin
    fn <= 1;
  end else if(n_count == n) begin //prevents overflowing
    fn <= fn;
  end else begin
    fn <= f0 + f1; //Fibonacci "next number" calculation 
  end   
end

//Posedge FF for n_count
always @(posedge clk, negedge start) begin
  if(~start) begin
    n_count <= 1; //Previously assumed n >= 1
  end else if(n_count==n) begin //prevents overflowing
    n_count <= n_count;
  end else begin
    n_count <= n_count + 1;
  end 
end

endmodule