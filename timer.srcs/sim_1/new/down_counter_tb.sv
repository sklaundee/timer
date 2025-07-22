`timescale 1ns / 1ps


module down_counter_tb();
    logic clk_1Hz;
    logic reset;
    logic control;
    logic [3:0] tens_mins, ones_mins, tens_sec, ones_sec;
    logic [3:0] out_tensMins, out_onesMins, out_tensSec, out_onesSec;
    logic done;
    
    down_counter dut ( 
        .clk_1Hz(clk_1Hz),
        .reset(reset),
        .control(control),
        .tens_mins(tens_mins),
        .ones_mins(ones_mins),
        .tens_sec(tens_sec),
        .ones_sec(ones_sec),
        .out_tensMins(out_tensMins),
        .out_onesMins(out_onesMins),
        .out_tensSec(out_tensSec),
        .out_onesSec(out_onesSec),
        .done(done)
    );
    
    always #5 clk_1Hz = ~clk_1Hz;
    
    initial begin
        tens_mins = 4'd0;
        ones_mins = 4'd1;
        tens_sec = 4'd3;
        ones_sec = 4'd5;
        
        done = 0;
        clk_1Hz = 0;
        reset = 1;
        control = 0;
        #20
        reset = 0;
        control = 1;
        
        repeat(200) @(posedge clk_1Hz);
        $finish;
    
    end
    
endmodule
