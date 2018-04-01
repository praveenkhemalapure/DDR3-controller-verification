
class DDR3_CONTROLLER_MASTER_sequencer extends uvm_sequencer #(DDR3_CONTROLLER_MASTER_req_item);
  `uvm_component_utils(DDR3_CONTROLLER_MASTER_sequencer)

  // Class constructor
  function new(string name = "DDR3_CONTROLLER_MASTER_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : DDR3_CONTROLLER_MASTER_sequencer

