
class DDR3_CONTROLLER_env extends uvm_env;
  
  DDR3_CONTROLLER_MASTER_agent MASTER_agent;
  
  
  `uvm_component_utils_begin(DDR3_CONTROLLER_env)
    `uvm_field_object(MASTER_agent,UVM_ALL_ON)
  `uvm_component_utils_end
  
  

  // Class constructor
  function new(string name = "DDR3_CONTROLLER_env", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    MASTER_agent = DDR3_CONTROLLER_MASTER_agent::type_id::create("MASTER_agent",this);
  endfunction : build_phase

  // UVM Connect Phase
  virtual function void connect_phase(uvm_phase phase);
  endfunction : connect_phase

endclass : DDR3_CONTROLLER_env

