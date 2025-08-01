`timescale 1ns / 1ps

module timer_top(
    input clk_100MHz,
    input reset,
    input on_button, //for stopwatch
    input btn_start_stop, //for alarm
    input toggle, //0: stopwatch, 1: alarm
    input [3:0] tens_mins, ones_mins, tens_sec, ones_sec,
    output [0:6] seg,
    output [3:0] digit,
    output led,
    output done_top
    );
    
    wire [0:6] seg_watch, seg_alarm;
    wire [3:0] digit_watch, digit_alarm;
    wire done_alarm;
    
    stopwatch watch(
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .on_button(on_button),
        .sseg(seg_watch),
        .digit(digit_watch)
    );
    
    alarm alrm(
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .btn_start_stop(btn_start_stop),
        .tens_mins(tens_mins),
        .ones_mins(ones_mins),
        .tens_sec(tens_sec),
        .ones_sec(ones_sec),
        .seg(seg_alarm),
        .digit(digit_alarm),
        .done(done_alarm)
    );
    
    reg mode_toggle = 0;
    reg prev_toggle = 0;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            mode_toggle <= 0;
            prev_toggle <= 0;
        end else begin
            if (toggle && !prev_toggle)
                mode_toggle <= ~mode_toggle;
            prev_toggle <= toggle;
        end
    end

     // Output multiplexer logic
    assign seg = (mode_toggle == 1'b0) ? seg_watch : seg_alarm;
    assign digit = (mode_toggle == 1'b0) ? digit_watch : digit_alarm;
    assign done_top = (mode_toggle == 1'b0) ? 1'b0 : done_alarm;  
    
    assign led = mode_toggle; //led off = stopwatch, led on = alarm
endmodule
