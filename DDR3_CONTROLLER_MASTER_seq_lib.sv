
class DDR3_CONTROLLER_MASTER_seq extends uvm_sequence #(DDR3_CONTROLLER_MASTER_req_item);
  `uvm_object_utils(DDR3_CONTROLLER_MASTER_seq)

  // Class constructor
  function new(string name = "DDR3_CONTROLLER_MASTER_seq");
    super.new(name);
  endfunction : new


  DDR3_CONTROLLER_MASTER_req_item config_item;

   int fd,fh;
   logic [31:0] ad,da;
   logic [1:0]trans;
   logic [2:0]burst;
   int ahbclk,ddrclk;
   logic rw;
   int i,j;
   string typ,testname;
  
  // Modify this body() method as per project requirements
task body();
    config_item = DDR3_CONTROLLER_MASTER_req_item::type_id::create("config_item");
    rst();
    items();
  endtask : body

   virtual task items();
   if ($test$plusargs("272test="))
   begin
       $value$plusargs("272test=%s", testname); 
       fd = $fopen(testname,"r");
     while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%h %h %h %h %h %d %d",rw,ad,da,trans,burst,ddrclk,ahbclk);
            begin
            $display("ahbclk %d ddrclk %d",ahbclk,ddrclk);
            start_item(config_item);
            config_item.addr  = ad;
            config_item.data  = da;
            config_item.trans = trans;
            config_item.rw    = rw;
            config_item.burst = burst;
            config_item.reset = 0;
            config_item.ahbclk= ahbclk;
            config_item.ddrclk= ddrclk;
            finish_item(config_item);
            end 
     end 
   end   
   endtask : items


        virtual task rst();
            begin
                repeat(1)
                begin
                start_item(config_item);
                config_item.reset = 1;
                finish_item(config_item);
                end
            end 
        
        endtask : rst
        

  
endclass : DDR3_CONTROLLER_MASTER_seq

