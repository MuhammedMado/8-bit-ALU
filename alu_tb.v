`timescale 1ns/1ps

module alu_tb;

// Inputs
reg [7:0] A;
reg [7:0] B;
reg [2:0] op;
reg cin;

// Outputs
wire [7:0] out;
wire cout;
wire c_flag;
wire zero;

// Instantiate the design under test (DUT)
alu dut(.A(A), .B(B), .op(op), .cin(cin), .out(out), .cout(cout), .c_flag(c_flag), .zero(zero));

// Initialize the inputs and simulate different operations
initial 
  begin
  A = 8'd95; // Set A to 95 (decimal)
  B = 8'd14; // Set B to 14 (decimal)
  op = 3'b000; // Set op to 000 (decimal 0)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b001; // Set op to 001 (decimal 1)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b010; // Set op to 010 (decimal 2)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b011; // Set op to 011 (decimal 3)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b100; // Set op to 100 (decimal 4)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b101; // Set op to 101 (decimal 5)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b110; // Set op to 110 (decimal 6)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units

  op = 3'b111; // Set op to 111 (decimal 7)
  cin = op[0]; // Set cin to the least significant bit of op
  #10; // Wait for 10 time units
  
end

// Initialize VCD file and end simulation after 80 time units

initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);
    #80 $finish;
end
endmodule

