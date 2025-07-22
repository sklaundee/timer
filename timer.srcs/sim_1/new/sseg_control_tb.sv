`timescale 1ns/1ps

module sseg_control_tb();
    
    logic clk, reset;
    logic [3:0] ones, tens, hundreds, thousands;
    logic [0:6] seg;
    logic [3:0] digit;
    
    //Instantiate DUT
    sseg_control dut(
        .clk_100MHz(clk),
        .reset(reset),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .seg(seg),
        .digit(digit)
    );
    
    //Clock generator: 100MHz = 10ns period
    always #5 clk = ~clk; 
    
    initial begin
        clk = 0;
        reset = 1;
        ones = 4'd3;
        tens = 4'd2;
        hundreds = 4'd1;
        thousands = 4'd0;
        
        repeat (5) @(posedge clk);
            reset = 0;
            
            $display("Starting simulation at time: %0t ns", $time);
            repeat(500000) @(posedge clk);
            
            $display("Simulation complete");
            $finish;
        end 
    
endmodule