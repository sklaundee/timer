`timescale 1ns/1ps

module stopwatch_tb();
    logic clk_100MHz;
    logic reset;
    logic on_button;
    logic [0:6] sseg;
    logic [3:0] digit;
    
    stopwatch dut (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .on_button(on_button),
        .sseg(sseg),
        .digit(digit)
    );
    
    // Clock generator: 100 MHz = 10 ns period
    always #5 clk_100MHz = ~clk_100MHz;
    
    logic [3:0] w_1s, w_10s, w_100s, w_1000s;
    assign w_1s = dut.digs.ones;
    assign w_10s = dut.digs.tens;
    assign w_100s = dut.digs.hundreds;
    assign w_1000s = dut.digs.thousands;
    
    initial begin
        clk_100MHz = 0;
        reset = 1;
        on_button = 0; 
        
        repeat(5) @(posedge clk_100MHz);
        reset = 0; 
        
        $display("Starting simulation at time: %0t ns", $time);
        #1000
        on_button = 1;
        #20
        on_button = 0;
        repeat(200_000_000) @(posedge clk_100MHz);
        
        on_button = 1; //pause simulation
        #20
        on_button = 0;
        repeat(100_000_000) @(posedge clk_100MHz);
        $display("Final Time = %0d%0d%0d%0d", w_1000s, w_100s, w_10s, w_1s); 
        $finish;
    end 
    
    always @(posedge clk_100MHz)
        if(dut.w_1Hz)
            $display("Count = %0d%0d%0d%0d @ %0t ns", w_1000s, w_100s, w_10s, w_1s, $time);
endmodule