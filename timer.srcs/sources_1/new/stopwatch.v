`timescale 1ns / 1ps

module stopwatch( //top level module for the "stopwatch" portion of the timer
    input clk_100MHz,
    input reset,
    input on_button,
    output [0:6] sseg,
    output [3:0] digit
    );
    
    wire w_1Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    
    reg on = 0;
    reg prev_button = 0;
    
    always @(posedge clk_100MHz or posedge reset) begin 
        if (reset) begin
            on <= 0;
            prev_button <= 0;
        end else begin
            if (on_button && !prev_button) begin
                on <= ~on;
                prev_button <= on_button;
            end
        end
    end
    
    oneHz_generator #(.MAX_COUNT(9_999_999)) hz1 ( //instead of 1Hz, the stopwatch will have a 0.1Hz clock for increased accuracy
    .clk_100MHz(clk_100MHz), 
    .reset(reset), 
    .on(on), 
    .enable_1Hz(w_1Hz)
    );
    
    digits digs(
    .clk_1Hz(w_1Hz), 
    .reset(reset), 
    .ones(w_1s), 
    .tens(w_10s), 
    .hundreds(w_100s), 
    .thousands(w_1000s)
    );
    
    sseg_control seg7(
    .clk_100MHz(clk_100MHz), 
    .reset(reset), 
    .ones(w_1s), 
    .tens(w_10s),
    .hundreds(w_100s),
    .thousands(w_1000s), 
    .seg(sseg), 
    .digit(digit)
    );
    
endmodule
