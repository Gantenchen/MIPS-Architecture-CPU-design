module ALU( A , B , AluCtr , C , zero);
input [31:0] A , B ;
input [1:0] AluCtr ;
output [31:0] C ;
output zero ;

reg [31:0] C ;

always @ (*)
case (AluCtr)
  2'b00 : C = A + B ;
  2'b01 :  C = A + ~B + 1 ;
  2'b10 : C = A | B ;
  2'b11 : C = {B[15:0],16'b0};
endcase

assign zero = ( C[31:0] | 32'b0 ) ? 0 : 1 ;

endmodule