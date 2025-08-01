`timescale 1ns / 1ps

module alarm( //top level module for the "alarm" portion of the timer
    input clk_100MHz, 
    input reset, 
    input btn_start_stop, 
    input [3:0] tens_mins, ones_mins, tens_sec, ones_sec,
    output [0:6] seg,
    output [3:0] digit,
    output done
    );
    
    reg control = 0;
    reg prev_button = 0;
    
    wire clk_1Hz;
    wire [3:0] tensM, onesM, tensS, onesS;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            control <= 0; 
            prev_button = 0;
        end else begin
            if (btn_start_stop && !prev_button)
                control <= ~control;
            prev_button <= btn_start_stop;
        end
    end
    
    oneHz_generator oneHz(
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .on(control),
        .enable_1Hz(clk_1Hz)
    );
    
    down_counter dcount(
        .clk_1Hz(clk_1Hz),
        .reset(reset),
        .control(control),
        .tens_mins(tens_mins),
        .ones_mins(ones_mins),
        .tens_sec(tens_sec),
        .ones_sec(ones_sec),
        .out_tensMins(tensM),
        .out_onesMins(onesM),
        .out_tensSec(tensS),
        .out_onesSec(onesS),
        .done(done)
    );
    
    sseg_control segCtrl(
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .ones(onesS),
        .tens(tensS),
        .hundreds(onesM),
        .thousands(tensM),
        .seg(seg),
        .digit(digit)
    );
    
endmodule
