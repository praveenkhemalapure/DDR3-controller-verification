class DDR3_CONTROLLER_clocking_monitor extends uvm_monitor #(DDR3_CONTROLLER_MASTER_req_item);
  `uvm_component_utils(DDR3_CONTROLLER_clocking_monitor)

virtual AHBIF Q;
virtual DDR3_SDRAM dd3_sdram1;
virtual DDR3_SDRAM dd3_sdram2;
virtual DDR3_SDRAM dd3_sdram3;
 
  int count,frame_count,count1,count2,ah,dd;
 
  DDR3_CONTROLLER_MASTER_req_item ck_period;
  
  
  // Declaring TLM Analysis port(s)
  uvm_tlm_analysis_fifo #(DDR3_CONTROLLER_MASTER_req_item) clocking_mon;

  
  
  // Class constructor
  function new(string name = "DDR3_CONTROLLER_clocking_monitor", uvm_component parent);
    super.new(name, parent);
    clocking_mon  = new("clocking_mon",this);
  endfunction : new

  
  
  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual DDR3_SDRAM)::get(this,"*","dd3_sdram1",dd3_sdram1))
      `uvm_fatal("**ERROR DDR3_CONTROLLER_clocking_monitor build phase", "Virtual interface was not received")
    if(!uvm_config_db#(virtual DDR3_SDRAM)::get(this,"*","dd3_sdram2",dd3_sdram2))
      `uvm_fatal("**ERROR DDR3_CONTROLLER_clocking_monitor build phase", "Virtual interface was not received")
    if(!uvm_config_db#(virtual DDR3_SDRAM)::get(this,"*","dd3_sdram3",dd3_sdram3))
      `uvm_fatal("**ERROR DDR3_CONTROLLER_clocking_monitor build phase", "Virtual interface was not received")
    if(!uvm_config_db#(virtual AHBIF)::get(this,"*","Q",Q))
      `uvm_fatal("**ERROR DDR3_CONTROLLER_clocking_monitor build phase", "Virtual interface was not received")
    
    ck_period = DDR3_CONTROLLER_MASTER_req_item :: type_id :: create("ck_period");
  endfunction : build_phase
  
  
task run_phase(uvm_phase phase);
begin
    Q.HCLK        <= 0;
    dd3_sdram1.ck <= 0;
    dd3_sdram2.ck <= 0;
    dd3_sdram3.ck <= 0;
    ah=2000;
    dd=1000;
    fork
        forever
        begin
            collect();
        end
        forever
        begin
            drive_clk1(ah);
        end
        forever
        begin
            drive_clk2(dd);
        end
        forever
        begin
            drive_clk3(dd);
        end
        forever
        begin
            drive_clk4(dd);
        end
    join_none
end 
endtask : run_phase



task collect();
begin
            clocking_mon.get(ck_period);
            ah = ck_period.ahbclk;
            dd = ck_period.ddrclk;

end
endtask


task drive_clk1(int ahbclk);
begin
    #(ahbclk/2) Q.HCLK        <= ~Q.HCLK;
end
endtask


task drive_clk2(int ddrclk);
begin
    #(ddrclk/2) dd3_sdram1.ck <= ~dd3_sdram1.ck;
end
endtask

task drive_clk3(int ddrclk);
begin
    #(ddrclk/2) dd3_sdram2.ck <= ~dd3_sdram2.ck;
end
endtask

task drive_clk4(int ddrclk);
begin
    #(ddrclk/2) dd3_sdram3.ck <= ~dd3_sdram3.ck;
end
endtask


endclass

