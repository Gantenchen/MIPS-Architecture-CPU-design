`define     DELAY_MS    10000
`include  ".\\head.v"
module testbench();
reg [5:0] op ,fun ;
reg clk ;

wire RegDst , AluSrc , MemtoReg , RegWrite , MemWrite , IBeq ;
wire [1:0]AluCtr ;

ctr  Control(clk , op ,fun , RegDst , AluSrc , MemtoReg , RegWrite , MemWrite , IBeq , AluCtr);
initial begin
    clk = 0 ;
    op = 6'b 00_0000;
    fun = 6'b 10_0001;
    
    T1(6'b00_0000 , 6'b10_0011);//subu
    T1(6'b00_1101 , 6'b00_0000);//ori
    T1(6'b10_0011 , 6'b00_0000);//lw
    T1(6'b10_1011 , 6'b00_0000);//sw
    T1(6'b00_0100 , 6'b00_0000);//beq
    T1(6'b00_1111 , 6'b00_0000);//lui
    #(1.2*`DELAY_MS) ;
    $stop;
end
always
#(`CYCLE/2) clk =~clk ;
task T1 ;
  input [5:0] Op ,Fun ;
  begin
    @ (posedge clk)
    op = Op;
    fun = Fun ;
  end
endtask
endmodule