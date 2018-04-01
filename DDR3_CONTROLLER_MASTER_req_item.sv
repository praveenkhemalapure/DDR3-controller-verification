

class DDR3_CONTROLLER_MASTER_req_item extends uvm_sequence_item;

  logic [31:0] addr;
  logic [31:0] data;
  logic [1:0] trans;
  logic [2:0] burst;
   int  ahbclk;
   int  ddrclk;
  logic rw;
  
  string cha;
  int configel;
  logic reset;
  
  `uvm_object_utils_begin(DDR3_CONTROLLER_MASTER_req_item)
    // Factory Register all your sequence item fields here
    // Example:
    // `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_int(addr, UVM_ALL_ON)
     `uvm_field_string(cha, UVM_ALL_ON)
    `uvm_object_utils_end

  // Class constructor
  function new(string name = "DDR3_CONTROLLER_MASTER_req_item");
    super.new(name);
  endfunction : new


endclass : DDR3_CONTROLLER_MASTER_req_item

