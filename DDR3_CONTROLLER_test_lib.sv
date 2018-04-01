
// This is DDR3_CONTROLLER_base_test class
class DDR3_CONTROLLER_base_test extends uvm_test;

  `uvm_component_utils(DDR3_CONTROLLER_base_test)

  DDR3_CONTROLLER_env env;
  DDR3_CONTROLLER_MASTER_agent MASTER_agent;
  DDR3_CONTROLLER_MASTER_seq config_seq;
  

  
  
  // Class constructor
  function new(string name = "DDR3_CONTROLLER_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction : new


  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = DDR3_CONTROLLER_env::type_id::create("env",this);
    config_seq = DDR3_CONTROLLER_MASTER_seq :: type_id :: create ("config_seq",this);
            $display("hello master");

  endfunction : build_phase

  
   virtual function void connect_phase(uvm_phase phase);
//   lcd_score.DDR3_CONTROLLER_output_score_port.connect(lcd_score.moni_out.analysis_export);  
    endfunction : connect_phase 
  
  
  // UVM End_of_Elaboration Phase
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  // UVM Start_of_simulation Phase
  virtual function void start_of_simulation_phase(uvm_phase phase);
    uvm_test_done.set_drain_time(this,100ns);
  endfunction : start_of_simulation_phase

  
  
  
  
  // UVM Run Phase
  virtual task run_phase(uvm_phase phase);
  begin
    phase.raise_objection(this);
        config_seq.start(env.MASTER_agent.sequencer);
        #1000000000;
    phase.drop_objection(this);
    end
  endtask : run_phase
  
  
  
endclass : DDR3_CONTROLLER_base_test



