

class DDR3_CONTROLLER_MASTER_driver extends uvm_driver #(DDR3_CONTROLLER_MASTER_req_item);
  `uvm_component_utils(DDR3_CONTROLLER_MASTER_driver)

  virtual AHBIF Q;
    
  // Declare all local fields here;
    logic [2:0] states;
    int config_items [*];
    int num_elements;
    int addr[int];
    logic [31:0]count,number;
    int fh,fd,ad,da,add,cnt;
    string typ;
    logic statuss;

    uvm_analysis_port #(DDR3_CONTROLLER_MASTER_req_item) clock_port;
    
    
  // Class constructor
  function new(string name = "DDR3_CONTROLLER_MASTER_driver", uvm_component parent);
    super.new(name, parent);
    clock_port = new("clock_port",this);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual AHBIF)::get(this,"*","Q",Q))
      `uvm_fatal("**ERROR DDR3_CONTROLLER_MASTER_driver build phase", "Virtual interface was not received")
  endfunction : build_phase
 
 
 logic [31:0]data;
 
 virtual task run_phase(uvm_phase phase);
 begin
		DDR3_CONTROLLER_MASTER_req_item mem_item;
		mem_item = DDR3_CONTROLLER_MASTER_req_item::type_id::create("mem_item"); 
 		seq_item_port.get_next_item(mem_item);
 		$display("hello clk %d",mem_item.ahbclk);
 		clock_port.write(mem_item);
	forever
	begin
		
		if (mem_item.reset == 1)
		begin
			Q.mHADDR  <=  0;
			Q.mHWRITE <=  0;
			Q.mHTRANS <=  0;
			data      <=  0;
			Q.mHWDATA <=  0;
			Q.HRESET  <=  1; 
     		seq_item_port.item_done();			
     		seq_item_port.get_next_item(mem_item);
     		clock_port.write(mem_item);
		end
		else
            @(posedge Q.HCLK)

		begin

		if (Q.mHREADY==1)
		begin
            Q.HRESET  <=  #1 mem_item.reset;
			Q.mHADDR  <=  #1 mem_item.addr;
			Q.mHWRITE <=  #1 mem_item.rw;
			data      <=  mem_item.data;
			Q.mHWDATA <=  #1 data;
			Q.mHBURST <=  #1 mem_item.burst;
			Q.mHTRANS <=  #1 mem_item.trans;
			seq_item_port.item_done();
			seq_item_port.get_next_item(mem_item);
     		clock_port.write(mem_item);
		end
		else
		begin
			Q.mHTRANS <=  #1 Q.mHTRANS;		
		end 
		end
	end
end

endtask : run_phase

endclass : DDR3_CONTROLLER_MASTER_driver

