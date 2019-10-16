module bin_counter(input wire clk, reset, in, output wire[3:0] out);
    wire[3:0] t0,t1;
    
    dfrl d0(clk,reset,in,t0[0],out[0]);
    dfrl d1(clk,reset,in,t0[1],out[1]);
    dfrl d2(clk,reset,in,t0[2],out[2]);
    dfrl d3(clk,reset,in,t0[3],out[3]);

    ha h0(out[0],in,t0[0],t1[0]);
    ha h1(out[1],t1[0],t0[1],t1[1]);
    ha h2(out[2],t1[1],t0[2],t1[2]);
    ha h3(out[3],t1[2],t0[3],t1[3]);

endmodule

module reg_file_slice (input wire clk, reset, wr, rd, input wire [3:0] rd_addr, wr_addr, input wire d_in, output wire d_out);
	wire [0:15] t1,t2;
	wire t3;

	demux16 dm1(wr, wr_addr[3], wr_addr[2], wr_addr[1], wr_addr[0], t1);

	dfrl d0 (clk,reset,t1[0] ,d_in,t2[0]);
	dfrl d1 (clk,reset,t1[1] ,d_in,t2[1]);
	dfrl d2 (clk,reset,t1[2] ,d_in,t2[2]);
	dfrl d3 (clk,reset,t1[3] ,d_in,t2[3]);
	dfrl d4 (clk,reset,t1[4] ,d_in,t2[4]);
	dfrl d5 (clk,reset,t1[5] ,d_in,t2[5]);
	dfrl d6 (clk,reset,t1[6] ,d_in,t2[6]);
	dfrl d7 (clk,reset,t1[7] ,d_in,t2[7]);
	dfrl d8 (clk,reset,t1[8] ,d_in,t2[8]);
	dfrl d9 (clk,reset,t1[9] ,d_in,t2[9]);
	dfrl d10(clk,reset,t1[10],d_in,t2[10]);
	dfrl d11(clk,reset,t1[11],d_in,t2[11]);
	dfrl d12(clk,reset,t1[12],d_in,t2[12]);
	dfrl d13(clk,reset,t1[13],d_in,t2[13]);
	dfrl d14(clk,reset,t1[14],d_in,t2[14]);
    dfrl d15(clk,reset,t1[15],d_in,t2[15]);

	mux16 m1(t2, rd_addr[3], rd_addr[2], rd_addr[1], rd_addr[0], t3);
	and2 a1(t3, rd, d_out);

endmodule

module full_empty(input wire[3:0] front,rear, output wire full, empty);
	wire [3:0] t,out;
	wire t1,t2;
	
	addsub as1(1, front[0], rear[0], 1, out[0], t[0]);
	addsub as2(1, front[1], rear[1], t[0], out[1], t[1]);
	addsub as3(1, front[2], rear[2], t[1], out[2], t[2]);
	addsub as4(1, front[3], rear[3], t[2], out[3], t[3]);

	invert i1(t[3],t1);
	and5 a1(out[0],out[1],out[2],out[3],t1,full);
	or5 o1(out[0],out[1],out[2],out[3],t1,t2);
	invert i2(t2,empty);

endmodule

module memory(input wire clk, reset, wr, rd, input wire[3:0] wr_addr, rd_addr, input wire[15:0] d_in, output wire[15:0] d_out);
	
	reg_file_slice r0 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[0], d_out[0]);
	reg_file_slice r1 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[1], d_out[1]);
	reg_file_slice r2 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[2], d_out[2]);
	reg_file_slice r3 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[3], d_out[3]);
	reg_file_slice r4 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[4], d_out[4]);
	reg_file_slice r5 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[5], d_out[5]);
	reg_file_slice r6 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[6], d_out[6]);
	reg_file_slice r7 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[7], d_out[7]);
	reg_file_slice r8 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[8], d_out[8]);
	reg_file_slice r9 (clk,reset,wr,rd,rd_addr,wr_addr,d_in[9], d_out[9]);
	reg_file_slice r10(clk,reset,wr,rd,rd_addr,wr_addr,d_in[10],d_out[10]);
	reg_file_slice r11(clk,reset,wr,rd,rd_addr,wr_addr,d_in[11],d_out[11]);
	reg_file_slice r12(clk,reset,wr,rd,rd_addr,wr_addr,d_in[12],d_out[12]);
	reg_file_slice r13(clk,reset,wr,rd,rd_addr,wr_addr,d_in[13],d_out[13]);
	reg_file_slice r14(clk,reset,wr,rd,rd_addr,wr_addr,d_in[14],d_out[14]);
	reg_file_slice r15(clk,reset,wr,rd,rd_addr,wr_addr,d_in[15],d_out[15]);

endmodule

module fifo(input wire clk,reset,wr,rd, input wire[15:0] d_in, output wire full,empty, output wire[15:0] d_out);
	wire[3:0] front,rear;
	wire[15:0] t;
	wire front_inc,rear_inc,full_,empty_;

	full_empty f0(front,rear,full,empty);
	invert i0(full,full_);
	invert i1(empty,empty_);

	and2 a1(wr,full_,front_inc);
	bin_counter bc0(clk,reset,front_inc,front);
	
	and2 a2(rd,empty_,rear_inc);
	bin_counter bc1(clk,reset,rear_inc,rear);
	
	memory m0(clk, reset, front_inc, rear_inc, front, rear, d_in, t);
	dfr16 d0(clk, reset, t, d_out);

endmodule