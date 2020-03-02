// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
// Date        : Mon Mar  2 19:45:39 2020
// Host        : DESKTOP-4OG4E3G running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/mitch/Documents/School/ProjectRetroGame_Software/Basys3
//               Software/RetroSkiGame/RetroSkiGame.srcs/sources_1/ip/Ernie/Ernie_stub.v}
// Design      : Ernie
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module Ernie(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[12:0],douta[7:0]" */;
  input clka;
  input [12:0]addra;
  output [7:0]douta;
endmodule
