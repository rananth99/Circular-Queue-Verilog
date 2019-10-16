`timescale 1 ns / 100 ps
`define TESTVECS 22

module tb;
  reg clk, reset;
  reg write, read; reg [15:0] d_in;
  reg [17:0] test_vecs [0:(`TESTVECS-1)];
  wire full,empty;
  wire [15:0] d_out;
  integer i;
  initial begin $dumpfile("tb_fifo.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
    //Check empty condition
    test_vecs[0][17] = 1'b1; test_vecs[0][16] = 1'b0;  test_vecs[0][15:0] = 16'd100; 
    test_vecs[1][17] = 1'b0; test_vecs[1][16] = 1'b1;  test_vecs[1][15:0] = 16'd101; 
    test_vecs[2][17] = 1'b0; test_vecs[2][16] = 1'b1;  test_vecs[2][15:0] = 16'd102; 
    test_vecs[3][17] = 1'b1; test_vecs[3][16] = 1'b0;  test_vecs[3][15:0] = 16'd103; 
    test_vecs[4][17] = 1'b1; test_vecs[4][16] = 1'b0;  test_vecs[4][15:0] = 16'd104; 
    //Check simultaneous read and write
    test_vecs[5][17] = 1'b1; test_vecs[5][16] = 1'b1;  test_vecs[5][15:0] = 16'd105; 
    //Check full condition
    test_vecs[6][17] = 1'b1; test_vecs[6][16] = 1'b0;  test_vecs[6][15:0] = 16'd106; 
    test_vecs[7][17] = 1'b1; test_vecs[7][16] = 1'b0;  test_vecs[7][15:0] = 16'd107; 
    test_vecs[8][17] = 1'b1; test_vecs[8][16] = 1'b0;  test_vecs[8][15:0] = 16'd108; 
    test_vecs[9][17] = 1'b1; test_vecs[9][16] = 1'b0;  test_vecs[9][15:0] = 16'd109; 
    test_vecs[10][17] = 1'b1; test_vecs[10][16] = 1'b0;  test_vecs[10][15:0] = 16'd110; 
    test_vecs[11][17] = 1'b1; test_vecs[11][16] = 1'b0;  test_vecs[11][15:0] = 16'd111; 
    test_vecs[12][17] = 1'b1; test_vecs[12][16] = 1'b0;  test_vecs[12][15:0] = 16'd112; 
    test_vecs[13][17] = 1'b1; test_vecs[13][16] = 1'b0;  test_vecs[13][15:0] = 16'd113; 
    test_vecs[14][17] = 1'b1; test_vecs[14][16] = 1'b0;  test_vecs[14][15:0] = 16'd114; 
    test_vecs[15][17] = 1'b1; test_vecs[15][16] = 1'b0;  test_vecs[15][15:0] = 16'd115; 
    test_vecs[16][17] = 1'b1; test_vecs[16][16] = 1'b0;  test_vecs[16][15:0] = 16'd116; 
    test_vecs[17][17] = 1'b1; test_vecs[17][16] = 1'b0;  test_vecs[17][15:0] = 16'd117;
    test_vecs[18][17] = 1'b1; test_vecs[18][16] = 1'b0;  test_vecs[18][15:0] = 16'd118; 
    test_vecs[19][17] = 1'b1; test_vecs[19][16] = 1'b0;  test_vecs[19][15:0] = 16'd119; 
    test_vecs[20][17] = 1'b1; test_vecs[20][16] = 1'b0;  test_vecs[20][15:0] = 16'd120;
    test_vecs[21][17] = 1'b1; test_vecs[21][16] = 1'b0;  test_vecs[21][15:0] = 16'd121;
  end
  initial write = 0;
  initial read = 0;
  initial d_in = 0;
  fifo f_0 (clk, reset,write,read, d_in, full, empty, d_out);
  initial begin
    #2.5 for(i=0;i<`TESTVECS;i=i+1)
      begin #10 {write, read , d_in}=test_vecs[i]; end
    #10 $finish;
  end
endmodule