`timescale 1ns/1ps

module digits_tb();
    logic clk, reset;
    logic [3:0] ones, tens, hundreds, thousands;
    
    //Instantiate DUT
    digits dut(
        .clk_1Hz(clk), 
        .reset(reset), 
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands)
        );
        
        //Clock generator: 100MHz = 10ns period
        always #5 clk = ~clk;
        
        initial begin 
            clk = 0;
            reset = 1;
            
            repeat (5) @(posedge clk);
            reset = 0;
            
            $display("Starting simulation at time: %0t ns", $time);
            repeat(500000) @(posedge clk);
            
            $display("Simulation complete");
            $finish;
        end 
endmodule