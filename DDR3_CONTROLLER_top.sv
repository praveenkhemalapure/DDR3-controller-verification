`timescale 1ps/1ps

`include "lcdif.sv"
`include "sync.sv"
`include "DDR3_CONTROLLER_pkg.sv"
`include "ddr3.v"

`include "DDR3_top.sv"
//`include "uvm_macros.svh"

`include "fifo_async.sv"

`include "initialization.sv"
`include "ctrl_operation.sv"

module top();

import uvm_pkg::*;
import DDR3_CONTROLLER_pkg::*;


AHBIF Q();
DDR3_SDRAM dd3_sdram1();
DDR3_SDRAM dd3_sdram2();
DDR3_SDRAM dd3_sdram3();

// initial begin
// Q.HCLK=1;
// forever #5 Q.HCLK = ~ Q.HCLK;
// 
// end

//   logic [63:0] tck_ddr= 2500;
  logic [63:0] tck_ahb= 10000;
// 
// assign dd3_sdram1.ck_n=~dd3_sdram1.ck;
// 
// 
//   initial begin
//      forever #(tck_ddr/2) dd3_sdram1.ck <=~dd3_sdram1.ck;
//   end
//   initial begin
//     Q.HCLK = 1;
//      forever #(tck_ahb/2) Q.HCLK <=~Q.HCLK;
//   end
// 
//   
// assign dd3_sdram2.ck_n=~dd3_sdram2.ck;
// 
// 
//   initial begin
//      forever #(tck_ddr/2) dd3_sdram2.ck <=~dd3_sdram2.ck;
//   end
// 
// 
//  initial begin
//     dd3_sdram1.ck   <=0;
//     dd3_sdram2.ck   <=0;
//     Q.HCLK <=0;
//   end
//   


 
  initial begin
     $dumpvars();    
     $dumpfile("ddr3.vpd");
      #(1000000*tck_ahb) $finish;
  end



// lcd l(Q.AHBCLKS, Q.AHBM, Q.AHBS, R.F0, S.F0,cpal.R0,crsr.R0,lcdout.O0);
// 
// mem128x32 palmem(Q.HCLK,cpal.write,cpal.waddr,cpal.wdata,
//     cpal.raddr,cpal.rdata,cpal.raddr1,cpal.rdata1);
//     
// mem256x32 cursmem(Q.HCLK,crsr.write,crsr.waddr,crsr.wdata,
//     crsr.raddr,crsr.rdata,crsr.raddr1,crsr.rdata1);
// 
// mem32x32 fifoMem0(Q.HCLK,R.f0_waddr,R.f0_wdata,R.f0_write,
//     R.f0_raddr,R.f0_rdata);
// 
// mem32x32 fifoMem1(Q.HCLK,S.f0_waddr,S.f0_wdata,S.f0_write,
//     S.f0_raddr,S.f0_rdata);

DDR3_top control(Q.HCLK,Q.HRESET,Q.AHBMS,dd3_sdram1,dd3_sdram2,dd3_sdram3);


initial
  begin
    Q.mHGRANT=0;
  end

initial
  begin
    uvm_config_db #(virtual  AHBIF)::set(null, "*", 
      "Q"  , Q);
    uvm_config_db #(virtual  DDR3_SDRAM)::set(null, "*", 
      "dd3_sdram1"  , dd3_sdram1);
      uvm_config_db #(virtual  DDR3_SDRAM)::set(null, "*", 
      "dd3_sdram2"  , dd3_sdram2);
      uvm_config_db #(virtual  DDR3_SDRAM)::set(null, "*", 
      "dd3_sdram3"  , dd3_sdram3);
    run_test("DDR3_CONTROLLER_base_test");
    #100;
    $finish;
  end



endmodule : top
