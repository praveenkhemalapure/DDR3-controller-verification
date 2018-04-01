// This is a common interface module for the lcd design problem
//

interface AHBIF;
    logic mHBUSREQ,mHGRANT,HREADY,mHREADY;
    logic [1:0] HRESP,mHRESP;
    logic HRESET;
    logic HCLK;
    logic [31:0] HRDATA,mHRDATA;
    logic [31:0] HWDATA,mHWDATA;
    logic HLOCK;        // Not used
    logic [1:0] HTRANS,mHTRANS;
    logic [31:0] HADDR,mHADDR;
    logic HWRITE,mHWRITE;
    logic [2:0] HSIZE,mHSIZE;
    logic [2:0] HBURST,mHBURST;
    logic [3:0] HPROT;  // Not used
    logic HSEL;         // slave select
    logic [3:0] HMASTER; // Not used
    logic HMASTLOCK;    // not used


    
    clocking cb @(posedge(HCLK));
       
    endclocking : cb

    modport AHBM( input mHGRANT, output mHBUSREQ, 
        input mHREADY,input mHRESP,
        input mHRDATA,output mHTRANS, output mHADDR,
        output mHWRITE, output mHSIZE, output mHBURST);
    
    modport AHBS( input HSEL, input HADDR,
        input HWRITE, input HTRANS,
        input HSIZE, input HBURST, input HWDATA, 
        output HREADY,
        output HRESP, output HRDATA);
        
        
    modport AHBCLKS( input HCLK, input HRESET);
    
        
endinterface : AHBIF

interface MEMIF;
//
// to and from the fifo 0 memory
//
    logic [4:0] f0_waddr;     // Fifo 0 write address
    logic [31:0] f0_wdata;      // write data
    logic f0_write;         // memory write
    logic [4:0] f0_raddr;   // memory read address
    logic [31:0] f0_rdata;  // memory read data
    

    modport F0(output f0_waddr, output f0_wdata,output f0_write,
        output f0_raddr, input f0_rdata);

endinterface : MEMIF

interface RAM128IF;
    logic [6:0] waddr;
    logic write;
    logic [31:0] wdata;
    logic [7:0] raddr,raddr1;
    logic [15:0] rdata,rdata1;

    modport R0(output write,output waddr,output wdata,
        output raddr,  input rdata,
        output raddr1, input rdata1);


endinterface : RAM128IF

interface RAM256IF;
    logic [7:0] raddr,raddr1,waddr;
    logic write;
    logic clk;
    logic [31:0] rdata,rdata1,wdata;

    modport R0(output write,output waddr,output wdata,
        output raddr,  input rdata,
        output raddr1, input rdata1);


endinterface : RAM256IF

interface LCDOUT;
    logic LCDPWR,LCDDCLK,LCDENA_LCDM;
    logic LCDFP,LCDLE,LCDLP;
    logic [23:0] LCDVD;
    logic [3:0] lcd_frame;      // which frame the gray scaler is on

    modport O0(output LCDPWR,output LCDDCLK,output LCDENA_LCDM,
        output LCDFP, output LCDLE, output LCDLP,
        output LCDVD,output lcd_frame);
        
endinterface : LCDOUT

