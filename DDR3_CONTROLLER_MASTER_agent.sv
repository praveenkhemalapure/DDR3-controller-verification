
class DDR3_CONTROLLER_MASTER_agent extends uvm_agent;

  DDR3_CONTROLLER_MASTER_sequencer sequencer;
  DDR3_CONTROLLER_MASTER_driver    driver;
  DDR3_CONTROLLER_clocking_monitor monitor;
//  uvm_active_passive_enum   is_active;

  `uvm_component_utils_begin(DDR3_CONTROLLER_MASTER_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end

  // Class constructor
  function new(string name = "DDR3_CONTROLLER_MASTER_agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
//    if (is_active == UVM_ACTIVE) begin
      sequencer = DDR3_CONTROLLER_MASTER_sequencer::type_id::create("sequencer",this);
      driver    = DDR3_CONTROLLER_MASTER_driver::type_id::create("driver",this);
//    end
      monitor = DDR3_CONTROLLER_clocking_monitor::type_id::create("monitor",this);
  endfunction : build_phase

  // UVM Connect Phase
  virtual function void connect_phase(uvm_phase phase);
//    if (is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      driver.clock_port.connect(monitor.clocking_mon.analysis_export);
//    end
  endfunction : connect_phase

endclass : DDR3_CONTROLLER_MASTER_agent

