

package DDR3_CONTROLLER_pkg;

//   `include "uvm_macros.svh"
// Importing uvm_pkg
  import uvm_pkg::*;

   // MASTER ENV
  `include "DDR3_CONTROLLER_MASTER_req_item.sv"
  `include "DDR3_CONTROLLER_MASTER_seq_lib.sv"
  `include "DDR3_CONTROLLER_clocking_monitor.sv"
  `include "DDR3_CONTROLLER_MASTER_sequencer.sv"
  `include "DDR3_CONTROLLER_MASTER_driver.sv"
  `include "DDR3_CONTROLLER_MASTER_agent.sv"
  `include "DDR3_CONTROLLER_env.sv"
  `include "DDR3_CONTROLLER_test_lib.sv"

endpackage : DDR3_CONTROLLER_pkg

