module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
  assign o = i0 | i1;
endmodule

module xor2 (input wire i0, i1, output wire o);
  assign o = i0 ^ i1;
endmodule

module and3 (input wire i0, i1, i2, output wire o);
   wire t;
   and2 and2_0 (i0, i1, t);
   and2 and2_1 (i2, t, o);
endmodule

module or3 (input wire i0, i1, i2, output wire o);
   wire t;
   or2 or2_0 (i0, i1, t);
   or2 or2_1 (i2, t, o);
endmodule

module xor3 (input wire i0, i1, i2, output wire o);
   wire t;
   xor2 xor2_0 (i0, i1, t);
   xor2 xor2_1 (i2, t, o);
endmodule

module and5(input wire i0, i1, i2, i3, i4, output wire o);
  wire t1;
  and3 a1(i0,i1,i2,t1);
  and3 a2(i3,i4,t1,o);
endmodule

module or5(input wire i0, i1, i2, i3, i4, output wire o);
  wire t1;
  or3 o1(i0,i1,i2,t1);
  or3 o2(i3,i4,t1,o);
endmodule

module mux2 (input wire i0, i1, j, output wire o);
  assign o = (j==0)?i0:i1;
endmodule

module mux4 (input wire [0:3] i, input wire j1, j0, output wire o);
  wire  t0, t1;
  mux2 mux2_0 (i[0], i[1], j0, t0);
  mux2 mux2_1 (i[2], i[3], j0, t1);
  mux2 mux2_2 (t0, t1, j1, o);
endmodule

module mux8 (input wire [0:7] i, input wire j2, j1, j0, output wire o);
  wire  t0, t1;
  mux4 mux4_0 (i[0:3], j1, j0, t0);
  mux4 mux4_1 (i[4:7], j1, j0, t1);
  mux2 mux2_0 (t0, t1, j2, o);
endmodule

module mux16 (input wire [0:15] i, input wire j3, j2, j1, j0, output wire o);
  wire  t0, t1;
  mux8 mux8_0 (i[0:7], j2, j1, j0, t0);
  mux8 mux8_1 (i[8:15], j2, j1, j0, t1);
  mux2 mux2_0 (t0, t1, j3, o);
endmodule

module demux2 (input wire i, j, output wire o0, o1);
  assign o0 = (j==0)?i:1'b0;
  assign o1 = (j==1)?i:1'b0;
endmodule

module demux4 (input wire i, input wire j1, j0, output wire [0:3] o);
  wire  t0, t1;
  demux2 demux2_0 (i, j1, t0, t1);
  demux2 demux2_1 (t0, j0, o[0], o[1]);
  demux2 demux2_2 (t1, j0, o[2], o[3]);
endmodule

module demux8 (input wire i, j2, j1, j0, output wire [0:7] o);
  wire  t0, t1;
  demux2 demux2_0 (i, j2, t0, t1);
  demux4 demux4_0 (t0, j1, j0, o[0:3]);
  demux4 demux4_1 (t1, j1, j0, o[4:7]);
endmodule

module demux16 (input wire i, j3, j2, j1, j0, output wire [0:15] o);
  wire  t0, t1;
  demux2 demux2_0 (i, j3, t0, t1);
  demux8 demux4_0 (t0, j2, j1, j0, o[0:7]);
  demux8 demux4_1 (t1, j2, j1, j0, o[8:15]);
endmodule


module df (input wire clk, in, output wire out);
  reg df_out;
  always@(posedge clk) df_out <= in;
  assign out = df_out;
endmodule

module dfr (input wire clk, reset, in, output wire out);
  wire reset_, df_in;
  invert invert_0 (reset, reset_);
  and2 and2_0 (in, reset_, df_in);
  df df_0 (clk, df_in, out);
endmodule

module dfr16 (input wire clk,reset, input wire [15:0] in, output wire [15:0] out);
  dfr d0(clk,reset, in[0], out[0]);
  dfr d1(clk,reset, in[1], out[1]);
  dfr d2(clk,reset, in[2], out[2]);
  dfr d3(clk,reset, in[3], out[3]);
  dfr d4(clk,reset, in[4], out[4]);
  dfr d5(clk,reset, in[5], out[5]);
  dfr d6(clk,reset, in[6], out[6]);
  dfr d7(clk,reset, in[7], out[7]);
  dfr d8(clk,reset, in[8], out[8]);
  dfr d9(clk,reset, in[9], out[9]);
  dfr d10(clk,reset, in[10], out[10]);
  dfr d11(clk,reset, in[11], out[11]);
  dfr d12(clk,reset, in[12], out[12]);
  dfr d13(clk,reset, in[13], out[13]);
  dfr d14(clk,reset, in[14], out[14]);
  dfr d15(clk,reset, in[15], out[15]);
endmodule

module dfrl (input wire clk, reset, load, in, output wire out);
  wire _in;
  mux2 mux2_0(out, in, load, _in);
  dfr dfr_1(clk, reset, _in, out);
endmodule

module ha(input wire i0, i1, output wire sum, cout);
  xor2 _i0(i0, i1, sum);
  and2 _i1(i0, i1, cout);
endmodule

module fa (input wire i0, i1, cin, output wire sum, cout);
   wire t0, t1, t2;
   xor3 _i0 (i0, i1, cin, sum);
   and2 _i1 (i0, i1, t0);
   and2 _i2 (i1, cin, t1);
   and2 _i3 (cin, i0, t2);
   or3 _i4 (t0, t1, t2, cout);
endmodule

module addsub (input wire addsub, i0, i1, cin, output wire sumdiff, cout);
  wire t;
  fa _i0 (i0, t, cin, sumdiff, cout);
  xor2 _i1 (i1, addsub, t);
endmodule