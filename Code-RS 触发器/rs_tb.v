`timescale 1ns/1ps
`include "rs.v"

module rs_tb();

  reg     CLOCK_50;

  reg s;
  reg r;
  wire q;
  wire qb;

  integer high = 1'b1; 
  integer low = 1'b0; 
       
  initial @(posedge CLOCK_50) begin
    #10 s <= low; r <= high; 
    #10 s <= low; r <= low; 
    #10 s <= high; r <= low; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= high; 
    #10 s <= low; r <= low; 
    #10 s <= high; r <= low; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= high; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= low; 
    #10 s <= low; r <= low; 
  end
  
  initial begin

    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
       
  rs rs0(
    CLOCK_50, s, r, q, qb
  );
endmodule