`timescale 1ns / 1ps

module timer_top_tb;

    logic clk_100MHz = 0;
    logic reset;
    logic on_button;
    logic btn_start_stop;
    logic btnC;
    logic [3:0] tens_mins, ones_mins, tens_sec, ones_sec;
    logic [0:6] seg;
    logic [3:0] digit;
    logic led;
    logic done;
    
    timer_top dut (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .on_button(on_button),
        .btn_start_stop(btn_start_stop),
        .btnC(btnC),
        .tens_mins(tens_mins),
        .ones_mins(ones_mins),
        .tens_sec(tens_sec),
        .ones_sec(ones_sec),
        .seg(seg),
        .digit(digit),
        .led(led),
        .done(done)
    );

    // Clock generation: 100 MHz = 10 ns period
    always #5 clk_100MHz = ~clk_100MHz;
    initial begin

        reset = 1;
        on_button = 0;
        btn_start_stop = 0;
        btnC = 0;
        tens_mins = 4'd0;
        ones_mins = 4'd0;
        tens_sec  = 4'd0;
        ones_sec  = 4'd5;  

        
        #100;
        reset = 0;

        #100;
        on_button = 1;
        #20;
        on_button = 0;

        // Run stopwatch for a short period
        repeat (10_000_000) @(posedge clk_100MHz); // ~100ms

        // Press on_button to stop
        on_button = 1;
        #20;
        on_button = 0;

       
        #100;
        btnC = 1;
        #20;
        btnC = 0;

        // Start countdown
        #100;
        btn_start_stop = 1;
        #20;
        btn_start_stop = 0;

        
        repeat (700_000_000) @(posedge clk_100MHz); // ~7s simulated

        $display("Finished Simulation at %0t ns", $time);
        $finish;
    end

endmodule
