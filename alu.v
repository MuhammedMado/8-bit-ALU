module fa_1bit (
    input a, // input a
    input b, // input b
    input cin, // input carry-in

    output s, // output sum
    output cout // output carry-out
);
  assign s = (a ^ b) ^ cin; // calculate sum
  assign cout = (a & b) | (a & cin) | (b & cin); // calculate carry-out
  
endmodule


module adder_subtractor_8bit #(parameter n=8)(
    input [n-1:0] A , B , // 8-bit inputs A and B
    input cin, // input carry-in
    output [n-1:0] S, // 8-bit output sum
    output cout // output carry-out
);
wire [n:0] c ; // declare wire for the carry bits
wire [n-1:0] xored_B; // declare wire for xored B bits
assign c[0]= cin  ; // set initial carry-in
assign cout = c[n] ; // set carry-out to the last bit of the carry wire

generate
genvar k ; // generate loop variable
for( k = 0 ; k < n ; k = k + 1 ) 
  begin 
    assign xored_B[k]= B[k] ^ c[0] ; // calculate xored B bits
  end

for( k = 0 ; k < n ; k = k + 1 ) 
  begin 
fa_1bit fa( // instantiate full adder module
    .a(A[k]), // input a of full adder
    .b(xored_B[k]), // input b of full adder
    .cin(c[k]), // input carry-in of full adder
    .s(S[k]), // output sum of full adder
    .cout(c[k+1]) // output carry-out of full adder
);
  end
 endgenerate
endmodule


module alu(
  input wire [7:0] A, // 8-bit input A
  input wire [7:0] B, // 8-bit input B
  input wire [2:0] op, // 3-bit input op
  input wire cin, // input carry-in
  
  output reg [7:0] out, // 8-bit output
  output wire cout, // 1-bit output carry-out
  output reg c_flag, // 1-bit output comparison flag
  output reg zero // 1-bit output zero flag
);

 wire [7:0] S; // declare wire for the sum
 assign cin = op[0]; // set carry-in to the least significant bit of op
  adder_subtractor_8bit Adder(.A(A), .B(B), .cin(cin), .S(S), .cout(cout)); // instantiate adder/subtractor module
 
always @ (*) begin // combinational logic
  case (op)
    3'b000: out <= S; // output A + B
    3'b001: out <= S; // output A - B
    3'b010: out <= A & B; // output A AND B
    3'b011: out <= A | B; // output A OR B
    3'b100: out <= A ^ B; // output A XOR B
    3'b101: out <= (A > B) ? 1'b1 : 1'b0; // output 1 if A > B, otherwise 0
    3'b110: out <= A << 1; // output shift left A 1-bit
    3'b111: out <= B << 1; // output shift left B 1-bit
    default: out <= 8'b0; //Default case
  endcase
  zero = (out == 8'b0); //zero flag
  c_flag = (A > B) ? 1'b1 : 1'b0; // c flag
end
endmodule