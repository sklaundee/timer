`timescale 1ns/1ps

module oneHz_generator_tb();
    logic clk;
    logic reset;
    logic on;
    logic enable_1Hz;

    // Instantiate DUT
    oneHz_generator #(.MAX_COUNT(5)) dut( //the max count is really small in simulation to show when the seven segment display would be updated 
        .clk_100MHz(clk),
        .reset(reset),
        .on(on),
        .enable_1Hz(enable_1Hz)
    );

    // Clock generator: 100 MHz = 10 ns period
    always #5 clk = ~clk;
    
    int pulse_count = 0;
    always @(posedge clk) begin
        if (enable_1Hz) begin
            pulse_count++;
            $display("Time: %0t ns - Pulse #%0d detected from DUT", $time, pulse_count);
        end
    end
    
    initial begin 
        clk = 0;
        reset = 1;
        on = 0; 
        repeat(5) @(posedge clk);
        reset = 0; 
        
        $display("Starting simulation at time: %0t ns", $time);
      
        #1000
        on = 1;
        repeat(35000000) @(posedge clk);
        
       $display("Simulation complete. Total pulses detected: %0d", pulse_count);
       $finish;
    end 
endmodule
